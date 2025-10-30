---@module 'lean'
  ---@type lean.Config
  require('lean').setup {
    -- Enable suggested mappings?
    --
    -- false by default, true to enable
    mappings = false,

    -- Enable the Lean language server(s)?
    --
    -- false to disable, otherwise should be a table of options to pass to `leanls`
    --
    -- See :help vim.lsp.Config for details.
    lsp = {
      init_options = {
        -- See Lean.Lsp.InitializationOptions for details and further options.

        -- Time (in milliseconds) which must pass since latest edit until elaboration begins.
        -- Lower values may make editing feel faster at the cost of higher CPU usage.
        -- Note that lean.nvim changes the Lean default for this value!
        editDelay = 10,

        -- Whether to signal that widgets are supported.
        hasWidgets = true,
      }
    },

    ft = {
      -- A list of patterns which will be used to protect any matching
      -- Lean file paths from being accidentally modified (by marking the
      -- buffer as `nomodifiable`).
      nomodifiable = {
          -- by default, this list includes the Lean standard libraries,
          -- as well as files within dependency directories (e.g. `_target`)
          -- Set this to an empty table to disable.
      }
    },

    -- Abbreviation support
    abbreviations = {
      -- Enable expanding of unicode abbreviations?
      enable = true,
      -- additional abbreviations:
      extra = {
        -- Add a \wknight abbreviation to insert ♘
        --
        -- Note that the backslash is implied, and that you of
        -- course may also use a snippet engine directly to do
        -- this if so desired.
        wknight = '♘',
      },
      -- Change if you don't like the backslash
      -- (comma is a popular choice on French keyboards)
      leader = '\\',
    },

    -- Infoview support
    infoview = {
      -- Automatically open an infoview on entering a Lean buffer?
      -- Should be a function that will be called anytime a new Lean file
      -- is opened. Return true to open an infoview, otherwise false.
      -- Setting this to `true` is the same as `function() return true end`,
      -- i.e. autoopen for any Lean file, or setting it to `false` is the
      -- same as `function() return false end`, i.e. never autoopen.
      autoopen = true,

      -- Set infoview windows' starting dimensions.
      -- Windows are opened horizontally or vertically depending on spacing.
      width = 50,
      height = 20,

      -- Set the infoviews' orientation to be dynamic based on screen layout
      -- or fixed to a vertical or horizontal orientation
      -- auto | vertical | horizontal
      orientation = "auto",

      -- Put the infoview on the top or bottom when horizontal?
      -- top | bottom
      horizontal_position = "bottom",

      -- Always open the infoview window in a separate tabpage.
      -- Might be useful if you are using a screen reader and don't want too
      -- many dynamic updates in the terminal at the same time.
      -- Note that `height` and `width` will be ignored in this case.
      separate_tab = false,

      -- Show indicators for pin locations when entering an infoview window?
      -- always | never | auto (= only when there are multiple pins)
      indicators = "auto",
    },

    -- Progress bar support
    progress_bars = {
      -- Enable the progress bars?
      -- By default, this is `true` if satellite.nvim is not installed, otherwise
      -- it is turned off, as when satellite.nvim is present this information would
      -- be duplicated.
      enable = true,  -- see above for default
      -- What character should be used for the bars?
      character = '│',
      -- Use a different priority for the signs
      priority = 10,
    },

    -- Redirect Lean's stderr messages somewhere (to a buffer by default)
    stderr = {
      enable = true,
      -- height of the window
      height = 5,
      -- a callback which will be called with (multi-line) stderr output
      -- e.g., use:
      --   on_lines = function(lines) vim.notify(lines) end
      -- if you want to redirect stderr to `vim.notify`.
      -- The default implementation will redirect to a dedicated stderr
      -- window.
      on_lines = nil,
    },
  }
