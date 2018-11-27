--
-- Created by IntelliJ IDEA.
-- User: zhaojun(JUFENG)
-- Date: 2018/11/26
-- Time: 20:00
-- To change this template use File | Settings | File Templates.
-- 统一接受api 参数,路由到不通的上游服务器 tomcat ，或者其他web服务器

local _config = require("common.config")
local _parmas = require("common.param")
local _uitls = require("common.uitls")

local get_args = _parmas.get_args
local split = _uitls.split
local table_is_nil = _uitls.table_is_nil
local ngx = ngx
local log = ngx.log
local ERR = ngx.ERR

local _M = {}
local mt = {
    __index = _M
}

---获取当前server config
local function get_current_server()
    local parmas = get_args()
    local method = parmas["method"] -- mgrup.user.getUser
    local version = parmas["version"]
    --- 解析分组和server
    local arrays = split(method,".")
    if table_is_nil(arrays) then
        log(ERR, "params method is err "..method.."\n")
        error("forward error...")
    end
    local up_server = arrays[0]
    if not up_server then
        log(ERR, "params method is err "..method.."\n")
        error("forward error...")
    end

    local get_config = _config.new()
    local current_server_config = get_config:get(up_server)
    if not current_server_config then
        log(ERR, "params method is err "..method.."\n")
        error("forward error...")
    end
    local key = method.."."..version
    local uri = current_server_config.interfaces[key]
    if not uri then
        log(ERR, "params method is err "..method.."\n")
        error("forward error...")
    end
    local current_config = {
        up_server = up_server,
        up_config = current_server_config
    }
    return current_config , uri
end
function _M.new()
    local current_config ,uri = get_current_server()
    local url_args = ngx.req.get_uri_args()
    local self = {
        up_stream_config = current_config,
        uri = uri,
        method =  ngx.var.request_method,
        url_args = url_args
    }
    return setmetatable(self,mt)
end


--- 内部请求到/
function _M.forward(self)
    --- 共享up_stream_config
    ngx.ctx.up_stream_config = self.up_stream_config
    local res = ngx.location.capture(self.uri,{
        method =  self.method,
        agrs = self.url_args,
        ctx = ngx.ctx,
        always_forward_body = true
    })
    if res.status == 200 then
        ngx.header = res.header
        ngx.print(res.body)
    else
        error("forward error...")
    end

end













