#!/usr/bin/env python
# -*- coding: utf-8 -*-
import xml.etree.ElementTree as et
import logging as log
import os.path
import fnmatch
import argparse
import xlsxwriter

from datetime import datetime as dt

# List of systems that are not to be exported.
skipped_systems = ['retropie', 'kodi']

# Set up logging using the logging module.
log.basicConfig(level=log.INFO, format=u"%(asctime)s %(levelname)-6s %(message)s")
logger = log.getLogger(__name__)


def get_xml_element_text(xml, node_name):

    if xml.find(node_name) is None:
        return ""
    else:
        return xml.find(node_name).text


def is_number(s):

    try:
        int(s)
        return True
    except:
        return False


def is_float(s):

    try:
        float(s)
        return True
    except:
        return False


def get_xml_element_bool(xml, node_name):
    """
    Returns either yes or None, depending on the value of the @parm node_name.
    """
    if xml.find(node_name) is None:
        return None

    elif xml.find(node_name).text.lower() == "false" or xml.find(node_name).text.lower() == "no":
        return None

    else:
        return "yes"


def get_xml_element_date(xml, node_name):
    """
    Returns a DateTime or a String, depending on the value of the @parm node_name.
    """
    ES_TIME_FORMAT = "%Y%m%dT%H%M%S"

    if not xml.find(node_name) is None and not xml.find(node_name).text is None:
        date_text = xml.find(node_name).text
        # Release date can appear as both ISO date or just as an year.
        # If it's an ISO date, then try to convert it, otherwise just return the text
        if len(date_text) < len('19860101T000000'):
            return date_text
        else:
            try:
                date = dt.strptime(xml.find(node_name).text, ES_TIME_FORMAT)
                return date
            except ValueError:
                return date_text
    else:
        return None


def get_xml_element_int(xml, node_name):
    """
    Returns None or a Number, depending on the value of the @parm.
    """
    if xml.find(node_name) is None:
        return None

    else:
        try:
            return int(xml.find(node_name).text)
        except ValueError:
            return xml.find(node_name).text
        except TypeError:
            return None


class System(object):
    """
    Class that models an ES System, storing the attributes of the System and its list of Games
    """
    info_keys = ("name", "fullname", "path", "platform", "extension")

    def __init__(self, xml):
        self.info = dict.fromkeys(System.info_keys)
        self.games = []  # List of games

        for key in System.info_keys:
            self.info[key] = get_xml_element_text(xml, key)

    def __str__(self):
        return str(self.info['fullname'] + " (" + self.info['platform'] + "), path: " +
                   self.info['path'] + ", games: " + str(len(self.games)))

    @staticmethod
    def get_collection(collection_name):

        o = System.__new__(System)
        o.name = collection_name
        o.fullname = collection_name
        o.games = []

        return o


class Game:
    info_keys = ("name", "path", "publisher", "developer", "genre", "players", "rating")
    info_desc = ("desc")
    info_bool = ("favorite", "kidgame", "hidden")
    info_date = ("releasedate", "lastplayed")
    info_int = ("playcount",)

    @staticmethod
    def get_headers():
        return (Game.info_keys + Game.info_date + Game.info_bool + Game.info_int)

    def __init__():
        self.info = dict.fromkeys(Game.get_headers())

    def __init__(self, obj):
        self.info = dict.fromkeys(Game.info_keys)

        # Get the text metadata
        for attr in self.info.keys():
            self.info[attr] = get_xml_element_text(obj, attr)

        # Get the date metadata
        for attr in Game.info_date:
            self.info[attr] = get_xml_element_date(obj, attr)

        # Get the boolean metadata
        for attr in Game.info_bool:
            self.info[attr] = get_xml_element_bool(obj, attr)

        # Get the integer metadata
        for attr in Game.info_int:
            self.info[attr] = get_xml_element_int(obj, attr)

        # Get the description
        self.info["desc"] = get_xml_element_text(obj, "desc")

    def __str__(self):
        return str("{0}\t{1}".format(self.info["name"]), str(self.info["path"]))


# The gamelist.xml can be found in
# * ROM folder for the system
# * $HOME/.emulationstation/gamelists/$name
def get_gamelist(system, rom_folder):
    rom_folder_gamelist = rom_folder + "/gamelist.xml"
    es_folder_gamelist = "{0}/.emulationstation/gamelists/{1}/gamelist.xml".format(
        os.environ['HOME'], system)

    if os.path.isfile(rom_folder_gamelist):
        return rom_folder_gamelist
    elif os.path.isfile(es_folder_gamelist):
        return es_folder_gamelist
    else:
        return None


def check_rom(rom_folder, rom_path):
    """
    Method to check if a ROM is present in the filesystem.
    Returns true if the ROM is present, false otherwise.
    """
    # The Rom path in the gamelist might be absolute or relative.
    # Check if the path begins with an '/' to decide if it's an absolute path.
    path_to_check = rom_path

    if not rom_path.startswith('/'):
        path_to_check = rom_folder + "/" + rom_path

    return os.path.isfile(path_to_check) or os.path.isdir(path_to_check)

def get_rom_path(rom_folder, rom_path):

    path_to_check = rom_path;

    if not rom_path.startswith('/'):
        path_to_check = rom_folder + "/" + rom_path

    return os.path.realpath(path_to_check)


def get_roms_in_collection(rom_path_list, all_games):
    """
    Produce a list of Game objects, from
     @rom_path - a list of ROM paths
     @all_games - a list of all Game objects.
    """

    roms = []

    for rom in all_games:
        if rom.info['realpath'] in rom_path_list:
            logger.debug("Found game %s at path %s", rom.info['name'], rom.info['realpath'])
            roms.append(rom)

    return roms


def skip_system(system_name):
    return str(system_name).upper() in map(lambda x: x.upper(), skipped_systems)

    # Parsing the 'es_systems.cfg' file, from either $HOME/.emulationstation or /etc/emulationstaton


def parse_systems():

    es_system_file = '/etc/emulationstation/es_systems.cfg'
    systems = []

    if os.path.isfile(os.environ['HOME'] + "/.emulationstation/es_systems.cfg"):
        es_system_file = os.environ['HOME'] + "/.emulationstation/es_systems.cfg"

    logger.info("Emulationstation systems file used: " + es_system_file)

    # Parse the Emulationstation systems file
    sys = et.parse(es_system_file)

    for system in sys.getroot().findall('system'):
        s = System(system)

        if s.info['path'] is None or s.info['name'] is None:
            logger.debug(u"System {0} has no path or name, skipping".format(s.info['fullname']))
            continue

        if skip_system(s.info['name']):
            logger.info(u"System {0} is skipped as configured".format(s.info['fullname']))
            continue

        # Try to open and parse the gamelist for this system.
        logger.debug(u"Analyzing system: %s (%s)",s.info['fullname'], s.info['name'])

        try:
            gamelist_path = get_gamelist(s.info['name'], s.info['path'])

            if gamelist_path is None:
                logger.debug("%s system has no gamelist, skipping",s.info['fullname'])
                continue

            logger.debug("Gamelist for %s is read from %s", s.info['name'], gamelist_path);
            gamelist = et.parse(gamelist_path)
        except IOError:
            logger.warn("Could not open the gamelist for " + s.info['name'] + ", skipping !")
            continue

        # Ok, we have the gamelist, get each game and parse it.
        for game in gamelist.getroot().findall('game'):
            rom = Game(game)

            # Check if the ROM/Game file is on disk. Add it to the list only of it exists.
            if check_rom(s.info['path'], rom.info['path']):
                s.games.append(rom)
                # Get the ROM's real path, to handle custom collections
                rom.info['realpath'] = get_rom_path(s.info['path'], rom.info['path'])
            else:
                logger.debug("ROM %s not found in %s, removed from export",rom.info['name'], s.info['path'])

        # Show how many games we have on the system
        logger.debug("Found %d game(s) for %s %s", len(s.games), s.info['fullname'], s.info['name'])

        # If we have more than 1 ROM in the system, add it to the exported list
        if len(s.games) > 0:
            systems.append(s)
        else:
            logger.debug(
                "System %s has no games/roms, it's excluded from the export", s.info['name'])

    return systems

def parse_custom_collections():
    """
    Tries to find the custom ES defined collections, which should be under $HOME/.emulationstation/collections
    Each collection is a file named 'custom-XYZ.cfg', which contains a list of ROM paths. 
    Open each .cfg file and read the list of paths.

    Return a dict containing
        - the collection name
        - the corresponging list of ROM paths. 
    """
    collections = {}

    logger.debug("Trying to find custom collections")
    custom_collections_folder = "{0}/.emulationstation/collections".format(os.environ['HOME'])
    if not os.path.isdir(custom_collections_folder):
        logger.info("No custom collection folder found, skipping")
        return

    for file in os.listdir(custom_collections_folder):
        cfg_path = custom_collections_folder + '/' + file;

        if fnmatch.fnmatch(file, 'custom-*.cfg') and os.path.isfile(cfg_path):
            collection_name = file.replace('custom-', '').replace('.cfg', '').capitalize()
            logger.info("Found collection %s", collection_name)

            if len(collection_name) > 31:
                logger.warn("Collection %s name too long, truncating to 31 chars", collection_name)
                collection_name = collection_name[:31]

            # OK, we have the file, open it and get it line by line
            try:
                cfg_file = open(cfg_path, "r")
                roms = cfg_file.readlines()
                logger.debug("Found %d roms in collection %s", len(roms), collection_name)
                # Add the collection in the dict, with the list of roms as value.
                # Since the realines() method above will return the name of ROM followed by a '\n'
                #  run a map over the list of ROMs to remove any stray '\n'
                collections[collection_name] = list(map(lambda r: r.strip('\n'), roms))
            except Exception:
                logger.warn("Cannot read collection file %s", file)


    return collections


# Export the system list to excel
def xlsx_export_workbook(systems, output='export.xlsx', custom_collections=None):

    if not len(systems):
        raise "Exported system list is empty"
        return

    # Special collections. Some of them might be empty
    # * All games
    # * Favorite games
    # * Kid games
    all_collection = System.get_collection('all')
    fav_collection = System.get_collection('favorite')
    kid_collection = System.get_collection('kid')

    # Create the Workbook
    wb = xlsxwriter.Workbook(output,
                             {'default_date_format': 'dd-mm-yyyy',
                              'in_memory': True,
                              })

    # Add some metadata to it
    wb.set_properties({
        'title': 'Game List Export',
        'subject': 'Emulationstation Games',
        'category': 'Gaming',
        'author': "XlsxWriter (github.com/jmcnamara/XlsxWriter), version " + xlsxwriter.__version__,
        'comments': 'This is a complete list of games registered in Emulationstation.\nDocument produced on ' + dt.now().strftime("%c") +
        '\nSystems: ' +
        ', '.join(list(sorted(set(map(lambda system: system.info['fullname'], systems)))))
    })

    wb.set_custom_property('Date Exported', dt.now())

    fmt_bold = wb.add_format({'bold': True})
    fmt_bold_2 = wb.add_format({'bold': True, 'bg_color': 'red', 'color': 'white'})
    fmt_sys_header = wb.add_format({'bold': True, 'bg_color': 'green', 'color': 'white'})
    fmt_fav_row = wb.add_format({'bg_color': '#FFCC7C'})

    # Add a summary sheet as the 1st sheet in the workbook
    start = wb.add_worksheet("Summary")
    start.write_row(0, 0, ("System", "Total"), fmt_bold_2)
    start.set_tab_color('blue')
    start.set_column(0, 0, 50)

    # Add special collection sheets
    all_sheet = wb.add_worksheet("All")
    all_sheet.set_tab_color('green')

    fav_sheet = wb.add_worksheet("Favorites")
    fav_sheet.set_tab_color("yellow")

    kid_sheet = wb.add_worksheet("Kid Games")
    kid_sheet.set_tab_color('pink')

    custom_sheets = {}
    if len(custom_collections)>0 :
        logger.debug("Adding custom collections to export")

        for collection in custom_collections:
            if len(custom_collections[collection]) > 0:
                logger.debug("Exporting custom collection %s", collection)
                s = wb.add_worksheet(collection)
                s.set_tab_color("gray")
                custom_sheets[collection] = s

    # The table headers for the each system's sheet
    table_headers = list(map(lambda x: {'header': str(x).capitalize()}, Game.get_headers()))

    for i, s in enumerate(systems):

        # Add a worksheet for each system.
        b = wb.add_worksheet(s.info['name'])

        # Create a table with each system and the # of games detected in each system.
        # Make the system column be a link to the sheet with the system games.
        start.write_url(i+1, 0, "internal:'" + s.info['name'] + "'!A1",
                        string=u"{0} ({1})".format(s.info['fullname'], s.info['name'])
                        )
        start.write(i+1, 1, len(s.games))

        # Print the table header
        b.set_column(0, 0, 50)

        # By default, don't add an auto-filter unless we have some records.
        auto_filter_v = False

        if len(s.games)>0:
            auto_filter_v = True


        t = b.add_table(0, 0, len(s.games), len(Game.get_headers()) - 1,
                        {
            'style': 'Table Style Medium 7',
            'columns': table_headers,
            # The name of the Table should only containt letters + numbers.
            # 'name'c: s.info["name"].replace('[^[a-zA-Z0-9]', ''),
            'autofilter': auto_filter_v,
            'banded_rows': False,
        })

        # Print the table rows
        for j, g in enumerate(s.games):

            xlsx_export_system_row(wb, b, j+1, g)

            # Add the game to the 'All' collection
            g.info["system"] = s.info["name"]
            all_collection.games.append(g)

            # Check if the game goes into another special collection (favorites, kidgames)
            if g.info["favorite"]:
                fav_collection.games.append(g)

            if g.info["kidgame"]:
                kid_collection.games.append(g)

        # Hide the 'Path' column (2nd one)
        b.set_column('B:B', None, None, {'hidden': True})
        # Set the size for the Release Date, Last played
        b.set_column('H:H', 12)
        b.set_column('I:I', 12)

    # Add a total row on the start sheet
    start.write(len(systems)+1, 0, "Total", fmt_bold)
    start.write_formula(len(systems)+1, 1, "=SUM(B1:B" + str(len(systems) + 1) + ")",
                        fmt_bold,
                        sum(map(lambda system: len(system.games), systems)))

    # Write the special Collection (All, Kid Games, Favorites)
    special_collections = (
        (all_sheet, all_collection, "All"),
        (fav_sheet, fav_collection, "Favorites"),
        (kid_sheet, kid_collection, "KidGames")
    )

    for (sheet, collection, name) in special_collections:
        sheet.set_column(0, 0, 20)  # System column size
        sheet.set_column(1, 1, 50)  # Game name column size

        # Check if the collection has any games at all before exporting it
        logger.debug("Special collection %s has %s games", name, len(collection.games))
        if len(collection.games) < 1:
            logger.info("Special collection %s has no games, sheet will be empty", name)
            continue

        t = sheet.add_table(0, 0, len(collection.games), len(Game.get_headers()),
                            {
            'style': 'Table Style Light 9',
            'columns': [{'header': "System"}] + table_headers,
            # 'name': name
        })

        for j, g in enumerate(collection.games):
            xlsx_export_system_row(wb, sheet, j+1, g, g.info["system"])

        # hide the Path column and set the size for Release date and LastPlayed
        sheet.set_column('C:C', None, None, {'hidden': True})
        sheet.set_column('I:I', 12)
        sheet.set_column('J:J', 12)


    # Write the Custom Collections
    for c in custom_sheets:
        logger.debug("Writing custom collection %s", c)
        # Produce a list of Game objects based on the paths of ROMs
        rom_list = get_roms_in_collection(custom_collections[c], all_collection.games)
        logger.debug("Should write %d games to %s collection", len(rom_list), c)

        # Ok, write the info in the custom collection worksheet
        s = custom_sheets[c]
        logger.debug("Adding custom collection in sheet %s", s.get_name())
        s.set_column(0, 0, 20)  # System column size
        s.set_column(1, 1, 50)  # Game name column size

        t = s.add_table(0, 0, len(rom_list), len(Game.get_headers()),
                            {
            'style': 'Table Style Light 9',
            'columns': [{'header': "System"}] + table_headers,
            # 'name': c # TODO: check if the collection name is a valid table name
        })

        for j, g in enumerate(rom_list):
            xlsx_export_system_row(wb, s, j+1, g, g.info["system"])

        # hide the Path column and set the size for Release date and LastPlayed
        s.set_column('C:C', None, None, {'hidden': True})
        s.set_column('I:I', 12)
        s.set_column('J:J', 12)


    # Close the workbook
    wb.close()


def xlsx_export_system_row(workbook, sheet, row_number, game, system_name=None):
    fmt_fav = workbook.add_format({'align': 'center'})

    # On special collections, 1st column is the name of the system where the game belongs
    # Only shown when set.
    if system_name is not None:
        sheet.write(row_number, 0, system_name)
        offset = 1
    else:
        offset = 0

    for column, header in enumerate(Game.get_headers()):

        if header in Game.info_date and type(game.info[header]).__name__ == "datetime":
            sheet.write_datetime(row_number, column + offset, game.info[header])

        elif header in ('playcount', 'players') and is_number(game.info[header]):
            sheet.write_number(row_number, column + offset, int(game.info[header]))

        elif header in ('rating',) and is_float(game.info[header]):
            sheet.write_number(row_number, column + offset, float(game.info[header]))

        elif header.lower() in ('favorite', 'kidgame', 'hidden'):
            sheet.write(row_number, column + offset, game.info[header], fmt_fav)

        else:
            sheet.write(row_number, column + offset, game.info[header])

        # If we're on the 'All' sheet, add the description of the game in the cell comments
        if sheet.get_name().lower() == "all" and header.lower() == "name" and not (game.info['desc'] is None or len(game.info['desc']) < 1):
            sheet.write_comment(row_number, column + offset,
                                game.info['desc'], {'x_scale': 4, 'y_scale': 4})


def parse_arguments():
    parser = argparse.ArgumentParser(
        description='Export Emulationstation gamelist files to an Excel file')
    parser.add_argument('output', nargs='?',
                        default="export_" + dt.now().strftime("%d-%m-%Y") + ".xlsx",
                        help="Export file (default is 'export_" + dt.now().strftime("%d-%m-%Y") + ".xlsx')")
    parser.add_argument('-d', '--debug', action='store_true',
                        help="run script with with debug info", default=False)


    args = parser.parse_args()
    return (args.output, args.debug)


if __name__ == "__main__":
    # Parse arguments
    (output, debug) = parse_arguments()

    # Set logging level; default is INFO, add debugging if requested via parameter
    if debug:
        logger.setLevel(log.DEBUG)

    logger.debug("Starting")
    systems = parse_systems()
    collections = parse_custom_collections();

    # See how many games we have
    total_games = sum(map(lambda system: len(system.games), systems))

    logger.info("Total games after parsing gamelist files - " + str(total_games))
    logger.info("Exporting to file %s",output)

    xlsx_export_workbook(systems, output, collections)

    logger.debug("Finished")
