require("lze").register_handlers(require("nixCatsUtils.lzUtils").for_cat)

require("lze").register_handlers(require("lzextras").lsp)

local colorschemeName = nixCats("colorscheme")
vim.cmd.colorscheme(colorschemeName)

require("conf.plugins")
