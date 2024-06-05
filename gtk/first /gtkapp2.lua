local lgi = require("lgi")
local Gtk = lgi.require("Gtk", "4.0")
local Gio = lgi.Gio
local Adw = lgi.require("Adw", "1")

--[[
    Una app xd

    by: dpkgluci
]]

-- local variables de la app gtk en sí
local appID = "io.github.dpkgluci.test_test_test"
local appTitle = "test test test"
local app =  Adw.Application.new(appID, Gio.ApplicationFlags.FLAGS_NONE)

function app:on_startup()
    local window = Adw.ApplicationWindow.new(self)
    local box1 = Gtk.Box.new(Gtk.Orientation.VERTICAL, 0)
    local headerbar = Adw.HeaderBar.new()
    local adwstyle = Adw.StyleManager()

    window.content = box1
    box1:append(headerbar)

    headerbar.hexpand = true

    window:set_default_size(600, 500)
    window.title = appTitle
    window.height_request = 250
    window.width_request = 250

    adwstyle:set_color_scheme(2)
end

function app:on_activate()
    self.active_window:present()
end

return app:run(arg)