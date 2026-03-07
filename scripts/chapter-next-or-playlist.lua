local mp = require("mp")

local function next_chapter_or_playlist()
  local chapter = mp.get_property_number("chapter", -1)
  local chapters = mp.get_property_number("chapters", 0)
  local pos = mp.get_property_number("playlist-pos", 0)
  local count = mp.get_property_number("playlist-count", 1)

  -- if next chapter exists
  if chapter ~= -1 and chapter < chapters - 1 then
    mp.commandv("add", "chapter", 1)
    return
  end

  -- otherwise try next playlist item
  if pos >= count - 1 then
    mp.osd_message("Last file in playlist")
  else
    mp.commandv("playlist-next")
  end
end

local function prev_chapter_or_playlist()
  local chapter = mp.get_property_number("chapter", -1)
  local pos = mp.get_property_number("playlist-pos", 0)

  -- if previous chapter exists
  if chapter > 0 then
    mp.commandv("add", "chapter", -1)
    return
  end

  -- otherwise try previous playlist item
  if pos <= 0 then
    mp.osd_message("First file in playlist")
  else
    mp.commandv("playlist-prev")
  end
end

mp.add_key_binding(nil, "chapter-next-or-playlist", next_chapter_or_playlist)
mp.add_key_binding(nil, "chapter-prev-or-playlist", prev_chapter_or_playlist)
