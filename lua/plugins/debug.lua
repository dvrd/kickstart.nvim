local function input_sync(opts)
  local co = coroutine.running()
  vim.ui.input(opts, function(result)
    vim.schedule(function()
      coroutine.resume(co, result)
    end)
  end)
  return coroutine.yield()
end

local function pick_program()
  local dap = require 'dap'

  local result = input_sync {
    prompt = 'Path to executable (compiled with -debug!): ',
    default = vim.fn.getcwd() .. '/',
    completion = 'file',
  }

  if result == nil or result == '' or result:sub(-1) == '/' then
    return dap.ABORT
  end

  return result
end

return {
  'mfussenegger/nvim-dap', -- Core functionality for debugging.
  dependencies = {
    'rcarriga/nvim-dap-ui', -- Adds a UI to the debugger.
    'nvim-neotest/nvim-nio',
    'theHamsta/nvim-dap-virtual-text', -- Shows information from the debugging session next to code as virtual text.
    'williamboman/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',
  },
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'
    local daputil = require 'dap.utils'

    vim.keymap.set('n', '<leader>do', dapui.toggle, { desc = 'Debug: Toggle UI' })
    vim.keymap.set('n', '<leader>dc', dap.continue, { desc = 'Debug: Start/Continue' })
    vim.keymap.set('n', '<leader>db', dap.toggle_breakpoint, { desc = 'Debug: Toggle Breakpoint' })
    vim.keymap.set('n', '<leader>dB', function()
      dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
    end, { desc = 'Debug: Set Breakpoint' })

    require('nvim-dap-virtual-text').setup {}

    dapui.setup()

    dap.listeners.after.event_initialized['dapui_config'] = function()
      vim.keymap.set('n', '<Right>', dap.step_over)
      vim.keymap.set('n', '<Up>', dap.step_out)
      vim.keymap.set('n', '<Down>', dap.step_into)

      dapui.open {}
    end

    dap.listeners.before.event_terminated['dapui_config'] = function()
      pcall(vim.keymap.del, 'n', '<Right>')
      pcall(vim.keymap.del, 'n', '<Up>')
      pcall(vim.keymap.del, 'n', '<Down>')

      dapui.close {}
    end

    dap.listeners.before.event_exited['dapui_config'] = function()
      pcall(vim.keymap.del, 'n', '<Right>')
      pcall(vim.keymap.del, 'n', '<Up>')
      pcall(vim.keymap.del, 'n', '<Down>')

      dapui.close {}
    end

    -- catppuccin
    local sign = vim.fn.sign_define
    sign('DapBreakpoint', { text = '●', texthl = 'DapBreakpoint', linehl = '', numhl = '' })
    sign('DapBreakpointCondition', {
      text = '●',
      texthl = 'DapBreakpointCondition',
      linehl = '',
      numhl = '',
    })
    sign('DapLogPoint', { text = '◆', texthl = 'DapLogPoint', linehl = '', numhl = '' })

    dap.adapters.codelldb = {
      type = 'server',
      port = 1300,
      executable = {
        command = 'codelldb',
        args = { '--port', '1300' },
      },
    }

    local lldb_default_config = {
      -- Launch a process and debug it.
      {
        name = 'Launch & Debug',
        type = 'codelldb',
        request = 'launch',
        cwd = vim.fn.getcwd(),
        stopOnEntry = false,
        program = pick_program,
        args = function()
          local result = input_sync {
            prompt = 'program arguments: ',
          }

          if result == nil then
            return dap.ABORT
          end

          return vim.split(result, ' ')
        end,
      },
      -- Find an existing process to attach to.
      {
        name = 'Attach & Debug',
        type = 'codelldb',
        request = 'attach',
        stopOnEntry = false,
        program = pick_program,
        pid = daputil.pick_process,
      },
    }

    dap.configurations.odin = lldb_default_config
    dap.configurations.cpp = lldb_default_config
    dap.configurations.c = lldb_default_config

    dap.adapters.php = {
      command = 'php-debug-adapter',
      type = 'executable',
    }

    dap.configurations.php = {
      {
        type = 'php',
        request = 'launch',
        name = 'Listen for Xdebug',
        port = 9003,
      },
    }

    -- Map of configuration per filetype, this lazy loads, so we don't load
    -- each dap adapter/language when we run.
    local filetypes = {
      go = {
        configured = false,
        config = function()
          require('gopher.dap').setup()
        end,
      },
    }

    local on_ft = function(ft)
      local curr_ft = filetypes[ft]
      if curr_ft and not curr_ft.configured then
        vim.schedule_wrap(function()
          vim.notify('Lazy loading ' .. ft .. ' DAP configuration', vim.log.levels.INFO)
        end)
        curr_ft.config()
        curr_ft.configured = true
      end
    end
    on_ft(vim.bo.filetype)

    local ft_pattern = {}
    for k, _ in pairs(filetypes) do
      table.insert(ft_pattern, k)
    end

    vim.api.nvim_create_autocmd('FileType', {
      pattern = ft_pattern,
      callback = function(data)
        on_ft(data.match)
      end,
    })
  end,
}
