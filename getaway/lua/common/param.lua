--
-- Created by IntelliJ IDEA.
-- User: zhaojun(JUFENG)
-- Date: 2018/9/14
-- Time: 12:49
-- 获取参数
--

local _M={}
---获得get post参数values
function _M.get_args()
    local args = {}
    local request_method = ngx.var.request_method
    if "GET" == request_method then
        args = ngx.req.get_uri_args()
    elseif "POST" == request_method then
        ngx.req.read_body()  --log_by_lua 阶段不能使用
        args = ngx.req.get_post_args()
    end
    return args
end
return _M
