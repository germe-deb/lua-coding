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
    -- local box0 = Gtk.Box.new(Gtk.Orientation.VERTICAL, 0)
    local leaflet = Adw.Leaflet.new()
    local box1 = Gtk.Box.new(Gtk.Orientation.VERTICAL, 0)
    local box2 = Gtk.Box.new(Gtk.Orientation.VERTICAL, 0)
    local headerbar = Adw.HeaderBar.new()
    local headerbar2 = Adw.HeaderBar.new()

    window.content = leaflet
    leaflet:append(box1)
    leaflet:append(box2)
    box1:append(headerbar)
    box2:append(headerbar2)

    headerbar2.hexpand = true

    window.title = appTitle
    window:set_default_size(400, 400)
end

function app:on_activate()
    self.active_window:present()
end

return app:run(arg)