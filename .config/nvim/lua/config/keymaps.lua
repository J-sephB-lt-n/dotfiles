-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- new HTML document boilerplate
local function init_html_new()
  local lines = {
    "<!DOCTYPE html>",
    '<html lang="en">',
    "<head>",
    '<meta charset="UTF-8">',
    'meta name="viewport" content="width=device-width, initial-scale=1.0">',
    '<meta http-equiv="X-UA-Compatible" content="ie=edge">',
    "<title>This title appears in browser title bar and in search results</title>",
    '<link rel="stylesheet" href="./style.css">',
    '<link rel="icon" href="./favicon.ico" type="image/x-icon">',
    "</head>",
    "<body>",
    "<main>",
    "<h1>Welcome to My Website</h1>  ",
    "</main>",
    '<script src="index.js"></script>',
    "</body>",
    "</html>",
  }
  local buf = vim.api.nvim_get_current_buf()
  vim.api.nvim_buf_set_lines(buf, 0, 0, false, lines)
end
vim.api.nvim_create_user_command("InitHtmlNew", init_html_new, {})

local function python_native_csv_reader()
  local lines = {
    "import csv",
    'with open("temp.csv", "r", encoding="utf-8") as file:',
    "\tcsv_reader = csv.DictReader(file)",
    "for row in csv_reader:",
    "\tprint(row)",
  }
  local buf = vim.api.nvim_get_current_buf()
  vim.api.nvim_buf_set_lines(buf, 0, 0, false, lines)
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
  vim.api.nvim_buf_set_lines(buf, 0, 0, false, lines)
end
vim.api.nvim_create_user_command("InitPythonCsvWriter", python_native_csv_writer, {})
