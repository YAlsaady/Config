-- {{{ Required libraries
local awesome, client, mouse, screen, tag = awesome, client, mouse, screen, tag
local ipairs, string, os, table, tostring, tonumber, type = ipairs, string, os, table, tostring, tonumber, type

local awful         = require("awful") --Everything related to window managment
                      require("awful.autofocus")

local beautiful     = require("beautiful")

-- Notification library
local naughty       = require("naughty")
naughty.config.defaults['icon_size'] = 100

require("keybinding")

local mediaplayer       = "spotify"


-- }}}


-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     raise = true,
                     keys = clientkeys,
                     buttons = clientbuttons,
                     screen = awful.screen.preferred,
                     placement = awful.placement.centered +awful.placement.no_offscreen, --+ awful.placement.no_overlap
                     size_hints_honor = false
     }
    },

    -- Titlebars
    { rule_any = { type = { "dialog", "normal" } },
      properties = { titlebars_enabled = true } },
      -- properties = { titlebars_enabled = false} },
          -- Set applications to always map on the tag 2 on screen 1.
    --{ rule = { class = "Subl" },
        --properties = { screen = 1, tag = awful.util.tagnames[2], switchtotag = true  } },


    -- Set applications to always map on the tag 1 on screen 1.
    -- find class or role via xprop command
    --{ rule = { class = browser2 },
      --properties = { screen = 1, tag = awful.util.tagnames[1], switchtotag = true  } },

    --{ rule = { class = browser1 },
      --properties = { screen = 1, tag = awful.util.tagnames[1], switchtotag = true  } },

    --{ rule = { class = "Vivaldi-stable" },
        --properties = { screen = 1, tag = awful.util.tagnames[1], switchtotag = true } },

    --{ rule = { class = "Chromium" },
      --properties = { screen = 1, tag = awful.util.tagnames[1], switchtotag = true  } },

    --{ rule = { class = "Opera" },
      --properties = { screen = 1, tag = awful.util.tagnames[1],switchtotag = true  } },

    -- Set applications to always map on the tag 2 on screen 1.
    --{ rule = { class = "Subl" },
        --properties = { screen = 1, tag = awful.util.tagnames[2],switchtotag = true  } },

    --{ rule = { class = editorgui },
        --properties = { screen = 1, tag = awful.util.tagnames[2], switchtotag = true  } },

    --{ rule = { class = "Brackets" },
        --properties = { screen = 1, tag = awful.util.tagnames[2], switchtotag = true  } },

    --{ rule = { class = "Code" },
        --properties = { screen = 1, tag = awful.util.tagnames[2], switchtotag = true  } },

    --    { rule = { class = "Geany" },
         --  properties = { screen = 1, tag = awful.util.tagnames[2], switchtotag = true  } },


    -- Set applications to always map on the tag 3 on screen 1.
    --{ rule = { class = "Inkscape" },
        --properties = { screen = 1, tag = awful.util.tagnames[3], switchtotag = true  } },

    -- Set applications to always map on the tag 4 on screen 1.
    --{ rule = { class = "Gimp" },
        --properties = { screen = 1, tag = awful.util.tagnames[4], switchtotag = true  } },

    -- Set applications to always map on the tag 5 on screen 1.
    --{ rule = { class = "Meld" },
        --properties = { screen = 1, tag = awful.util.tagnames[5] , switchtotag = true  } },


    -- Set applications to be maximized at startup.
    -- find class or role via xprop command

    --{ rule = { class = editorgui },
    --      properties = { maximized = true } },

    { rule = { class = "Geany" },
          properties = { maximized = false, floating = false } },

    -- { rule = { class = "Thunar" },
    --     properties = { maximized = false, floating = false } },

    { rule = { class = "Gimp*", role = "gimp-image-window" },
          properties = { maximized = true } },

    { rule = { class = "Gnome-disks" },
          properties = { maximized = true } },

    { rule = { class = "inkscape" },
          properties = { maximized = true } },

    { rule = { class = mediaplayer },
          properties = { maximized = true } },

    { rule = { class = "Vlc" },
          properties = { maximized = true } },

    { rule = { class = "VirtualBox Manager" },
          properties = { maximized = true } },

    { rule = { class = "VirtualBox Machine" },
          properties = { maximized = true } },

    { rule = { class = "Vivaldi-stable" },
          properties = { maximized = false, floating = false } },

    -- { rule = { class = "Xfce4-terminal" },
    --       properties = { function (c) c.minimized = true end } },

    { rule = { class = "sxiv" },
          properties = { maximized = false, floating = false } },

    { rule = { class = "Vivaldi-stable" },
          properties = { callback = function (c) c.maximized = false end } },

    --IF using Vivaldi snapshot you must comment out the rules above for Vivaldi-stable as they conflict
--    { rule = { class = "Vivaldi-snapshot" },
--          properties = { maximized = false, floating = false } },

--    { rule = { class = "Vivaldi-snapshot" },
--          properties = { callback = function (c) c.maximized = false end } },

    { rule = { class = "Xfce4-settings-manager" },
          properties = { floating = false } },

    -- Floating clients.
    { rule_any = {
        instance = {
          "DTA",  -- Firefox addon DownThemAll.
          "copyq",  -- Includes session name in class.
        },
        class = {
          "gnome-screenshot",
          "Gnome-screenshot",
          "Arandr",
          "Arcolinux-welcome-app.py",
          "Blueberry",
          "Galculator",
          "Gnome-font-viewer",
          "Gpick",
          "Imagewriter",
          "Font-manager",
          "Kruler",
          "MessageWin",  -- kalarm.
          "archlinux-logout",
          "Peek",
          "Skype",
          "System-config-printer.py",
          "Unetbootin.elf",
          "Wpa_gui",
          "onboard",
          "pinentry",
          "veromix",
          "xtightvncviewer",
      },

        name = {
          "Screenshot",
          "Event Tester",  -- xev.,
          "HS Emden/Leer: Delta Robot",
          "OS Customisation",
        },
        role = {
          "AlarmWindow",  -- Thunderbird's calendar.
          "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
          "Preferences",
          "setup",
        }
      }, properties = { floating = true }},

          -- Floating clients but centered in screen
    { rule_any = {
       	class = {
       		"Polkit-gnome-authentication-agent-1",
			"Arcolinux-calamares-tool.py"
				},
				},
      	properties = { floating = true },
	      	callback = function (c)
    		  awful.placement.centered(c,nil)
       		end },
    { rule_any = {
       	class = {"onboard"},
				},
      	properties = { border_width = 0 }},

    { rule_any = {
        name = {"SBC-86 Simulation (Hardware)                  (c) D. Ertelt 2002-2008"}
       	-- class = {"simu86"},
				},
      	properties = { floating = true },
	      	callback = function (c)
    		  awful.placement.left(c,nil)
       		end },
    { rule_any = {
        name = {"SBC-86 Simulation (Debugger-Bildschirm)             (c) D. Ertelt 2002-2008"}
       	-- class = {"simu86"},
				},
      	properties = { floating = true },
	      	callback = function (c)
    		  awful.placement.right(c,nil)
       		end },
}
-- awful.rules.rules = rules
-- }}}

-- vim:foldmethod=marker
