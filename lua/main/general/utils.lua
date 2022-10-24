_G.utils = {}
utils.icons = require "main.icons.nerd_font"
utils.text_icons = require "main.icons.text"

--- Get an icon from `lspkind` if it is available and return it
-- @param kind the kind of icon in `lspkind` to retrieve
-- @return the icon
function utils.get_icon(kind)
  --local icon_pack = vim.g.icons_enabled and "icons" or "text_icons"
  return utils.icons[kind] or utils.text_icons[kind] or ""
end

