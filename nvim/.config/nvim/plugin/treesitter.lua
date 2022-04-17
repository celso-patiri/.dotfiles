require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all"
  ensure_installed = {"javascript", "typescript", "lua",  "regex", "json", "html", "dockerfile", "css"},
  --ensure_installed = "maintained",

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- List of parsers to ignore installing (for "all")
  ignore_install = { 'c' },

  highlight = {
    -- `false` will disable the whole extension
    enable = true,

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    --disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    --the name of the parser)
    -- list of language that will be disabled
    disable = {},

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
  incremental_selection = { enable = true },
  textobjects = { enable = true },
  rainbow = {
    enable = true,
    -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
    extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
    max_file_lines = nil, -- Do not enable for files with more than n lines, int
    -- colors = {}, -- table of hex strings
    -- termcolors = {} -- table of colour name strings
  }
}

--------------------------------------------------------------------------------------------------------------------

--require'treesitter-context'.setup{
    --enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
    --throttle = true, -- Throttles plugin updates (may improve performance)
    --max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
    --patterns = { -- Match patterns for TS nodes. These get wrapped to match at word boundaries.
        ---- For all filetypes
        ---- Note that setting an entry here replaces all other patterns for this entry.
        ---- By setting the 'default' entry below, you can control which nodes you want to
        ---- appear in the context window.
        --default = {
            --'class',
            --'function',
            --'method',
            ---- 'for', -- These won't appear in the context
            ---- 'while',
            ---- 'if',
            ---- 'switch',
            ---- 'case',
        --},
        ---- Example for a specific filetype.
        ---- If a pattern is missing, *open a PR* so everyone can benefit.
        ----   rust = {
        ----       'impl_item',
        ----   },
    --},
    --exact_patterns = {
        ---- Example for a specific filetype with Lua patterns
        ---- Treat patterns.rust as a Lua pattern (i.e "^impl_item$" will
        ---- exactly match "impl_item" only)
        ---- rust = true,
    --}
--}
