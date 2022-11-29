local S = xcoal.translator


-- Textures
local block_base = '((+c^[cracko:1:4^(+c^[opacity:128))^[transform3)'
local block_texture = block_base:gsub('%+c', 'default_coal_block.png')
local compressed_block_texture = '('..block_texture..'^[colorize:#000000:90)'


xcoal.register('charcoal', {
    name = S('Charcoal'),
    inventory_image = 'default_coal_lump.png^[transform3',
    burntime = 60,
    cooking = {
        source = 'group:tree',
        cooktime = 4,
        output = 4
    },
    additional_recipes = {
        ['default:torch 4'] = {
            {'x'},
            {'group:stick'}
        }
    }
})


xcoal.register('charcoal_block', {
    name = S('Charcoal Block'),
    tiles = { block_texture },
    burntime = 9*60,
    groups = { cracky = 3 },
    sounds = default.node_sound_stone_defaults(),
    crafting = {
        recipe = {
            { 'xcoal:charcoal', 'xcoal:charcoal', 'xcoal:charcoal' },
            { 'xcoal:charcoal', 'xcoal:charcoal', 'xcoal:charcoal' },
            { 'xcoal:charcoal', 'xcoal:charcoal', 'xcoal:charcoal' }
        },
        output = 1,
    },
    additional_recipes = {
        ['xcoal:charcoal 9'] = {
            {'x'}
        }
    }
})


xcoal.register('compressed_charcoal_block', {
    name = S('Compressed Charcoal Block'),
    tiles = { compressed_block_texture },
    burntime = (9*60)*9,
    groups = { cracky = 3 },
    sounds = default.node_sound_stone_defaults(),
    crafting = {
        recipe = {
            {
                'xcoal:charcoal_block',
                'xcoal:charcoal_block',
                'xcoal:charcoal_block'
            },
            {
                'xcoal:charcoal_block',
                'xcoal:charcoal_block',
                'xcoal:charcoal_block'
            },
            {
                'xcoal:charcoal_block',
                'xcoal:charcoal_block',
                'xcoal:charcoal_block'
            }
        },
        output = 1,
    },
    additional_recipes = {
        ['xcoal:charcoal_block 9'] = {
            {'x'}
        }
    }
})

