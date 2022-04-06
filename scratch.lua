local lfs = require"lfs"
local config_dir = vim.fn.stdpath("config")

function showFolder(folder)
  print('=====================  ' .. folder)
  local path = system.pathForFile( folder, system.ResourceDirectory )
  for file in lfs.dir ( path ) do
    print (file)
  end
end

showFolder(config_dir)
-- for each file add a mapping that is the first letter of the file
  -- if more than one being with the same letter, nest
-- for each directory, add a nest
-- loop
