

-- {{{ Required libraries
local awesome, client, mouse, screen, tag = awesome, client, mouse, screen, tag
local ipairs, string, os, table, tostring, tonumber, type = ipairs, string, os, table, tostring, tonumber, type

--https://awesomewm.org/doc/api/documentation/05-awesomerc.md.html
-- Standard awesome library
local gears         = require("gears") --Utilities such as color parsing and objects
local awful         = require("awful") --Everything related to window managment
                      require("awful.autofocus")

-- Theme handling library
local beautiful     = require("beautiful")

-- Notification library
local naughty       = require("naughty")
naughty.config.defaults['icon_size'] = 100

local lain          = require("lain")
-- local freedesktop   = require("freedesktop")

local hotkeys_popup = require("awful.hotkeys_popup").widget
local my_table      = awful.util.table or gears.table -- 4.{0,1} compatibility
local dpi           = require("beautiful.xresources").apply_dpi
-- }}}


-- {{{ Variable definitions
-- modkey or mod4 = super key
local modkey       = "Mod4"
local altkey       = "Mod1"
local modkey1      = "Control"

-- personal variables
--change these variables if you want
local browser1          = "brave"
local browser2          = "firefox"
local editor            = "nvim"
local editorgui         = "code"
local filemanager       = "thunar"
local mediaplayer       = "spotify"
local terminal          = "alacritty"
local wm                = "virtualbox"
-- }}}


-- {{{ Mouse bindings
awful.util.taglist_buttons = my_table.join(
    awful.button({ }, 1, function(t) t:view_only() end),
    awful.button({ modkey }, 1, function(t)
        if client.focus then
            client.focus:move_to_tag(t)
        end
    end),
    awful.button({ }, 3, awful.tag.viewtoggle),
    awful.button({ modkey }, 3, function(t)
        if client.focus then
            client.focus:toggle_tag(t)
        end
    end),
    awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
    awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
)

awful.util.tasklist_buttons = my_table.join(
    awful.button({ }, 1, function (c)
        if c == client.focus then
            c.minimized = true
        else
            --c:emit_signal("request::activate", "tasklist", {raise = true})<Paste>

            -- Without this, the following
            -- :isvisible() makes no sense
            c.minimized = false
            if not c:isvisible() and c.first_tag then
                c.first_tag:view_only()
            end
            -- This will also un-minimize
            -- the client, if needed
            client.focus = c
            c:raise()
        end
    end),
    awful.button({ }, 3, function ()
        local instance = nil

        return function ()
            if instance and instance.wibox.visible then
                instance:hide()
                instance = nil
            else
                instance = awful.menu.clients({theme = {width = dpi(250)}})
            end
        end
    end),
    awful.button({ }, 4, function () awful.client.focus.byidx(1) end),
    awful.button({ }, 5, function () awful.client.focus.byidx(-1) end)
)

root.buttons(my_table.join(
    awful.button({ }, 3, function () awful.util.mymainmenu:toggle() end)
    --awful.button({ }, 4, awful.tag.viewnext),
  --  awful.button({ }, 5, awful.tag.viewprev)
))

clientbuttons = gears.table.join(
    awful.button({ }, 1, function (c)
        if c.name ~= "Onboard" then
            client.focus = c
            c:emit_signal("request::activate", "mouse_click", {raise = true})
        end
        --c:emit_signal("request::activate", "mouse_click", {raise = true})
    end),
    awful.button({ modkey }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.move(c)
    end),
    awful.button({ modkey }, 3, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.resize(c)
    end)
)
-- }}}


-- {{{ global key
globalkeys = my_table.join(

-- {{{ Personal keybindings
    awful.key({ modkey,           }, "Return", function () awful.spawn(terminal) end,
        {description = terminal, group = "hotkeys"}),
    awful.key({ modkey }, "w", function () awful.util.spawn( browser1 ) end,
        {description = browser1, group = "hotkeys"}),
    awful.key({ modkey }, "o", function () awful.util.spawn( "xournalpp" ) end,
        {description = "Xournalpp", group = "hotkeys"}),
    awful.key({ modkey }, "ä", function () awful.util.spawn( "whatsapp-nativefier" ) end,
        {description = "Whatsapp", group = "hotkeys"}),
    awful.key({ modkey}, "d", function ()
        awful.spawn(string.format("dmenu_run -i -nb '#000000' -nf '#ffffff' -sb '#ffffff' -sf '#000000' -fn DejaVuSansMonoNerdFont:bold:pixelsize=15 -b",
        beautiful.bg_normal, beautiful.fg_normal, beautiful.bg_focus, beautiful.fg_focus))
	end,
        {description = "show dmenu", group = "hotkeys"}),
    awful.key({ modkey }, "i",  function () awful.spawn.with_shell( "cd ~/Studium/2.Semster/Hardwarenahe_Programmierung/ && /home/yaman/Studium/2.Semster/Hardwarenahe_Programmierung/SBC86_Simulator/sbc86sim_linux_qt5_x86_64_1.2.5/simu86" ) end,
        {description = "simu86", group = "hotkeys"}),

    -- super + ...
    awful.key({ modkey }, "c", function () awful.spawn.with_shell( "~/.script/config.sh" ) end,
        {description = "Dot", group = "hotkeys"}),
    awful.key({ modkey }, "u", function () awful.spawn.with_shell( "~/.script/toggle_screen" ) end,
        {description = "Dot", group = "hotkeys"}),
    awful.key({ modkey }, "e", function () awful.util.spawn( "code" ) end,
        {description = "run gui editor", group = "hotkeys"}),
    awful.key({ modkey }, "r", function () awful.util.spawn( "rofi-theme-selector" ) end,
        {description = "rofi theme selector", group = "hotkeys"}),
    awful.key({ modkey }, "a", function () awful.util.spawn( "alacritty -e ranger" ) end,
        {description = "Ranger", group = "hotkeys"}),
    awful.key({ modkey }, "y", function () awful.util.spawn( "alacritty -e ranger ./Studium" ) end,
        {description = "Studium", group = "hotkeys"}),
    awful.key({ modkey }, "v", function () awful.util.spawn( "pavucontrol" ) end,
        {description = "pulseaudio control", group = "hotkeys"}),
    awful.key({ modkey }, "ü", function () awful.util.spawn( "xfce4-power-manager-settings" ) end,
        {description = "pulseaudio control", group = "hotkeys"}),
    awful.key({ modkey }, "x",  function () awful.spawn.with_shell( "~/.script/power.sh" ) end,
        {description = "exit", group = "hotkeys"}),
    awful.key({ modkey }, "t",  function () awful.util.spawn( "slock" ) end,
        {description = "slock", group = "hotkeys"}),
    awful.key({ modkey }, "Escape", function () awful.util.spawn( "xkill" ) end,
        {description = "Kill proces", group = "hotkeys"}),

    -- super + shift + ...
    awful.key({ modkey, "Shift"   }, "Return", function() awful.util.spawn( filemanager ) end),
    awful.key({ modkey, "Shift"   }, "e", function() awful.util.spawn("arduino-ide") end),

    -- ctrl + shift + ...
    awful.key({ modkey1, "Shift"  }, "Escape", function() awful.util.spawn("xfce4-taskmanager") end),

    -- ctrl+alt +  ...
    awful.key({ modkey1, altkey   }, "o", function() awful.spawn.with_shell("$HOME/.config/awesome/scripts/picom-toggle.sh") end,
        {description = "Picom toggle", group = "alt+ctrl"}),

    -- screenshots
    awful.key({ }, "Print", function () awful.util.spawn("scrot 'ArcoLinux-%Y-%m-%d-%s_screenshot_$wx$h.jpg' -e 'mv $f $$(xdg-user-dir PICTURES)'") end,
        {description = "Scrot", group = "screenshots"}),
    awful.key({ modkey1, modkey }, "p", function () awful.spawn.with_shell( "maim -s -u | xclip -selection clipboard -t image/png -i" ) end,
        {description = "screenshot | xclip", group = "screenshots"}),
    awful.key({ modkey1, "Shift"  }, "p", function() awful.util.spawn("gnome-screenshot -i") end,
        {description = "Gnome screenshot", group = "screenshots"}),

    -- Brightness
    awful.key({ }, "XF86MonBrightnessUp", function () os.execute("xbacklight -inc 10") end),
    --          {description = "+10%", group = "hotkeys"}),
    awful.key({ }, "XF86MonBrightnessDown", function () os.execute("xbacklight -dec 10") end),
    --          {description = "-10%", group = "hotkeys"}),

    -- ALSA volume control
    awful.key({ }, "XF86AudioRaiseVolume",
        function ()
            os.execute(string.format("amixer -q set %s 5%%+", beautiful.volume.channel))
            beautiful.volume.update()
        end),
    awful.key({ }, "XF86AudioLowerVolume",
        function ()
            os.execute(string.format("amixer -q set %s 5%%-", beautiful.volume.channel))
            beautiful.volume.update()
        end),
    awful.key({ }, "XF86AudioMute",
        function ()
            os.execute(string.format("amixer -q set %s toggle", beautiful.volume.togglechannel or beautiful.volume.channel))
            beautiful.volume.update()
        end),
    awful.key({ modkey1, "Shift" }, "m",
        function ()
            os.execute(string.format("amixer -q set %s 100%%", beautiful.volume.channel))
            beautiful.volume.update()
        end),
    awful.key({ modkey1, "Shift" }, "0",
        function ()
            os.execute(string.format("amixer -q set %s 0%%", beautiful.volume.channel))
            beautiful.volume.update()
        end),

    --Media keys supported by vlc, spotify, audacious, xmm2, ...
    awful.key({}, "XF86AudioPlay", function() awful.util.spawn("playerctl play-pause --player=spotify", false) end),
    awful.key({}, "XF86AudioNext", function() awful.util.spawn("playerctl next --player=spotify", false) end),
    awful.key({}, "XF86AudioPrev", function() awful.util.spawn("playerctl previous --player=spotify", false) end),
    awful.key({}, "XF86AudioStop", function() awful.util.spawn("playerctl stop --player=spotify", false) end),

-- Personal keybindings }}}


-- {{{ Hotkeys Awesome

    -- === client focus ===
    awful.key({modkey}, "j",
        function ()
            awful.client.focus.byidx( 1)
        end,
        {description = "focus next by index", group = "client"}
    ),
    awful.key({modkey}, "k",
        function ()
            awful.client.focus.byidx(-1)
        end,
        {description = "focus previous by index", group = "client"}
    ),

    awful.key({modkey}, "Down",
        function ()
            awful.client.focus.byidx( 1)
        end,
        {description = "focus next by index", group = "client"}
    ),
    awful.key({modkey}, "Up",
        function ()
            awful.client.focus.byidx(-1)
        end,
        {description = "focus previous by index", group = "client"}
    ),

    -- === Tag browsing modkey ===
    awful.key({modkey}, "h",   awful.tag.viewprev,
        {description = "view previous", group = "tag"}),
    awful.key({modkey}, "l",  awful.tag.viewnext,
        {description = "view next", group = "tag"}),

    awful.key({ modkey}, "Left",   awful.tag.viewprev,
        {description = "view previous", group = "tag"}),
    awful.key({ modkey}, "Right",  awful.tag.viewnext,
        {description = "view next", group = "tag"}),


    -- === Layout manipulation ===
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end,
        {description = "swap with next client by index", group = "client"}),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end,
        {description = "swap with previous client by index", group = "client"}),

    -- === restore minimize ===
    awful.key({ modkey, "Control" }, "n", function ()
        local c = awful.client.restore()
        -- Focus restored client
        if c then
            client.focus = c
            c:raise()
        end
    end,
        {description = "restore minimized", group = "client"}),

    -- === Screen ===
    awful.key({ modkey}, "Tab", function () awful.screen.focus_relative( 1) end,
        {description = "focus the next screen", group = "screen"}),

    -- === Help menu ===
    awful.key({ modkey,           }, "s",      hotkeys_popup.show_help,
        {description = "show help", group="awesome"}),

    -- === Show/Hide Wibox ===
    awful.key({ modkey }, "b", function ()
        for s in screen do
            s.mywibox.visible = not s.mywibox.visible
            if s.mybottomwibox then
                s.mybottomwibox.visible = not s.mybottomwibox.visible
            end
        end
    end,
        {description = "toggle wibox", group = "awesome"}),

    -- === Show/Hide Systray ===
    awful.key({ modkey }, "-", function ()
        awful.screen.focused().systray.visible = not awful.screen.focused().systray.visible
    end,
        {description = "Toggle systray visibility", group = "awesome"}),

    -- On the fly useless gaps change
    awful.key({ altkey, "Control" }, "j", function () lain.util.useless_gaps_resize(1) end,
    {description = "increment useless gaps", group = "gaps"}),
    awful.key({ altkey, "Control" }, "h", function () lain.util.useless_gaps_resize(-1) end,
        {description = "decrement useless gaps", group = "gaps"}),

    -- === Reload awesomeWM ===
    awful.key({ modkey, "Shift" }, "r", awesome.restart,
              {description = "reload awesome", group = "awesome"}),

   -- === Layout === 
    awful.key({ modkey1, "Shift"   }, "l",     function () awful.tag.incmwfact( 0.05)          end,
              {description = "increase master width factor", group = "layout"}),
    awful.key({ modkey1, "Shift"   }, "h",     function () awful.tag.incmwfact(-0.05)          end,
              {description = "decrease master width factor", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1, nil, true) end,
              {description = "increase the number of master clients", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1, nil, true) end,
              {description = "decrease the number of master clients", group = "layout"}),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1, nil, true)    end,
              {description = "increase the number of columns", group = "layout"}),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1, nil, true)    end,
              {description = "decrease the number of columns", group = "layout"}),
    awful.key({ modkey , "Shift" }, "space", function () awful.layout.inc( 1)                end,
              {description = "select next", group = "layout"})

-- Hotkeys Awesome _ Test }}}


)
-- }}}


-- {{{ client keys
clientkeys = my_table.join(
    awful.key({ modkey, "Control"   }, "space",      lain.util.magnify_client,
              {description = "magnify client", group = "client"}),
    awful.key({ modkey,           }, "f",
        function (c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        {description = "toggle fullscreen", group = "client"}),

    awful.key({ modkey, "Shift"   }, "q",      function (c) c:kill()                         end,
        {description = "close", group = "hotkeys"}),
    awful.key({ modkey, },           "q",      function (c) c:kill()                         end,
        {description = "close", group = "hotkeys"}),
    awful.key({ modkey}, "space",  awful.client.floating.toggle                     ,
        {description = "toggle floating", group = "client"}),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end,
        {description = "move to master", group = "client"}),

    -- Test
    awful.key({ modkey, "Shift"   }, "Tab",   function (c) c:move_to_screen()               end,
              {description = "move client to next screen", group = "screen"}),

    --awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end,
              --{description = "toggle keep on top", group = "client"}),
    awful.key({ modkey,           }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end ,
        {description = "minimize", group = "client"}),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized = not c.maximized
            c:raise()
        end ,
        {description = "maximize", group = "client"})
)
-- }}}


-- {{{ key numbers 

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.

for i = 1, 9 do
    local descr_view, descr_toggle, descr_move, descr_toggle_focus
    if i == 1 or i == 9 then
        descr_view = {description = "view tag #", group = "tag"}
        descr_toggle = {description = "toggle tag #", group = "tag"}
        descr_move = {description = "move focused client to tag #", group = "tag"}
        descr_toggle_focus = {description = "toggle focused client on tag #", group = "tag"}
    end

    globalkeys = my_table.join(globalkeys,

        -- View tag only.
        awful.key({ modkey }, "#" .. i + 9, function ()
            local screen = awful.screen.focused()
            local tag = screen.tags[i]
            if tag then
                tag:view_only()
            end
        end, descr_view),

        -- Toggle tag display.
        awful.key({ modkey, "Control" }, "#" .. i + 9, function ()
            local screen = awful.screen.focused()
            local tag = screen.tags[i]
            if tag then
                awful.tag.viewtoggle(tag)
            end
        end, descr_toggle),

        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "#" .. i + 9, function ()
            if client.focus then
                local tag = client.focus.screen.tags[i]
                if tag then
                    client.focus:move_to_tag(tag)
                    tag:view_only()
                end
            end
        end, descr_move),

        -- Toggle tag on focused client.
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9, function ()
            if client.focus then
                local tag = client.focus.screen.tags[i]
                if tag then
                    client.focus:toggle_tag(tag)
                end
            end
        end, descr_toggle_focus)
    )
end
--- }}}


root.keys(globalkeys)


-- vim:foldmethod=marker
