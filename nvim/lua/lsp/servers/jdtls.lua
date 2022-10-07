return function(on_attach)
    -- Finding the root directory
    -- https://stackoverflow.com/a/4991602
    local function file_exists(name)
        local f = io.open(name, "r")
        if f ~= nil then io.close(f) return true else return false end
    end

    -- https://stackoverflow.com/a/20460403
    local function findLast(haystack, needle)
        local i = haystack:match(".*" .. needle .. "()")
        if i == nil then return nil else return i - 1 end
    end

    local function parent_dir(dir)
        return dir:sub(1, findLast(dir, '/') - 1)
    end

    local term_pattern = parent_dir(os.getenv('HOME'))

    local function get_root_dir()
        local prefix = vim.fn.expand('%:p:h')
        local cwd = vim.fn.getcwd()
        if not (prefix:find(term_pattern) == 1) then
            return cwd
        end
        local possible_root_dir = prefix
        local found = false
        while prefix ~= term_pattern do
            for _, dir in ipairs({ "Config", "packageInfo" }) do
                if file_exists(prefix .. '/' .. dir) then
                    found = true
                    possible_root_dir = prefix
                    if not vim.g.outermost_root then
                        return possible_root_dir
                    end
                    break
                end
            end
            prefix = parent_dir(prefix)
        end
        if found then
            return possible_root_dir
        else
            return cwd
        end
    end

    -- local root_dir = require('jdtls.setup').find_root({'packageInfo'}, 'Config')
    local root_dir = get_root_dir()
    local home = os.getenv('HOME')
    local eclipse_workspace = home .. "/.local/share/eclipse/" .. vim.fn.fnamemodify(root_dir, ':p:h:t')

    -- find java executable
    local p_java = io.popen('find ' .. '/usr/bin/java')
    local jdk_java = p_java:read();
    if not jdk_java then
        jdk_java = ''
    end
    p_java:close()

    -- find lombok jar
    local p_lombok = io.popen('find ' .. home .. '/Developer/lombok.jar')
    local lombok_jar = p_lombok:read();
    if not lombok_jar then
        lombok_jar = ''
    end
    p_lombok:close()

    -- check OS
    local p_uname = io.popen('uname');
    local os_name = p_uname:read();
    local os_config
    p_uname:close();
    if os_name == 'Darwin' then
        os_config = 'config_mac'
    else
        os_config = 'config_linux'
    end


    local ws_folders_lsp = {}
    local ws_folders_jdtls = {}
    if root_dir then
        local file = io.open(root_dir .. "/.bemol/ws_root_folders", "r");
        if file then
            for line in file:lines() do
                table.insert(ws_folders_lsp, line);
                table.insert(ws_folders_jdtls, string.format("file://%s", line))
            end
            file:close()
        end
    end

    local cmd = {
        "java",
        "-declipse.application=org.eclipse.jdt.ls.core.id1",
        "-dosgi.bundles.defaultstartlevel=4",
        "-declipse.product=org.eclipse.jdt.ls.core.product",
        "-dlog.protocol=true",
        "-dlog.level=all",
        "-xms1g",
        "-xmx2g",
        "-javaagent:" .. lombok_jar,
        "-xbootclasspath/a:" .. lombok_jar,
        "-jar",
        "/library/java/jdt-language-server-1.5.0-202110191539/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar",
        "-configuration", "/library/java/jdt-language-server-1.5.0-202110191539/config_mac",
        "-data", eclipse_workspace,
        "--add-modules=all-system",
        "--add-opens", "java.base/java.util=all-unnamed",
        "--add-opens", "java.base/java.lang=all-unnamed",
    }

    local status_ok, lspconfig = pcall(require, "lspconfig")
    if not status_ok then
        vim.notify("lspconfig not found")
        return
    end

    return {
        on_attach = function(client, bufnr)
            on_attach(client, bufnr)
            for _, line in ipairs(ws_folders_lsp) do
                vim.lsp.buf.add_workspace_folder(line)
            end
        end,
        ws_folders_lsp = ws_folders_lsp,
        cmd = cmd,
        root_dir = lspconfig.util.root_pattern("packageInfo"),
        init_options = {
            workspaceFolders = ws_folders_jdtls,
            extendedClientCapabilities = {
                classFileContentsSupport = true
            }
        },
    }
end
