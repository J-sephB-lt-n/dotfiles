-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

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
  -- Get the current buffer
  local buf = vim.api.nvim_get_current_buf()
  -- Insert lines at the start of the buffer
  vim.api.nvim_buf_set_lines(buf, 0, 0, false, lines)
end
-- Create the Neovim command that calls the Lua function
vim.api.nvim_create_user_command("InitHtmlNew", init_html_new, {})
