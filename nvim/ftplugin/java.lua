local jdtls = require("jdtls")
local on_attach = require("lsp.on_attach")

local root_dir = require("jdtls.setup").find_root({ "packageInfo" }, "Config")
local home = os.getenv("HOME")
local eclipse_workspace = home .. "/.local/share/eclipse/" .. vim.fn.fnamemodify(root_dir, ":p:h:t")

local ws_folders_jdtls = {}
if root_dir then
  local file = io.open(root_dir .. "/.bemol/ws_root_folders")
  if file then
    for line in file:lines() do
      table.insert(ws_folders_jdtls, "file://" .. line)
    end
    file:close()
  end
end

local config = {
  on_attach = function(client, bufnr)
    on_attach(client, bufnr)
    jdtls.setup.add_commands()
  end,
  cmd = {
    "jdtls", -- need to be on your PATH
    "--jvm-arg=-javaagent:" .. home .. "/Developer/lombok.jar", -- need for lombok magic
    "--add-modules=ALL-SYSTEM",
    '--add-opens', 'java.base/java.util=ALL-UNNAMED',
    '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
    "-data", eclipse_workspace,
  },
  root_dir = root_dir,
  init_options = {
    workspaceFolders = ws_folders_jdtls,
    extendedClientCapabilities = {
      classFileContentsSupport = true
    }
  },
  settings = {
    java = {
      sources = {
        organizeImports = {
          starThreshold = 9999,
          staticStarThreshold = 9999,
        },
      },
      configuration = {
        runtimes = {
          {
            name = "JavaSE-11",
            path = "/Library/Java/JavaVirtualMachines/amazon-corretto-11.jdk/Contents/Home"
          }
        }
      }
    }
  }
}

jdtls.start_or_attach(config)
