---@diagnostic disable: lowercase-global, unused-local
--  _____ ____
-- |  __ \___ \
-- | |__) |__) |   Prabesh Maharjan
-- |  ___/|__ <    https://github.com/Prabesh9
-- | |    ___) |
-- |_|   |____/
--
-- ==========================================================
-- Holo Awesome WM theme 3.0 (Customized)
-- github.com/lcpz
--
--
local gears = require("gears")
local lain  = require("lain")
local awful = require("awful")
local wibox = require("wibox")
local dpi   = require("beautiful.xresources").apply_dpi

-- Widgets
local docker_widget = require("awesome-wm-widgets.docker-widget.docker")
local batteryarc_widget = require("awesome-wm-widgets.batteryarc-widget.batteryarc")
local calendar_widget = require("awesome-wm-widgets.calendar-widget.calendar")
local spotify_widget = require("awesome-wm-widgets.spotify-widget.spotify")

local string, os = string, os
local my_table = awful.util.table or gears.table

local theme                                     = {}
theme.default_dir                               = require("awful.util").get_themes_dir() .. "default"
theme.icon_dir                                  = os.getenv("HOME") .. "/.config/awesome/themes/holo/icons"
theme.font                                      = "Ubuntu Mono Regular 9"
theme.taglist_font                              = "Ubuntu Mono Bold 8"
theme.fg_normal                                 = "#FFFFFF"
theme.fg_focus                                  = "#0099CC"
theme.bg_focus                                  = "#303030"
theme.bg_normal                                 = "#242424"
theme.fg_urgent                                 = "#CC9393"
theme.bg_urgent                                 = "#ED7572"
theme.border_width                              = dpi(3)
theme.border_normal                             = "#252525"
theme.border_focus                              = "#0099CC"
theme.taglist_fg_focus                          = "#FFFFFF"
theme.taglist_fg_occupied                       = "#CCCCCC"
theme.taglist_fg_empty                          = "#666666"
theme.tasklist_bg_normal                        = "#222222"
theme.tasklist_fg_focus                         = "#4CB7DB"
theme.menu_height                               = dpi(20)
theme.menu_width                                = dpi(160)
theme.menu_icon_size                            = dpi(32)
theme.awesome_icon                              = theme.icon_dir .. "/logo.png"
theme.awesome_icon_launcher                     = theme.icon_dir .. "/logo.png"
theme.spr_small                                 = theme.icon_dir .. "/spr_small.png"
theme.spr_very_small                            = theme.icon_dir .. "/spr_very_small.png"
theme.spr_right                                 = theme.icon_dir .. "/spr_right.png"
theme.spr_bottom_right                          = theme.icon_dir .. "/spr_bottom_right.png"
theme.spr_left                                  = theme.icon_dir .. "/spr_left.png"
theme.bar                                       = theme.icon_dir .. "/bar.png"
theme.bottom_bar                                = theme.icon_dir .. "/bottom_bar.png"
theme.clock                                     = theme.icon_dir .. "/clock.png"
theme.calendar                                  = theme.icon_dir .. "/cal.png"
theme.cpu                                       = theme.icon_dir .. "/cpu.png"
theme.net_up                                    = theme.icon_dir .. "/net_up.png"
theme.net_down                                  = theme.icon_dir .. "/net_down.png"
theme.layout_tile                               = theme.icon_dir .. "/tile.png"
theme.layout_max                                = theme.icon_dir .. "/max.png"
theme.layout_floating                           = theme.icon_dir .. "/floating.png"
theme.tasklist_plain_task_name                  = true
theme.tasklist_disable_icon                     = true
theme.useless_gap                               = dpi(2)

theme.musicplr = string.format("%s -e ncmpcpp", awful.util.terminal)

local markup = lain.util.markup
local blue   = "#80CCE6"
local space3 = markup.font("Roboto 3", " ")

-- Clock
local mytextclock = wibox.widget.textclock(markup("#FFFFFF", space3 .. "%H:%M   " .. markup.font("Roboto 4", " ")))
mytextclock.font = theme.font
local clock_icon = wibox.widget.imagebox(theme.clock)
local clockbg = wibox.container.background(mytextclock, theme.bg_focus, gears.shape.rectangle)
local clockwidget = wibox.container.margin(clockbg, dpi(0), dpi(3), dpi(3), dpi(3))

-- Calendar
local mytextcalendar = wibox.widget.textclock(markup.fontfg(theme.font, "#FFFFFF", space3 .. "%d %b " .. markup.font("Roboto 5", " ")))
local calendar_icon = wibox.widget.imagebox(theme.calendar)
local calbg = wibox.container.background(mytextcalendar, theme.bg_focus, gears.shape.rectangle)
local calendarwidget = wibox.container.margin(calbg, dpi(0), dpi(0), dpi(3), dpi(3))

local cw = calendar_widget({
  placement = 'top_right',
  start_sunday = true,
  radius = 8,
  previous_month_button = 1,
  next_month_button = 3,
})
calendarwidget:connect_signal("button::press",
  function(_, _, _, button)
    if button == 1 then cw.toggle() end
  end)
clockwidget:connect_signal("button::press",
  function(_, _, _, button)
    if button == 1 then cw.toggle() end
  end)

-- Docker
local dockerbg = wibox.container.background(docker_widget(), theme.bg_focus, gears.shape.rectangle)
local dockerwidget = wibox.container.margin(dockerbg, dpi(0), dpi(0), dpi(3), dpi(3))

-- Spotify
local spotifybg = wibox.container.background(spotify_widget({
  font = 'Ubuntu Mono 9',
  play_icon = '/usr/share/icons/Papirus-Light/24x24/categories/spotify.svg',
  pause_icon = '/usr/share/icons/Papirus-Dark/24x24/panel/spotify-indicator.svg',
  dim_when_paused = true,
  dim_opacity = 0.5,
  max_length = -1,
  show_tooltip = false
}), theme.bg_focus, gears.shape.rectangle)
local spotifywidget = wibox.container.margin(spotifybg, dpi(0), dpi(0), dpi(3), dpi(3))

-- Battery
local batterybg = wibox.container.background(batteryarc_widget({
  font = theme.font,
  arc_thickness = 1,
  timeout = 3,
  show_current_level = true,
  main_color = theme.fg_normal
}), theme.bg_focus, gears.shape.rectangle)
local batterywidget = wibox.container.margin(batterybg, dpi(0), dpi(0), dpi(3), dpi(3))

-- Launcher
local mylauncher = awful.widget.button({ image = theme.awesome_icon_launcher })
mylauncher:connect_signal("button::press", function() awful.util.mymainmenu:toggle() end)
local mylauncherwidget = wibox.container.margin(mylauncher, dpi(0), dpi(0), dpi(3), dpi(3))

-- Separators
local first = wibox.widget.textbox('<span font="Roboto 7"> </span>')
local spr_small = wibox.widget.imagebox(theme.spr_small)
local spr_very_small = wibox.widget.imagebox(theme.spr_very_small)
local spr_right = wibox.widget.imagebox(theme.spr_right)
local spr_bottom_right = wibox.widget.imagebox(theme.spr_bottom_right)
local spr_left = wibox.widget.imagebox(theme.spr_left)
local bar = wibox.widget.imagebox(theme.bar)
local bottom_bar = wibox.widget.imagebox(theme.bottom_bar)
local last = wibox.widget.textbox('<span font="Roboto 7"> </span>')

local barcolor  = gears.color({
  type  = "linear",
  from  = { dpi(32), 0 },
  to    = { dpi(32), dpi(32) },
  stops = { {0, theme.bg_normal}, {0.25, theme.bg_focus}, {1, theme.bg_focus} }
})

function theme.at_screen_connect(s)
  -- Quake application
  s.quake = lain.util.quake({ app = awful.util.terminal })

  -- Tags
  awful.tag(awful.util.tagnames, s, awful.layout.layouts)

  -- Create a promptbox for each screen
  s.mypromptbox = awful.widget.prompt()
  -- Create an imagebox widget which will contains an icon indicating which layout we're using.
  -- We need one layoutbox per screen.
  s.mylayoutbox = awful.widget.layoutbox(s)
  s.mylayoutbox:buttons(my_table.join(
    awful.button({}, 1, function () awful.layout.inc( 1) end),
    awful.button({}, 2, function () awful.layout.set( awful.layout.layouts[1] ) end),
    awful.button({}, 3, function () awful.layout.inc(-1) end),
    awful.button({}, 4, function () awful.layout.inc( 1) end),
    awful.button({}, 5, function () awful.layout.inc(-1) end)))
  -- Create a taglist widget
  s.mytaglist = awful.widget.taglist(s, awful.widget.taglist.filter.all, awful.util.taglist_buttons, {bg_focus = theme.bg_normal} )

  mytaglistcont = wibox.container.background(s.mytaglist, theme.bg_normal, gears.shape.rectangle)
  s.mytag = wibox.container.margin(mytaglistcont, dpi(0), dpi(0), dpi(0), dpi(0))

  -- Create a tasklist widget
  s.mytasklist = awful.widget.tasklist{
    screen = s,
    filter = awful.widget.tasklist.filter.currenttags,
    buttons = awful.util.tasklist_buttons,
    style = {
      bg_focus = theme.bg_focus,
      shape = gears.shape.rectangle,
      shape_border_width = 3,
      shape_border_color = theme.bg_normal,
      align = "center"
    },
  }

  -- Create the wibox
  s.mywibox = awful.wibar({ position = "top", screen = s, height = dpi(20) })

  -- Add widgets to the wibox
  s.mywibox:setup {
    layout = wibox.layout.align.horizontal,
    { -- Left widgets
      layout = wibox.layout.fixed.horizontal,
      first,
      first,
      mylauncherwidget,
      first,
      first,
      first,
      s.mytag,
      bar,
      s.mylayoutbox,
      first,
      s.mypromptbox,
    },
    { -- Middle widget
      layout = wibox.layout.fixed.horizontal,
      first,
      first,
      s.mytasklist, -- Middle widget
    },
    { -- Right widgets
      layout = wibox.layout.fixed.horizontal,
      bar,
      spotifywidget,
      bar,
      dockerwidget,
      bar,
      batterywidget,
      bar,
      calendar_icon,
      calendarwidget,
      bar,
      clock_icon,
      clockwidget,
      wibox.widget.systray(),
      last,
      last,
    },
  }

end

return theme
