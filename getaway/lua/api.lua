--
-- Created by IntelliJ IDEA.
-- User: zhaojun(JUFENG)
-- Date: 2018/11/27
-- Time: 14:02
-- To change this template use File | Settings | File Templates.
--

local selector = require("selector")
local ngx = ngx
local log = ngx.log
local ERR = ngx.ERR
local pcall = pcall

local function forward_up_server()
    local select = selector.new()
    select:forward()
end

local status ,errors = pcall(forward_up_server)
if not status then
    log(ERR,"error," ,errors)
    return ngx.exits(500) ---
end


