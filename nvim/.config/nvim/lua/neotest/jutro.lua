local neotest = require("neotest")
local ts = require("neotest.lib.treesitter")
local async = require("plenary.async")

local M = {}

-- Supported filetypes
M.filetypes = { "typescript", "tsx" }

-- Optional root directory detection
M.root = function(path)
  return ts.get_root(path)
end

-- Parse tests using Tree-sitter queries
M.discover_positions = function(path)
  return async.wrap(function(callback)
    local positions = ts.parse_positions(path, {
      is_test = function(node)
        local text = ts.get_node_text(node, 0)
        return text:match("describe") or text:match("it") or text:match("test")
      end,
    })
    callback(positions)
  end)()
end

-- Run the tests
M.run = function(args)
  local cmd = { "npm", "run", "test", "--", args.position.id }
  return neotest.run.run_command(cmd)
end

-- Return the adapter table
return M

