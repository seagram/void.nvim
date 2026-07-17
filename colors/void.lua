vim.o.background = "dark"
vim.o.termguicolors = true
vim.cmd("highlight clear")
vim.g.colors_name = "void"

local hl = vim.api.nvim_set_hl
local palette = {
  fg = "#dadada",
  muted = "#707070",
  dark = "#181818",
  keyword = "#7a7670",
  type = "#c4c0b8",
}

-- neutralize core colours while preserving links and text attributes
for name, value in pairs(vim.api.nvim_get_hl(0, {})) do
  if value.link then
    hl(0, name, { link = value.link })
  else
    value.fg = value.fg and palette.fg or nil
    value.bg = nil
    value.sp = value.sp and palette.muted or nil
    value.ctermfg = nil
    value.ctermbg = nil
    hl(0, name, value)
  end
end

local function set(names, value)
  for _, name in ipairs(names) do
    hl(0, name, value)
  end
end

local function link(names, target)
  set(names, { link = target })
end

hl(0, "Normal", { fg = palette.fg })
link({ "NormalNC", "NormalFloat" }, "Normal")
hl(0, "Comment", { fg = palette.muted, bold = true })
link({ "Todo", "@comment", "@comment.todo" }, "Comment")

link({
  "Constant",
  "String",
  "Character",
  "Number",
  "Boolean",
  "Float",
  "Identifier",
  "Function",
  "Statement",
  "Conditional",
  "Repeat",
  "Label",
  "Operator",
  "Keyword",
  "Exception",
  "PreProc",
  "Include",
  "Define",
  "Macro",
  "PreCondit",
  "Type",
  "StorageClass",
  "Structure",
  "Typedef",
  "Special",
  "SpecialChar",
  "Tag",
  "Delimiter",
  "SpecialComment",
  "Debug",
  "Ignore",
  "Error",
}, "Normal")

hl(0, "Underlined", { fg = palette.fg, underline = true })
set({ "Cursor", "lCursor", "CursorIM" }, { reverse = true })
set({ "ColorColumn", "CursorColumn" }, { bg = palette.dark })
hl(0, "CursorLine", { bg = palette.dark })
hl(0, "CursorLineNr", { fg = palette.muted, bg = palette.dark })
hl(0, "LineNr", { fg = palette.muted })
link({ "LineNrAbove", "LineNrBelow" }, "LineNr")

set({
  "Conceal",
  "EndOfBuffer",
  "Folded",
  "NonText",
  "SpecialKey",
  "Whitespace",
}, { fg = palette.muted })
set({ "FoldColumn", "SignColumn" }, { fg = palette.muted })
set({ "FloatBorder", "PmenuBorder", "WinSeparator" }, { fg = palette.dark })
set({ "FloatShadow", "FloatShadowThrough", "PmenuShadow", "PmenuShadowThrough" }, {})
set({ "FloatTitle", "FloatFooter" }, { fg = palette.fg, bold = true })
hl(0, "Pmenu", { fg = palette.fg })
hl(0, "PmenuSel", { fg = palette.fg, bg = palette.dark, blend = 25 })
set({ "PmenuKind", "PmenuExtra", "ComplHint", "ComplHintMore" }, { fg = palette.muted })
set({ "PmenuKindSel", "PmenuExtraSel" }, { fg = palette.muted })
set({ "PmenuMatch", "PmenuMatchSel", "ComplMatchIns" }, { fg = palette.fg, bold = true })
set({ "PmenuSbar", "PmenuThumb" }, {})
hl(0, "Visual", { bg = palette.muted })
link({ "VisualNOS", "SnippetTabstopActive" }, "Visual")
set({ "Search", "QuickFixLine", "SnippetTabstop", "PreInsert" }, { bg = palette.dark })
set({ "CurSearch", "IncSearch" }, { bg = palette.muted })
hl(0, "MatchParen", { bold = true, underline = true })
set({ "StatusLine", "WinBar" }, { fg = palette.fg, bold = true })
set({ "StatusLineNC", "WinBarNC", "TabLine" }, { fg = palette.muted })
set({ "TabLineFill" }, {})
hl(0, "TabLineSel", { fg = palette.fg, bold = true })
set({ "ErrorMsg", "WarningMsg", "MoreMsg", "Question", "ModeMsg" }, {
  fg = palette.fg,
  bold = true,
})

local diagnostic = {
  "DiagnosticError",
  "DiagnosticWarn",
  "DiagnosticInfo",
  "DiagnosticHint",
  "DiagnosticOk",
  "DiagnosticVirtualTextError",
  "DiagnosticVirtualTextWarn",
  "DiagnosticVirtualTextInfo",
  "DiagnosticVirtualTextHint",
  "DiagnosticVirtualTextOk",
  "DiagnosticFloatingError",
  "DiagnosticFloatingWarn",
  "DiagnosticFloatingInfo",
  "DiagnosticFloatingHint",
  "DiagnosticFloatingOk",
  "DiagnosticSignError",
  "DiagnosticSignWarn",
  "DiagnosticSignInfo",
  "DiagnosticSignHint",
  "DiagnosticSignOk",
  "DiagnosticDeprecated",
  "DiagnosticUnnecessary",
}
set(diagnostic, { fg = palette.muted })
set({
  "DiagnosticUnderlineError",
  "DiagnosticUnderlineWarn",
  "DiagnosticUnderlineInfo",
  "DiagnosticUnderlineHint",
  "DiagnosticUnderlineOk",
}, { sp = palette.muted, undercurl = true })

set({ "SpellBad", "SpellCap", "SpellLocal", "SpellRare" }, {
  sp = palette.muted,
  undercurl = true,
})

link({ "Added", "Changed", "Removed", "DiffAdd", "DiffChange", "DiffDelete", "DiffText" }, "Normal")

-- colour every defined capture in the two permitted treesitter families
for name in pairs(vim.api.nvim_get_hl(0, {})) do
  if name == "@keyword" or name:match("^@keyword%.") then
    hl(0, name, { fg = palette.keyword })
  elseif name == "@type" or name:match("^@type%.") then
    hl(0, name, { fg = palette.type })
  end
end

-- keep lsp semantic tokens monochrome
for name in pairs(vim.api.nvim_get_hl(0, {})) do
  if name:match("^@lsp%.type%.comment") then
    hl(0, name, { link = "Comment" })
  elseif name:match("^@lsp%.") then
    hl(0, name, { link = "Normal" })
  end
end
