-- rust
local dap = require("dap")
local dapui = require("dapui")
dap.adapters["rust-gdb"] = {
    type = "executable",
    command = "rust-gdb",
    args = { "--interpreter=dap", "--eval-command", "set print pretty on" }
}
dap.adapters["codelldb"] = {
    -- need install codelldb
    type = "executable",
    command = "codelldb",
}

local function get_rust_executable()
    local target_dir = vim.fn.getcwd() .. '/target/debug/'
    local executables = vim.fn.glob(target_dir .. '*', false, true)

    local valid_executables = {}
    for _, file in ipairs(executables) do
        if vim.fn.executable(file) == 1 and not file:match('%.d$') then
            table.insert(valid_executables, file)
        end
    end

    if #valid_executables == 0 then
        return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    else
        local result
        vim.ui.select(valid_executables, {
            prompt = 'Select executable:',
            format_item = function(item)
                return item
            end
        }, function(choice)
            result = choice
        end)
        return result
    end
end

dap.configurations.rust = {
    {
        name = "Launch",
        type = "rust-gdb",
        request = "launch",
        program = get_rust_executable,
        args = {}, -- provide arguments if needed
        cwd = "${workspaceFolder}",
        stopAtBeginningOfMainSubprogram = false,
    },
    {
        name = "Launch-codelldb",
        type = "codelldb",
        request = "launch",
        program = get_rust_executable,
        args = {}, -- provide arguments if needed
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
        preLaunchTask = "cargo build"
    },
    {
        name = "Select and attach to process",
        type = "rust-gdb",
        request = "attach",
        program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        pid = function()
            local name = vim.fn.input('Executable name (filter): ')
            return require("dap.utils").pick_process({ filter = name })
        end,
        cwd = "${workspaceFolder}"
    },
    {
        name = "Attach to gdbserver :1234",
        type = "rust-gdb",
        request = "attach",
        target = "localhost:1234",
        program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = '${workspaceFolder}'
    }
}
