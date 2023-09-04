local state = require 'tryptic.state'
local view = require 'tryptic.view'

---@return nil
local function handle_cursor_moved()
  if state.tryptic_open.is_open() then
    local target = view.get_target_under_cursor()
    local current_dir = state.view_state.get().current.path
    local line_number = vim.api.nvim_win_get_cursor(0)[1]
    if current_dir then
      state.path_to_line_map.set(current_dir, line_number)
      view.update_child_window(target)
    end
  end
end

---@return nil
local function handle_buf_leave()
  if state.tryptic_open.is_open() then
    require('tryptic').close_tryptic()
  end
end

return {
  handle_cursor_moved = handle_cursor_moved,
  handle_buf_leave = handle_buf_leave,
}