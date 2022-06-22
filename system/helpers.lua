-- Display log messages with optional parsing of the message
--
-- The function allows parsing log messages and replace placeholders in the
-- final string. Placeholders are prefixed by a `+` and followed by uppercase
-- or lowercase letters from A to Z.
--
-- The placement table can be omitted if there are no placeholders to replace
-- and it is is structured like so:
--
--   {
--     ['+placeholderA'] = 'replacement value A',
--     ['+placeholderB'] = 'replacement value B',
--     ['+more'] = '... or even more'
--   }
--
-- The level parameter allows to set a log level based on Minetest’s default
-- log levels. When omitted `action` is used.
--
-- If you want to use a log level and do not want to replace anything just use
-- the level value as second parameter, the function automatically detects it
-- and behaves properly.
--
-- @param message      Log message to show with optional placeholders
-- @param replacements Optional replacement table as described
-- @param level        Optional log level as described
-- @return void
-- @see minetest.log
xcoal.log = function (message, replacements, level)
    if level == nil then level = 'action' end
    if replacements == nil then replacements = {} end
    if type(replacements) == 'string' then level = replacements end
    if type(replacements) ~= 'table' then replacements = {} end

    local prefix = '[xcoal] '
    local parsed_message = message:gsub('%+%a+', replacements)

    minetest.log(level, prefix..parsed_message)
end


-- Process template recipe
--
-- This function replaces all occurrences of `x` in the template recipe with
-- the actual node ID provided via the `replacement` parameter.
--
-- @param base_table  The table to replace the values in
-- @param replacement The value that is used for replacing the `x` with
-- @return table The processed table
xcoal.recipe_replace = function(base_table, replacement)
    local target = {}

    for row,_ in pairs(base_table) do
        target[row] = {}
        for col,_ in pairs(base_table[row]) do
            target[row][col] = base_table[row][col]:gsub('x', replacement)
        end
    end

    return target
end
