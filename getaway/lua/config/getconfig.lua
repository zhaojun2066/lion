--
-- Created by IntelliJ IDEA.
-- User: zhaojun(JUFENG)
-- Date: 2018/11/26
-- Time: 19:08
-- To change this template use File | Settings | File Templates.
--

--- 定时读取配置信息,从config 配置接口
local _config = require("common.config")
local _json = require("common.json")
local ngx = ngx
local config_path = _config.config_path
local decode = _json.decode
local config_cache = ngx.shared.lion_cache_config
local http = require "resty.http"
local httpc = http.new()

local _M = {}
local mt = {
    __index = _M
}

function _M.new()
    local self= {
        key = "lion_config"
    }
   return  setmetatable(self,mt)
end

function _M.get_current_server_config(self,mgroup)
    local cf = config_cache:get(self.key)
    if not cf then
        return nil
    end
    ---获取该分组下的所有的server
    return cf[mgroup]
end



function _M.init(self)
    local res, err = httpc:request_uri(config_path, {
        method = "POST",
        --- body = "a=1&b=2", -- 可以传递group参数，来区分
        keepalive_timeout = 60,
        keepalive_pool = 10
    })

    if not res then
        ngx.say("failed to request: ", err)
        return
    end
    local body = res.body --- 解析返回的json
    if not body then
        ngx.say("failed to request: ", err)
        return
    end
    local config_obj = decode(body) --- 转换为lua 对象
    config_cache:set(self.key,config_obj) --- 设置到共享内存内
end







