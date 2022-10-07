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
    "-data",
    eclipse_workspace,
  },
  -- cmd = {
  --   "java",
  --   "-Declipse.application=org.eclipse.jdt.ls.core.id1",
  --   "-Dosgi.bundles.defaultStartLevel=4",
  --   "-Declipse.product=org.eclipse.jdt.ls.core.product",
  --   "-Dlog.protocol=true",
  --   "-Dlog.level=ALL",
  --   "-Xms1g",
  --   "-Xmx2G",
  --   "-javaagent:" .. lombok_jar,
  --   "-Xbootclasspath/a:" .. lombok_jar,
  --   "-jar",
  --   "/Library/Java/jdt-language-server-1.5.0-202110191539/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar",
  --   "-configuration", "/Library/Java/jdt-language-server-1.5.0-202110191539/config_mac",
  --   "-data", eclipse_workspace,
  --   "--add-modules=ALL-SYSTEM",
  --   "--add-opens", "java.base/java.util=ALL-UNNAMED",
  --   "--add-opens", "java.base/java.lang=ALL-UNNAMED",
  -- },
  root_dir = root_dir,
  init_options = {
    workspaceFolders = ws_folders_jdtls,
    -- extendedClientCapabilities = {
    --   classFileContentsSupport = true
    -- }
  },
  settings = {
    java = {
      sources = {
        organizeImports = {
          starThreshold = 9999,
          staticStarThreshold = 9999,
        },
      },
    }
  }
}

jdtls.start_or_attach(config)
