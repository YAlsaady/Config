

-- {{{ Required libraries
--[[

     Awesome WM configuration template
     https://github.com/awesomeWM

     Freedesktop : https://github.com/lcpz/awesome-freedesktop

     Copycats themes : https://github.com/lcpz/awesome-copycats

     lain : https://github.com/lcpz/lain

--]]

local awesome, client, mouse, screen, tag = awesome, client, mouse, screen, tag
local ipairs, string, os, table, tostring, tonumber, type = ipairs, string, os, table, tostring, tonumber, type

--https://awesomewm.org/doc/api/documentation/05-awesomerc.md.html
-- Standard awesome library
local gears         = require("gears") --Utilities such as color parsing and objects
local awful         = require("awful") --Everything related to window managment
                      require("awful.autofocus")
-- Widget and layout library
local wibox         = require("wibox")

-- Theme handling library
local beautiful     = require("beautiful")

-- Notification library
local naughty       = require("naughty")
naughty.config.defaults['icon_size'] = 100

local menubar       = require("menubar")

local lain          = require("lain")
local freedesktop   = require("freedesktop")

-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
local hotkeys_popup = require("awful.hotkeys_popup").widget
                      -- require("awful.hotkeys_popup.keys")
local my_table      = awful.util.table or gears.table -- 4.{0,1} compatibility
local dpi           = require("beautiful.xresources").apply_dpi

require("keybinding")
require("rules")
-- }}}


-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = tostring(err) })
        in_error = false
    end)
end
-- }}}


-- {{{ Autostart windowless processes
local function run_once(cmd_arr)
    for _, cmd in ipairs(cmd_arr) do
        awful.spawn.with_shell(string.format("pgrep -u $USER -fx '%s' > /dev/null || (%s)", cmd, cmd))
    end
end

run_once({ "unclutter -root"}) -- entries must be comma-separated
-- run_once({ "unclutter -root", "whatsapp-nativefier" }) -- entries must be comma-separated
-- }}}


-- {{{ Variable definitions

-- keep themes in alfabetical order for ATT
local themes = {
    "alsaady",         -- 1
    "blackburn",       -- 2
    "copland",         -- 3
    "dremora",         -- 4
    "holo",            -- 5
    "multicolor",      -- 6
    "powerarrow",      -- 7
    "powerarrow-blue", -- 8    
    "powerarrow-dark", -- 9
    "rainbow",         -- 10
    "steamburn",       -- 11
    "vertex"           -- 12

    --"blackburn",		-- 1
    --"copland",      	-- 2
    --"multicolor",	 	-- 3
    --"powerarrow",		-- 4    

}

-- choose your theme here
local chosen_theme = themes[1]

local theme_path = string.format("%s/.config/awesome/themes/%s/theme.lua", os.getenv("HOME"), chosen_theme)
beautiful.init(theme_path)

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

-- awesome variables
awful.util.terminal = terminal
awful.util.tagnames = {  "➊", "➋", "➌", "➍", "➎", "➏", "➐", "➑", "➒" }
--awful.util.tagnames = { "", "", "", "", "" }
-- Use this : https://fontawesome.com/cheatsheet

awful.layout.suit.tile.left.mirror = true
awful.layout.layouts = {
    awful.layout.suit.tile,
    awful.layout.suit.floating,
    awful.layout.suit.max,
    awful.layout.suit.tile.top,
    awful.layout.suit.tile.bottom,
    -- lain.layout.centerwork,
    -- awful.layout.suit.fair.horizontal,
    -- awful.layout.suit.max.fullscreen,
    --awful.layout.suit.tile.left,
    -- awful.layout.suit.fair,
    --awful.layout.suit.spiral,
    --awful.layout.suit.spiral.dwindle,
    --awful.layout.suit.magnifier,
    --awful.layout.suit.corner.nw,
    --awful.layout.suit.corner.ne,
    --awful.layout.suit.corner.sw,
    --awful.layout.suit.corner.se,
    -- lain.layout.cascade,
    --lain.layout.cascade.tile,
    -- lain.layout.centerwork.horizontal,
    --lain.layout.termfair,
    --lain.layout.termfair.center,
}


lain.layout.termfair.nmaster           = 3
lain.layout.termfair.ncol              = 1
lain.layout.termfair.center.nmaster    = 3
lain.layout.termfair.center.ncol       = 1
lain.layout.cascade.tile.offset_x      = dpi(2)
lain.layout.cascade.tile.offset_y      = dpi(32)
lain.layout.cascade.tile.extra_padding = dpi(5)
lain.layout.cascade.tile.nmaster       = 5
lain.layout.cascade.tile.ncol          = 2

beautiful.init(string.format("%s/.config/awesome/themes/%s/theme.lua", os.getenv("HOME"), chosen_theme))
-- }}}


-- {{{ Menu
local myawesomemenu = {
    --{ "File Manager", "dolphin" },
    --{ "thunar", "thunar" },
    { "Nautilus", "nautilus" },
    { "Xournal++", "xournalpp" },
    { "Brave", browser1 },
    { "Ranger", "alacritty -e ranger" },
    { "VS Code", "code" },
    { "Spotify", "spotify" },
    { "Pulseaudio", "pavucontrol" },
    { "GeoGebra", "geogebra" },
    { "", "" },
}

local scripts = {
    {"Config","alacritty -e nvim .script/config.sh"},
    {"Power","alacritty -e .script/power"},
    {"Rotation","alacritty -e nvim .script/rotation.sh"},
    {"Windows 10","alacritty -e nvim .script/Winndows10.sh"},
}

local config = {
    {"Awesome","alacritty -e nvim ~/.config/awesome"},
}

awful.util.mymainmenu = freedesktop.menu.build({
    before = {
        { "MyApps", myawesomemenu },
        { "Scripts", scripts },
        {"Config-File", config},
        --{ "Atom", "atom" },
        -- other triads can be put here
    },
    after = {
        { "Terminal", terminal },
        { "Log out", function() awesome.quit() end },
        { "Sleep", "systemctl suspend" },
        { "Restart", "systemctl reboot" },
        { "Shutdown", "systemctl poweroff" },
        -- other triads can be put here
    }
})
-- hide menu when mouse leaves it
--awful.util.mymainmenu.wibox:connect_signal("mouse::leave", function() awful.util.mymainmenu:hide() end)

menubar.utils.terminal = terminal -- Set the Menubar terminal for applications that require it
-- }}}


-- {{{ Screen
-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", function(s)
    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end)

-- No borders when rearranging only 1 non-floating or maximized client
screen.connect_signal("arrange", function (s)
    local only_one = #s.tiled_clients == 1
    for _, c in pairs(s.clients) do
        if only_one and not c.floating or c.maximized then
            -- c.border_width = 0
            c.border_width = beautiful.border_width
        else
            c.border_width = beautiful.border_width
        end
    end
end)
-- Create a wibox for each screen and add it
awful.screen.connect_for_each_screen(function(s) beautiful.at_screen_connect(s)
    s.systray = wibox.widget.systray()
    s.systray.visible = false
 end)
-- }}}


-- {{{ Keys
    -- Function keys
    -- awful.key({ modkey }, "F12", function () awful.util.spawn( "xfce4-terminal --drop-down" ) end,
    --     {description = "dropdown terminal" , group = "function keys"}),


    -- super + ... function keys

    --[[
    awful.key({ modkey }, "F1", 
    function () awful.util.spawn( browser1 ) end,
    {description = browser1, group = "function keys"}),
    awful.key({ modkey }, "F2", function () awful.util.spawn( editorgui ) end,
        {description = editorgui , group = "function keys" }),
    awful.key({ modkey }, "F3", function () awful.util.spawn( "inkscape" ) end,
        {description = "inkscape" ,group = "function keys" }),
    awful.key({ modkey }, "F4", function () awful.util.spawn( "gimp" ) end,
        {description = "gimp" , group = "function keys" }),
    awful.key({ modkey }, "F5", function () awful.util.spawn( "meld" ) end,
        {description = "meld" , group = "function keys" }),
    awful.key({ modkey }, "F6", function () awful.util.spawn( "vlc --video-on-top" ) end,
        {description = "vlc" , group = "function keys" }),
    awful.key({ modkey }, "F7", function () awful.util.spawn( "virtualbox" ) end,
        {description = wm , group = "function keys" }),
    awful.key({ modkey }, "F8", function () awful.util.spawn( filemanager ) end,
        {description = filemanager , group = "function keys" }),
    awful.key({ modkey }, "F9", function () awful.util.spawn( mailclient ) end,
        {description = mailclient , group = "function keys" }),
    awful.key({ modkey }, "F10", function () awful.util.spawn( mediaplayer ) end,
        {description = mediaplayer , group = "function keys" }),
    awful.key({ modkey }, "F11", function () awful.util.spawn( "rofi -theme-str 'window {width: 100%;height: 100%;}' -show drun" ) end,
        {description = "rofi fullscreen" , group = "function keys" }),
    awful.key({ modkey }, "F12", function () awful.util.spawn( "rofi -show drun" ) end,
        {description = "rofi" , group = "function keys" }),
    --]]


    -- ctrl+alt +  ...
    -- awful.key({ modkey1, altkey   }, "e", function() awful.util.spawn( "archlinux-tweak-tool" ) end,
    --     {description = "ArchLinux Tweak Tool", group = "alt+ctrl"}),
    -- awful.key({ modkey1, altkey   }, "a", function() awful.util.spawn( "xfce4-appfinder" ) end,
    --     {description = "Xfce appfinder", group = "alt+ctrl"}),
    -- awful.key({ modkey1, altkey   }, "b", function() awful.util.spawn( filemanager ) end,
    --     {description = filemanager, group = "alt+ctrl"}),
    -- awful.key({ modkey1, altkey   }, "c", function() awful.util.spawn("catfish") end,
    --     {description = "catfish", group = "alt+ctrl"}),
    -- awful.key({ modkey1, altkey   }, "f", function() awful.util.spawn( browser2 ) end,
    --     {description = browser2, group = "alt+ctrl"}),
    -- awful.key({ modkey1, altkey   }, "s", function() awful.util.spawn( mediaplayer ) end,
    --     {description = mediaplayer, group = "alt+ctrl"}),
    -- awful.key({ modkey1, altkey   }, "t", function() awful.util.spawn( terminal ) end,
    --     {description = terminal, group = "alt+ctrl"}),
    -- awful.key({ modkey1, altkey   }, "u", function() awful.util.spawn( "pavucontrol" ) end,
    --     {description = "pulseaudio control", group = "alt+ctrl"}),
    -- awful.key({ modkey1, altkey   }, "m", function() awful.util.spawn( "xfce4-settings-manager" ) end,
    --     {description = "Xfce settings manager", group = "alt+ctrl"}),
    -- awful.key({ modkey1, altkey   }, "p", function() awful.util.spawn( "pamac-manager" ) end,
    --     {description = "Pamac Manager", group = "alt+ctrl"}),

    --awful.key({ modkey1, altkey   }, "w", function() awful.util.spawn( "arcolinux-welcome-app" ) end,
      --  {description = "ArcoLinux Welcome App", group = "alt+ctrl"}),
    --awful.key({ modkey1, altkey   }, "Next", function() awful.util.spawn( "conky-rotate -n" ) end,
      --  {description = "Next conky rotation", group = "alt+ctrl"}),
    --awful.key({ modkey1, altkey   }, "Prior", function() awful.util.spawn( "conky-rotate -p" ) end,
      --  {description = "Previous conky rotation", group = "alt+ctrl"}),
    --awful.key({ modkey1, altkey   }, "g", function() awful.util.spawn( browser3 ) end,
      --  {description = browser3, group = "alt+ctrl"}),
    --awful.key({ modkey1, altkey   }, "i", function() awful.util.spawn("nitrogen") end,
      --  {description = nitrogen, group = "alt+ctrl"}),
    --awful.key({ modkey1, altkey   }, "k", function() awful.util.spawn( "arcolinux-logout" ) end,
      --  {description = scrlocker, group = "alt+ctrl"}),
    --awful.key({ modkey1, altkey   }, "l", function() awful.util.spawn( "arcolinux-logout" ) end,
        --{description = scrlocker, group = "alt+ctrl"}),
    --awful.key({ modkey1, altkey   }, "v", function() awful.util.spawn( browser1 ) end,
        --{description = browser1, group = "alt+ctrl"}),
    --awful.key({ modkey1, altkey   }, "Return", function() awful.util.spawn(terminal) end,
        --{description = terminal, group = "alt+ctrl"}),

    -- alt + ...
    --awful.key({ altkey, "Shift"   }, "t", function () awful.spawn.with_shell( "variety -t  && wal -i $(cat $HOME/.config/variety/wallpaper/wallpaper.jpg.txt)&" ) end,
      --  {description = "Pywal Wallpaper trash", group = "altkey"}),
    --awful.key({ altkey, "Shift"   }, "n", function () awful.spawn.with_shell( "variety -n  && wal -i $(cat $HOME/.config/variety/wallpaper/wallpaper.jpg.txt)&" ) end,
      --  {description = "Pywal Wallpaper next", group = "altkey"}),
    --awful.key({ altkey, "Shift"   }, "u", function () awful.spawn.with_shell( "wal -i $(cat $HOME/.config/variety/wallpaper/wallpaper.jpg.txt)&" ) end,
      --  {description = "Pywal Wallpaper update", group = "altkey"}),
    --awful.key({ altkey, "Shift"   }, "p", function () awful.spawn.with_shell( "variety -p  && wal -i $(cat $HOME/.config/variety/wallpaper/wallpaper.jpg.txt)&" ) end,
      --  {description = "Pywal Wallpaper previous", group = "altkey"}),
    --awful.key({ altkey }, "t", function () awful.util.spawn( "variety -t" ) end,
      --  {description = "Wallpaper trash", group = "altkey"}),
    --awful.key({ altkey }, "n", function () awful.util.spawn( "variety -n" ) end,
      --  {description = "Wallpaper next", group = "altkey"}),
    --awful.key({ altkey }, "p", function () awful.util.spawn( "variety -p" ) end,
      --  {description = "Wallpaper previous", group = "altkey"}),
    --awful.key({ altkey }, "f", function () awful.util.spawn( "variety -f" ) end,
      --  {description = "Wallpaper favorite", group = "altkey"}),
    --awful.key({ altkey }, "Left", function () awful.util.spawn( "variety -p" ) end,
      --  {description = "Wallpaper previous", group = "altkey"}),
    --awful.key({ altkey }, "Right", function () awful.util.spawn( "variety -n" ) end,
        --{description = "Wallpaper next", group = "altkey"}),
    --awful.key({ altkey }, "Up", function () awful.util.spawn( "variety --pause" ) end,
        --{description = "Wallpaper pause", group = "altkey"}),
    --awful.key({ altkey }, "Down", function () awful.util.spawn( "variety --resume" ) end,
        --{description = "Wallpaper resume", group = "altkey"}),
    --awful.key({ altkey }, "F2", function () awful.util.spawn( "xfce4-appfinder --collapsed" ) end,
        --{description = "Xfce appfinder", group = "altkey"}),
    --awful.key({ altkey }, "F3", function () awful.util.spawn( "xfce4-appfinder" ) end,
        --{description = "Xfce appfinder", group = "altkey"}),
    -- awful.key({ altkey }, "F5", function () awful.spawn.with_shell( "xlunch --config ~/.config/xlunch/default.conf --input ~/.config/xlunch/entries.dsv" ) end,
    --    {description = "Xlunch app launcher", group = "altkey"}),


    -- Personal keybindings


    -- === Move client to Screen ===

    -- awful.key({ modkey, "Shift"   }, "Tab",   function (c) c:move_to_screen()               end,
    --           {description = "move to screen", group = "client"}),



    -- Hotkeys Awesome


    --[[
     -- Tag browsing modkey + tab
    awful.key({ modkey,           }, "Tab",   awful.tag.viewnext,
        {description = "view next", group = "tag"}),
    awful.key({ modkey, "Shift"   }, "Tab",  awful.tag.viewprev,
        {description = "view previous", group = "tag"}),

    -- Tag browsing with modkey
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev,
        {description = "view previous", group = "tag"}),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext,
        {description = "view next", group = "tag"}),

    -- Default client focus
    awful.key({ altkey, modkey          }, "j",
        function ()
            awful.client.focus.byidx( 1)
        end,
        {description = "focus next by index", group = "client"}
    ),
    awful.key({ altkey, modkey          }, "k",
        function ()
            awful.client.focus.byidx(-1)
        end,
        {description = "focus previous by index", group = "client"}
    ),

    -- By direction client focus
    awful.key({ modkey }, "j",
        function()
            awful.client.focus.global_bydirection("down")
            if client.focus then client.focus:raise() end
        end,
        {description = "focus down", group = "client"}),
    awful.key({ modkey }, "k",
        function()
            awful.client.focus.global_bydirection("up")
            if client.focus then client.focus:raise() end
        end,
        {description = "focus up", group = "client"}),
    awful.key({ modkey }, "h",
        function()
            awful.client.focus.global_bydirection("left")
            if client.focus then client.focus:raise() end
        end,
        {description = "focus left", group = "client"}),
    awful.key({ modkey }, "l",
        function()
            awful.client.focus.global_bydirection("right")
            if client.focus then client.focus:raise() end
        end,
        {description = "focus right", group = "client"}),

        -- By direction client focus with arrows
        awful.key({ modkey1, modkey }, "Down",
            function()
                awful.client.focus.global_bydirection("down")
                if client.focus then client.focus:raise() end
            end,
            {description = "focus down", group = "client"}),
        awful.key({ modkey1, modkey }, "Up",
            function()
                awful.client.focus.global_bydirection("up")
                if client.focus then client.focus:raise() end
            end,
            {description = "focus up", group = "client"}),
        awful.key({ modkey1, modkey }, "Left",
            function()
                awful.client.focus.global_bydirection("left")
                if client.focus then client.focus:raise() end
            end,
            {description = "focus left", group = "client"}),
        awful.key({ modkey1, modkey }, "Right",
            function()
                awful.client.focus.global_bydirection("right")
                if client.focus then client.focus:raise() end
            end,
            {description = "focus right", group = "client"}),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end,
              {description = "swap with next client by index", group = "client"}),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end,
              {description = "swap with previous client by index", group = "client"}),

    -- Screen
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end,
              {description = "focus the next screen", group = "screen"}),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end,
              {description = "focus the previous screen", group = "screen"}),

    awful.key({ modkey, "Shift"   }, "Left",   function (c) c:move_to_screen()               end,
              {description = "move to screen", group = "client"}),
    awful.key({ modkey, "Shift"   }, "Right",  function (c) c:move_to_screen()               end,
              {description = "move to screen", group = "client"}),
    --]]



    -- awful.key({ modkey,           }, "s",      hotkeys_popup.show_help,
    --     {description = "show help", group="awesome"}),


    --awful.key({ altkey,           }, "Escape", awful.tag.history.restore,
        --{description = "go back", group = "tag"}),

     -- Tag browsing alt + tab
    --awful.key({ altkey,           }, "Tab",   awful.tag.viewnext,
        --{description = "view next", group = "tag"}),
    --awful.key({ altkey, "Shift"   }, "Tab",  awful.tag.viewprev,
        --{description = "view previous", group = "tag"}),



    -- Non-empty tag browsing
    --awful.key({ modkey }, "Left", function () lain.util.tag_view_nonempty(-1) end,
              --{description = "view  previous nonempty", group = "tag"}),
   -- awful.key({ modkey }, "Right", function () lain.util.tag_view_nonempty(1) end,
             -- {description = "view  next nonempty", group = "tag"}),



    -- awful.key({ modkey,           }, "u", awful.client.urgent.jumpto,
    --           {description = "jump to urgent client", group = "client"}),

--    awful.key({ modkey1,           }, "Tab",
--        function ()
--            awful.client.focus.history.previous()
--            if client.focus then
--                client.focus:raise()
--            end
--        end,
--        {description = "go back", group = "client"}),


 -- -- Show/Hide Systray
 --    awful.key({ modkey }, "KP_Subtract", function ()
 --    awful.screen.focused().systray.visible = not awful.screen.focused().systray.visible
 --    end, {description = "Toggle systray visibility", group = "awesome"}),




    -- Dynamic tagging
    -- awful.key({ modkey, "Shift" }, "n", function () lain.util.add_tag() end,
    --           {description = "add new tag", group = "tag"}),
    -- awful.key({ modkey, "Control" }, "r", function () lain.util.rename_tag() end,
    --           {description = "rename tag", group = "tag"}),
    -- awful.key({ modkey, "Shift" }, "y", function () lain.util.delete_tag() end,
    --           {description = "delete tag", group = "tag"}),


    -- awful.key({ modkey, "Shift" }, "Left", function () lain.util.move_tag(-1) end,
    --          {description = "move tag to the left", group = "tag"}),
    -- awful.key({ modkey, "Shift" }, "Right", function () lain.util.move_tag(1) end,
    --          {description = "move tag to the right", group = "tag"}),


    --awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(-1)                end,
             -- {description = "select previous", group = "layout"}),


    -- Widgets popups
    --awful.key({ altkey, }, "c", function () lain.widget.calendar.show(7) end,
        --{description = "show calendar", group = "widgets"}),
    --awful.key({ altkey, }, "h", function () if beautiful.fs then beautiful.fs.show(7) end end,
              --{description = "show filesystem", group = "widgets"}),
    --awful.key({ altkey, }, "w", function () if beautiful.weather then beautiful.weather.show(7) end end,
              --{description = "show weather", group = "widgets"}),

--Media keys supported by mpd.
    -- awful.key({}, "XF86AudioPlay", function () awful.util.spawn("mpc toggle") end),
    -- awful.key({}, "XF86AudioNext", function () awful.util.spawn("mpc next") end),
    -- awful.key({}, "XF86AudioPrev", function () awful.util.spawn("mpc prev") end),
    -- awful.key({}, "XF86AudioStop", function () awful.util.spawn("mpc stop") end),

    -- MPD control
    -- awful.key({ modkey1, "Shift" }, "Up",
    --     function ()
    --         os.execute("mpc toggle")
    --         beautiful.mpd.update()
    --     end,
    --     {description = "mpc toggle", group = "widgets"}),
    -- awful.key({ modkey1, "Shift" }, "Down",
    --     function ()
    --         os.execute("mpc stop")
    --         beautiful.mpd.update()
    --     end,
    --     {description = "mpc stop", group = "widgets"}),
    -- awful.key({ modkey1, "Shift" }, "Left",
    --     function ()
    --         os.execute("mpc prev")
    --         beautiful.mpd.update()
    --     end,
    --     {description = "mpc prev", group = "widgets"}),
    -- awful.key({ modkey1, "Shift" }, "Right",
    --     function ()
    --         os.execute("mpc next")
    --         beautiful.mpd.update()
    --     end,
    --     {description = "mpc next", group = "widgets"}),
    -- awful.key({ modkey1, "Shift" }, "s",
    --
    --
    --     function ()
    --        local common = { text = "MPD widget ", position = "top_middle", timeout = 2 }
    --         if beautiful.mpd.timer.started then
    --            beautiful.mpd.timer:stop()
    --             common.text = common.text .. lain.util.markup.bold("OFF")
    --         else
    --            beautiful.mpd.timer:start()
    --             common.text = common.text .. lain.util.markup.bold("ON")
    --         end
    --         naughty.notify(common)
    --     end,
    --     {description = "mpc on/off", group = "widgets"})

    -- Copy primary to clipboard (terminals to gtk)
    --awful.key({ modkey }, "c", function () awful.spawn.with_shell("xsel | xsel -i -b") end,
             -- {description = "copy terminal to gtk", group = "hotkeys"}),
     --Copy clipboard to primary (gtk to terminals)
    --awful.key({ modkey }, "v", function () awful.spawn.with_shell("xsel -b | xsel") end,
              --{description = "copy gtk to terminal", group = "hotkeys"}),


    -- Default
    --[[ Menubar

    awful.key({ modkey }, "p", function() menubar.show() end,
              {description = "show the menubar", group = "hotkeys"})
    --]]

    -- awful.key({ altkey }, "x",
    --           function ()
    --               awful.prompt.run {
    --                 prompt       = "Run Lua code: ",
    --                 textbox      = awful.screen.focused().mypromptbox.widget,
    --                 exe_callback = awful.util.eval,
    --                 history_path = awful.util.get_cache_dir() .. "/history_eval"
    --               }
    --           end,
    --           {description = "lua execute prompt", group = "awesome"})
    --]]
-- }}}


-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    if not awesome.startup then awful.client.setslave(c) end

    if awesome.startup and
      not c.size_hints.user_position
      and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
    -- Custom
    if beautiful.titlebar_fun then
        beautiful.titlebar_fun(c)
        return
    end

    -- Default
    -- buttons for the titlebar
    local buttons = my_table.join(
        awful.button({ }, 1, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.move(c)
        end),
        awful.button({ }, 3, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.resize(c)
        end)
    )

    awful.titlebar(c, {size = dpi(00)}) : setup {
        { -- Left
            --awful.titlebar.widget.iconwidget(c),
            --awful.titlebar.widget.maximizedbutton(c),
            layout  = wibox.layout.fixed.horizontal
        },
        { -- Middle
            --{ -- Title
                --align  = "center",
                --widget = awful.titlebar.widget.titlewidget(c)
            --},
            buttons = buttons,
            layout  = wibox.layout.fixed.horizontal
        },
        { -- Right
            --awful.titlebar.widget.floatingbutton (c),
            --awful.titlebar.widget.maximizedbutton(c),
            --awful.titlebar.widget.stickybutton   (c),
            --awful.titlebar.widget.ontopbutton    (c),
            --awful.titlebar.widget.closebutton    (c),
            layout = wibox.layout.fixed.horizontal()
        },
        layout = wibox.layout.align.horizontal
    }
end)

-- Enable sloppy focus, so that focus follows mouse.
--client.connect_signal("mouse::enter", function(c)
--    c:emit_signal("request::activate", "mouse_enter", {raise = false})
--end)

client.connect_signal("focus", function(c) c.border_color = beautiful.taglist_fg_focus end)
-- client.connect_signal("focus", function(c) c.border_color = "#D16319" end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)


-- }}}


-- {{{ Autostart applications
awful.spawn.with_shell("~/.config/awesome/autostart.sh")
-- awful.spawn.with_shell("whatsapp-nativefier")
-- awful.spawn.with_shell("nm-applet")
-- awful.spawn.with_shell("owncloud")
-- awful.spawn.with_shell("~/.script/xinput.sh")
-- awful.spawn.with_shell("picom -b --config  $HOME/.config/awesome/picom.conf")
-- awful.spawn.with_shell("nitrogen --set-scaled --random ~/Wallpaper1/Wallpaper")
-- awful.spawn.with_shell("xfce4-power-manager")
-- awful.spawn.with_shell("/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1")



-- awful.spawn.with_shell("nitrogen --set-centered --random ~/Wallpaper1/Wallpaper")
--awful.spawn.with_shell("onboard")
--awful.spawn.with_shell("gnome-screensaver")
--awful.spawn.with_shell("xautolock -time 5 -locker 'gnome-screensaver-command -l'")
--
--/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &&
--$HOME/.script/xinput.sh &&
--picom -b --config  $HOME/.config/awesome/picom.conf &&
--nitrogen --set-scaled --random $HOME/Wallpaper1 &&
--xfce4-power-manager &&
--}}}


-- vim:foldmethod=marker
