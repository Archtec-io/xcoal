-- Register a coal variant
--
-- This function registers a coal variant defined by the definition table as
-- described here.
--
-- definition = {
--     name = 'My Cool coal',
--     inventory_image = 'mymod_mycoal.png',
--     burntime = 60,
--     cooking = {
--         source = 'group:tree',
--         cooktime = 4,
--         output = 4
--     }
--     additional_recipes = {}
-- }
--
-- This table above registers a craft item with a cooking recipe. If you need
-- to register a node, replace `inventory_image` with `tiles` and instead of
-- a string have a Minetest API tiles definition there. This automatically
-- created a node instead of a craftitem.
--
-- `burntime` can be omitted. If omitted the registered coal variant cannot be
-- used as fuel for the furnace.
--
-- When registering a node, two additional table entries can be used to set
-- the `groups` and `sounds` (setting = table entry name) for the node. If
-- `groups` is unset, `oddly_breakable_by_hand = 1` will be used as only
-- group. If `sounds` is unset, `default.node_sound_stone_defaults()` is used
-- to set the sounds of the node.
--
-- If you want to register a crafting recipe instead of a cooking recipe simply
-- replace the table entry `cooking` with `crafting`.
--
-- crafting = {
--     recipe = {},
--     output = 1
-- }
--
-- `recipe` is a Minetest API shaped crafting recipe and `output` is the amount
-- of returned nodes per crafting process.
--
-- The `additional_recipes` table allows for adding additional recipes where
-- the coal variant is used. If not needed, it can be omitted.
--
-- additional_recipes = {
--     ['mymod:my_node 1'] = {},
--     ['mymod:my_other_node 4'] = {}
-- }
--
-- The table entry name is the node ID followed by the output amount and the
-- value is a Minetest API shaped crafting recipe. If using an `x` in any of
-- the recipes’ fields then the field will be set to the coal variant currently
-- being registered.
--
-- @param id The ID base part for the coal variant
-- @param definition The definition table as described
xcoal.register = function (id, definition)
    local coal_id = 'xcoal:'..id

    -- Register a craft item or a node
    if definition.inventory_image then
        minetest.register_craftitem(coal_id, {
            description = definition.name,
            inventory_image = definition.inventory_image
        })
    elseif definition.tiles then
        minetest.register_node(coal_id, {
            description = definition.name,
            tiles = definition.tiles,
            groups = definition.groups or { oddly_breakable_by_hand = 1 },
            sounds = definition.sounds or default.node_sound_stone_defaults()
        })
    end

    -- Register a cooking recipe or a crafting recipe
    if definition.cooking then
        minetest.register_craft({
            type = 'cooking',
            recipe = definition.cooking.source,
            output = coal_id..' '..definition.cooking.output,
            cooktime = definition.cooking.cooktime
        })
    elseif definition.crafting then
        minetest.register_craft({
            output = coal_id..' '..definition.crafting.output,
            recipe = definition.crafting.recipe
        })
    end

    -- Register coal item as fuel (`burntime` is present)
    if definition.burntime then
        minetest.register_craft({
            type = 'fuel',
            recipe = coal_id,
            burntime = definition.burntime
        })
    end

    -- Register additional recipes (`additional_recipes` is present)
    if definition.additional_recipes then
        for result, raw_recipe in pairs(definition.additional_recipes) do
            minetest.register_craft({
                output = result,
                recipe = xcoal.recipe_replace(raw_recipe, coal_id)
            })
        end
    end
end
