--[[

     Powerarrow Awesome WM theme
     github.com/lcpz

--]]

local awesome, client, mouse, screen, tag                 = awesome, client, mouse, screen, tag

local ipairs, string, os, table, tostring, tonumber, type = ipairs, string, os, table, tostring, tonumber, type
local gears                                               = require("gears")
local awful                                               = require("awful")
local wibox                                               = require("wibox")
local lain                                                = require("lain")
local freedesktop                                         = require("freedesktop")
local my_table                                            = awful.util.table or gears.table -- 4.{0,1} compatibility
local dpi                                                 = require("beautiful.xresources").apply_dpi

local math, string, os                                    = math, string, os

local theme                                               = {}
theme.dir                                                 = os.getenv("HOME") .. "/.config/awesome/themes/alsaady"

theme.bg_systray                                          = "#1d2021"

theme.font                                                = "DejaVuSansMNerdFont 11"
theme.font1                                               = "DejaVuSansMNerdFont 13"
theme.font2                                               = "DejaVuSansMNerdFont 18"
theme.taglist_font                                        = "DejaVuSansMNerdFont 13"

theme.fg_normal                                           = "#ebdbb2"
theme.fg_focus                                            = "#454545"
-- theme.fg_rgent                                  = "#b74822"

theme.bg_normal                                           = "#282828"
theme.bg_focus                                            = "#1E2320"
-- theme.bg_urgent                                 = "#3F3F3F"

theme.taglist_fg_normal                                   = "#111111"
theme.taglist_fg_focus                                    = "#928374"
theme.taglist_bg_normal                                   = "#FFFFFF00"
theme.taglist_bg_focus                                    = "#FFFFFF00"

theme.tasklist_fg_normal                                  = "#454545"
theme.tasklist_fg_focus                                   = "#ebdbb2"
theme.tasklist_bg_normal                                  = "#1d202100"
theme.tasklist_bg_focus                                   = "#1d202100"

theme.border_normal                                       = "#222222"
theme.border_focus                                        = "#6F6F6F"
theme.border_marked                                       = "#CC9393"
theme.border_width                                        = dpi(1)

theme.titlebar_fg_focus                                   = "#1d2021CC"
theme.titlebar_bg_normal                                  = "#1d2021CC"
theme.titlebar_bg_focus                                   = "#1d2021CC"

theme.menu_height                                         = dpi(45)
theme.menu_width                                          = dpi(260)
theme.menu_icon_size                                      = dpi(32)

theme.taglist_squares_sel                                 = theme.dir .. "/icons/square_sel.png"
theme.taglist_squares_unsel                               = theme.dir .. "/icons/square_unsel.png"

theme.tasklist_plain_task_name                            = true
theme.tasklist_disable_icon                               = true
theme.systray_forced_width                                = 1

theme.useless_gap                                         = dpi(2)

-- http://fontawesome.io/cheatsheet
awful.util.tagnames                                       = { " ➊ ", "➋ ", "➌ ", "➍ ", "➎ ", "➏ ", "➐ ",
  "➑ ", "➒ " }

local markup                                              = lain.util.markup

local keyboardlayout                                      = awful.widget.keyboardlayout:new({
  -- widget:set_markup(" " .. markup.font(theme.font1)),
})


-- Textclock
local clock = awful.widget.watch(
  "date +'| %R | %a, %d.%m |'", 1,
  -- "date +'%d.%m %R'", 60,
  function(widget, stdout)
    widget:set_markup(" " .. markup.font(theme.font1, stdout))
  end
)


-- Calendar
theme.cal = lain.widget.cal({
  attach_to = { clock },
  notification_preset = {
    font = "Noto Sans Mono Medium 10",
    fg   = theme.fg_normal,
    bg   = theme.bg_normal
  }
})


-- Moveright
local mover = wibox.widget { markup = '  ', font = theme.font1, widget = wibox.widget.textbox }
mover:buttons(my_table.join(awful.button({}, 1, function()
  -- get current tag
  local t = client.focus and client.focus.first_tag or nil
  if t == nil then
    return
  end
  -- get previous tag (modulo 9 excluding 0 to wrap from 1 to 9)
  local tag = client.focus.screen.tags[(t.index % 9) + 1]
  awful.client.movetotag(tag)
  awful.tag.viewnext()
end
)))


-- Moveleft
local movel = wibox.widget { markup = '  ', font = theme.font1, widget = wibox.widget.textbox }
movel:buttons(my_table.join(awful.button({}, 1, function()
  -- get current tag
  local t = client.focus and client.focus.first_tag or nil
  if t == nil then
    return
  end
  -- get previous tag (modulo 9 excluding 0 to wrap from 1 to 9)
  local tag = client.focus.screen.tags[(t.index - 2) % 9 + 1]
  awful.client.movetotag(tag)
  awful.tag.viewprev()
end
)))


-- Maximiz
local max = wibox.widget { markup = '  ', font = theme.font1, widget = wibox.widget.textbox }
max:buttons(my_table.join(awful.button({}, 1, function()
  local c = client.focus
  c.maximized = not c.maximized
  c:raise()
end
)))


-- Close
local close = wibox.widget { markup = '  ', font = theme.font1, widget = wibox.widget.textbox }
close:buttons(my_table.join(awful.button({}, 1, function()
  -- get current tag
  local c = client.focus
  local t = client.focus and client.focus.first_tag or nil
  if t == nil then
    return
  end
  -- get previous tag (modulo 9 excluding 0 to wrap from 1 to 9)
  c:kill()
end
)))

-- Show/Hide Systray
local showtray = wibox.widget { markup = '  ', font = theme.font1, widget = wibox.widget.textbox }
showtray:buttons(my_table.join(awful.button({}, 1, function()
  awful.screen.focused().systray.visible = not awful.screen.focused().systray.visible
end
)))

--Onboard
local onboard = wibox.widget { markup = '   ', font = theme.font1, widget = wibox.widget.textbox }
onboard:buttons(my_table.join(awful.button({}, 1, function()
  awful.spawn.with_shell(string.format("onboard"))
end
)))


--Maim (Screenshot | xclip)
local copy = wibox.widget { markup = '  ', font = theme.font1, widget = wibox.widget.textbox }
copy:buttons(my_table.join(awful.button({}, 1, function()
  awful.spawn.with_shell(string.format("maim -s -u | xclip -selection clipboard -t image/png -i"))
end
)))


-- MEM
local mem = lain.widget.mem({
  settings = function()
    widget:set_markup(markup.font(theme.font1, "|  " .. mem_now.used .. "MB "))
  end
})


-- CPU
local cpu = lain.widget.cpu({
  settings = function()
    widget:set_markup(markup.font(theme.font1, "|  " .. cpu_now.usage .. "% "))
  end
})


-- Battery
local bat = lain.widget.bat({
  settings = function()
    if bat_now.status and bat_now.status ~= "N/A" then
      if bat_now.ac_status == 1 then
        widget:set_markup(markup.font(theme.font1, "|  " .. bat_now.perc .. "% "))
        return
      elseif bat_now.perc <= 25 then
        widget:set_markup(markup.font(theme.font1, "|  " .. bat_now.perc .. "% "))
      elseif bat_now.perc <= 50 then
        widget:set_markup(markup.font(theme.font1, "|  " .. bat_now.perc .. "% "))
      elseif bat_now.perc <= 75 then
        widget:set_markup(markup.font(theme.font1, "|  " .. bat_now.perc .. "% "))
      else
        widget:set_markup(markup.font(theme.font1, "|  " .. bat_now.perc .. "% "))
      end
    else
      widget:set_markup(markup.font(theme.font1, "|  "))
    end
  end
})


-- ALSA volume
theme.volume = lain.widget.alsa({
  settings = function()
    if volume_now.status == "off" or tonumber(volume_now.level) == 0 then
      widget:set_markup(markup.font(theme.font1, "|婢 " .. volume_now.level .. "% "))
    elseif tonumber(volume_now.level) <= 25 then
      widget:set_markup(markup.font(theme.font1, "|  " .. volume_now.level .. "% "))
    elseif tonumber(volume_now.level) <= 50 then
      widget:set_markup(markup.font(theme.font1, "|  " .. volume_now.level .. "% "))
    elseif tonumber(volume_now.level) <= 75 then
      widget:set_markup(markup.font(theme.font1, "| 󰕾 " .. volume_now.level .. "% "))
    else
      widget:set_markup(markup.font(theme.font1, "|  " .. volume_now.level .. "% "))
    end
  end
})


-- Net
local net = lain.widget.net({
  settings = function()
    widget:set_markup(markup.font(theme.font1, "   " .. net_now.received .. " ↓↑ " .. net_now.sent .. " "))
  end
})


-- Launcher
local mylauncher = wibox.widget { markup = '  ', font = theme.font2, widget = wibox.widget.textbox }
mylauncher:buttons(my_table.join(awful.button({}, 1, function()
  -- mylauncher:connect_signal("button::press", function()
  -- awful.spawn.with_shell(string.format("~/.config/rofi/scripts/launcher_t3"))
  awful.spawn.with_shell(string.format("~/.config/rofi/scripts/launcher_t3"))
  -- awful.util.mymainmenu:toggle()
end
)))


function theme.at_screen_connect(s)
  s.quake = lain.util.quake({ app = "urxvt", height = 0.50, argname = "--name %s" })


  -- All tags open with layout 1
  awful.tag(awful.util.tagnames, s, awful.layout.layouts[1])

  -- awful.systray({forced_width = 100, forced_height = 1, opacity = 0,})

  -- Create a promptbox for each screen
  s.mypromptbox = awful.widget.prompt()


  -- Create a taglist widget
  s.mytaglist = awful.widget.taglist(s, awful.widget.taglist.filter.all, awful.util.taglist_buttons)


  -- We need one layoutbox per screen.
  s.mylayoutbox = awful.widget.layoutbox(s)
  s.mylayoutbox:buttons(my_table.join(
    awful.button({}, 1, function() awful.layout.inc(1) end),
    awful.button({}, 3, function() awful.layout.inc(-1) end),
    awful.button({}, 4, function() awful.layout.inc(1) end),
    awful.button({}, 5, function() awful.layout.inc(-1) end)
  ))


  -- Create a tasklist widget
  s.mytasklist = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, awful.util.tasklist_buttons)


  s.mybottomwibox = awful.wibar({
    position = "top",
    screen = s,
    width = dpi(s.geometry.width - 4 * theme.useless_gap),
    height = 2 * theme.useless_gap,
    -- type = 'dock',
    bg = "#282828",
  })


  -- Create the wibox
  s.mywibox = awful.wibar({
    position = "top",
    screen = s,
    width = dpi(s.geometry.width - 4 * theme.useless_gap),
    x = (s.geometry.width - 10),
    y = dpi(s.geometry.height + 12),
    height = dpi(34),
    type = 'dock',
    shape = function(cr, w, h) gears.shape.rounded_rect(cr, w, h, dpi(5)) end,
    border_width = dpi(1),
    -- border_color = "#ebdbb2",
    border_color = "#1d2021",
  })

  s.mysystree = wibox.widget.systray({
    forced_height = dpi(0),
    forced_width  = dpi(0),
    opacity       = 0,
    visible       = true,
    bg            = "#282828",
  })

  -- Add widgets to the wibox
  s.mywibox:setup {
    layout = wibox.layout.align.horizontal,
    { -- Left widgets
      layout = wibox.layout.fixed.horizontal,
      mylauncher,
      s.mytaglist,
      movel,
      close,
      max,
      mover,
    },

    s.mytasklist,         -- Middle widget

    {                     -- Right widgets
      layout = wibox.layout.fixed.horizontal,
      --vol.widget,
      theme.volume.widget,
      mem.widget,
      cpu.widget,
      bat.widget,
      --net.widget,
      clock,
      -- s.mylayoutbox,
      copy,
      onboard,
      keyboardlayout,
      showtray,
      -- wibox.widget.systray(),
      -- wibox.widget.systray {forced_width = dpi(1)},
      s.mysystree,
    },
  }
end

return theme
