--
-- Created by IntelliJ IDEA.
-- User: zhaojun(JUFENG)
-- Date: 2018/11/26
-- Time: 19:48
-- To change this template use File | Settings | File Templates.
--
local _getconig = require("config.getconfig")
local ngx = ngx
local log = ngx.log
local ERR = ngx.ERR
local delay = 5*60 -- in seconds
local get = _getconig.new()
local init_config = get.init

--- 获取配置
local get_config_hanler = function()
    print("init lion config start...")
    init_config()
    print("init lion config end...")
end

local handler

handler = function(premature)
    if premature then
        return
    end
    get_config_hanler()
end

if 0 == ngx.worker.id() then
    local ok, err = ngx.timer.every(delay, handler)
    if not ok then
        log(ERR, "failed to create timer: ", err)
        return
    end
end
