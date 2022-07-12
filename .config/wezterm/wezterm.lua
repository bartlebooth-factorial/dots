local wezterm = require 'wezterm';

return {
  leader = { key="\\", mods="CTRL", timeout_milliseconds=2000 },
  keys = {
    {key="x", mods="LEADER", action=wezterm.action{SplitVertical={domain="CurrentPaneDomain"}}},
    {key="v", mods="LEADER", action=wezterm.action{SplitHorizontal={domain="CurrentPaneDomain"}}},
    {key="h", mods="LEADER", action=wezterm.action{ActivatePaneDirection="Left"}},
    {key="j", mods="LEADER", action=wezterm.action{ActivatePaneDirection="Down"}},
    {key="k", mods="LEADER", action=wezterm.action{ActivatePaneDirection="Up"}},
    {key="l", mods="LEADER", action=wezterm.action{ActivatePaneDirection="Right"}},
    {key="H", mods="LEADER", action=wezterm.action{AdjustPaneSize={"Left", 1}}},
    {key="J", mods="LEADER", action=wezterm.action{AdjustPaneSize={"Down", 1}}},
    {key="K", mods="LEADER", action=wezterm.action{AdjustPaneSize={"Up", 1}}},
    {key="L", mods="LEADER", action=wezterm.action{AdjustPaneSize={"Right", 1}}},
  },
  color_scheme = "Galaxy",
  -- color_scheme = "WildCherry",
  -- color_scheme = "Urple",
  -- color_scheme = "Wombat",
  font_size = 24.0,
  use_fancy_tab_bar = false,
  window_close_confirmation = "NeverPrompt",
  automatically_reload_config = false,
  hide_tab_bar_if_only_one_tab = true,
  check_for_updates = false,
  exit_behavior = "Close",
}
