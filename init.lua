-- safe_tnt/init.lua
-- Apply height restrictions to TNTs
--[[
    The MIT License (MIT)
    Copyright (C) 2014-2016 PilzAdam
    Copyright (C) 2014-2016 ShadowNinja
    Copyright (C) 2016 sofar (sofar@foo-projects.org)
    Copyright (C) 2014-2016 Various Minetest developers and contributors
    Copyright (C) 2024 1F616EMO

    Permission is hereby granted, free of charge, to any person obtaining a copy of this
    software and associated documentation files (the "Software"), to deal in the Software
    without restriction, including without limitation the rights to use, copy, modify, merge,
    publish, distribute, sublicense, and/or sell copies of the Software, and to permit
    persons to whom the Software is furnished to do so, subject to the following conditions:

    The above copyright notice and this permission notice shall be included in all copies or
    substantial portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
    INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR
    PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE
    FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
    OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
    DEALINGS IN THE SOFTWARE.
]]

local tnt_mindepth = tonumber(minetest.settings:get("tnt.mindpeth")) or -100
local logger = logging.logger("safe_tnt")

local old_on_construct = minetest.registered_nodes["tnt:tnt_burning"].on_construct
minetest.override_item("tnt:tnt_burning", {
    on_construct = function(pos)
        if pos.y > tnt_mindepth then
            logger:action("Attempted to ignite TNT at " .. minetest.pos_to_string(pos) ..
                " but failed due to height limit.")
            minetest.swap_node(pos, { name = "tnt:tnt" })
            return
        end

        return old_on_construct(pos)
    end,
})
