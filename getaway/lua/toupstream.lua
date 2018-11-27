--
-- Created by IntelliJ IDEA.
-- User: zhaojun(JUFENG)
-- Date: 2018/11/27
-- Time: 11:12
-- To change this template use File | Settings | File Templates.
-- 转发upstream
local ngx_balancer = require("ngx.balancer")
local ngx = ngx
local abs = math.abs
local _M = {}
local mt = {
    __index = _M
}
local balancer_cache = ngx.shared.balancer_cache  --- 计数，当前循环到哪个server了
function  _M.new()
    local self = {
        up_stream_config= ngx.ctx.up_stream_config,
        key = "up_balence_"
    }
    return setmetatable(self,mt)
end


function _M.balancer(self)
    local up_stream_config = self.up_stream_config
    local up_config = up_stream_config.up_config
    local up_server = up_stream_config.up_server
    local ups = up_config.ups
    local server_size = #ups
    local pre = balancer_cache:incr(self.key..up_server,1,1)
    local index = abs(pre) % server_size
    local server = ups[index+1]
    local ip = server.ip
    local port = server.port
    ngx_balancer.set_current_peer(ip,port)
end
return _M

