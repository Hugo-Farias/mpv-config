local mp = require("mp")

mp.register_event("file-loaded", function()
  local name = mp.get_property("media-title")
  mp.osd_message(name, 3)
end)
