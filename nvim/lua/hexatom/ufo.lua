local ufo_status_ok, ufo = pcall(require, 'ufo')
if not ufo_status_ok then return end

local statuscol_status_ok, statuscol = pcall(require, 'statuscol')
if not statuscol_status_ok then return end

local builtin = require('statuscol.builtin')

statuscol.setup({
  relculright = true,
  segments = {
    { text = { builtin.foldfunc }, click = 'v:lua.ScFa' },
    { text = { '%s' }, click = 'v:lua.ScSa' },
    { text = { builtin.lnumfunc, ' ' }, click = 'v:lua.ScLa' },
  },
})

ufo.setup({
  provider_selector = function(_, _, _) return { 'treesitter', 'indent' } end,
})
