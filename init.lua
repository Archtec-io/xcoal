-- Create local variables
local modname = minetest.get_current_modname()
local modpath = minetest.get_modpath(modname)
local syspath = modpath..DIR_DELIM..'system'
local regpath = modpath..DIR_DELIM..'registry'
local get_dir_list = minetest.get_dir_list


-- Create global table for data an d function interchange
xcoal = {
    translator = minetest.get_translator(modname)
}


-- Loading all mod files
--
-- Helpers are loaded individually because they’re used in some of the other
-- mod files.
dofile(syspath..DIR_DELIM..'helpers.lua')
for _,mod_file in pairs(get_dir_list(syspath, false)) do
    if mod_file ~= 'helpers.lua' then
        xcoal.log('Loading mod file +f', { ['+f'] = mod_file }, 'verbose')
        dofile(syspath..DIR_DELIM..mod_file)
    end
end

-- Load coal variants from the registry
for _,reg_file in pairs(get_dir_list(regpath, false)) do
    xcoal.log('Loading registry file +f', { ['+f'] = reg_file }, 'verbose')
    dofile(regpath..DIR_DELIM..reg_file)
end


-- Unset global table
xcoal.log('Mod loaded')
xcoal = nil
