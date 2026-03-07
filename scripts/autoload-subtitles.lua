local mp = require("mp")
local utils = require("mp.utils")

-- Allowed subtitle extensions
local exts = {
  srt = true,
  ass = true,
  ssa = true,
  vtt = true,
  sub = true,
}

-- Check if file extension is a subtitle
local function is_sub(file)
  local ext = file:match("%.([^%.]+)$")
  return ext and exts[ext:lower()]
end

mp.register_event("file-loaded", function()
  local path = mp.get_property("path")
  if not path then
    return
  end

  -- Get directory and filename
  local dir, filename = utils.split_path(path)

  -- Remove video extension
  local base = filename:match("^(.*)%.")

  -- Build subs directory
  local subs_dir = utils.join_path(dir, "subs")

  local files = utils.readdir(subs_dir, "files")
  if not files then
    return
  end

  for _, file in ipairs(files) do
    if is_sub(file) then
      -- remove subtitle extension
      local name = file:match("^(.*)%.")

      -- match "VideoName.<anything>"
      if name and name:sub(1, #base) == base then
        local full = utils.join_path(subs_dir, file)
        mp.commandv("sub-add", full)
      end
    end
  end
end)
