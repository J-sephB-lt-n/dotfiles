-- make these available by adding `require("config.user_commands")` to nvim/init.lua
local function init_html_new()
  local lines = {
    "<!DOCTYPE html>",
    '<html lang="en">',
    "<head>",
    '\t<meta charset="UTF-8">',
    '\t<meta name="viewport" content="width=device-width, initial-scale=1.0">',
    '\t<meta http-equiv="X-UA-Compatible" content="ie=edge">',
    "\t<title>This title appears in browser title bar and in search results</title>",
    '\t<link rel="stylesheet" href="./style.css">',
    '\t<link rel="icon" href="./favicon.ico" type="image/x-icon">',
    "</head>",
    "<body>",
    "</body>",
    "<footer>",
    "\t<p>&copy; 2069 Joe&apos;s website</p>",
    "</footer>",
    '<script src="index.js"></script>',
    "</html>",
  }
  local buf = vim.api.nvim_get_current_buf()
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  vim.api.nvim_buf_set_lines(buf, row, row, false, lines)
end
vim.api.nvim_create_user_command("InitHtmlNew", init_html_new, {})

local function python_native_csv_reader()
  local lines = {
    "import csv",
    'with open("temp.csv", "r", encoding="utf-8") as file:',
    "\tcsv_reader = csv.DictReader(file)",
    "\ttype_map = {",
    '\t\t"dataset": str,',
    '\t\t"time": int,',
    '\t\t"group": str,',
    '\t\t"amount": int,',
    "\t}",
    "\tdata = [",
    "\t\t{colname: type_map[colname](value) for colname, value in row.items()}",
    "\t\tfor row in csv_reader",
    "\t]",
  }
  local buf = vim.api.nvim_get_current_buf()
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  vim.api.nvim_buf_set_lines(buf, row, row, false, lines)
end
vim.api.nvim_create_user_command("InitPythonCsvReader", python_native_csv_reader, {})

local function python_native_csv_writer()
  local lines = {
    "import csv",
    'with open("temp.csv", mode="w", encoding="utf-8") as file:',
    "\tcsv_writer = csv.DictWriter(",
    "\t\tfile,",
    '\t\tfieldnames=["name", "surname"],',
    '\t\tdelimiter=",",',
    "\t\tquotechar='\"',",
    "\t\tquoting=csv.QUOTE_MINIMAL,",
    "\t)",
    "\tcsv_writer.writeheader()",
    '\tcsv_writer.writerow({"name": "abraham", "surname": "lincoln"})',
    '\tcsv_writer.writerow({"name": "oscar", "surname": "peterson"})',
  }
  local buf = vim.api.nvim_get_current_buf()
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  vim.api.nvim_buf_set_lines(buf, row, row, false, lines)
  -- local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  -- vim.api.nvim_buf_set_lines(0, row - 1, row - 1, true, lines)
end
vim.api.nvim_create_user_command("InitPythonCsvWriter", python_native_csv_writer, {})

local function python_argparse()
  local lines = {
    "import argparse",
    "arg_parser = argparse.ArgumentParser()",
    'arg_parser.add_argument(dest="unnamed_arg_1") # script will raise an error if this argument not supplied',
    "arg_parser.add_argument(",
    "\t# an optional boolean flag",
    '\t"-d",',
    '\t"--debug",',
    '\thelp="print verbose runtime information to standard out",',
    '\taction="store_true", # state if this flag is present',
    ")",
    "arg_parser.add_argument(",
    '\t"-s",',
    '\t"--style",',
    '\thelp="style to apply to visual process output",',
    '\tdefault="plain",',
    '\tchoices=["plain","retro","dark"],',
    "\trequired=True,",
    "\ttype=str,",
    ")",
    "args = arg_parser.parse_args()",
  }
  local buf = vim.api.nvim_get_current_buf()
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  vim.api.nvim_buf_set_lines(buf, row, row, false, lines)
end
vim.api.nvim_create_user_command("InitPythonArgparse", python_argparse, {})

local function init_python_logger()
  local lines = {
    "import logging",
    "",
    "# set up python logger #",
    "logging.basicConfig(",
    "\tlevel=logging.INFO,",
    '\tformat="%(asctime)s - %(name)s - %(levelname)s - %(message)s",',
    '\thandlers=[logging.FileHandler("info.log"), logging.StreamHandler()],',
    ")",
    "logger = logging.getLogger(__name__)",
  }
  local buf = vim.api.nvim_get_current_buf()
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  vim.api.nvim_buf_set_lines(buf, row, row, false, lines)
end
vim.api.nvim_create_user_command("InitPythonLogger", init_python_logger, {})
