--
-- Created by IntelliJ IDEA.
-- User: zhaojun(JUFENG)
-- Date: 2018/9/14
-- Time: 12:55
-- Json decode encode 操作
--
local _cjson_safe = require("cjson.safe")                       --- json操作
local json_decode = _cjson_safe.decode                          --- function json decode
local json_encode = _cjson_safe.encode                          --- function json encode
local _M={}

function _M.decode(data)
    return json_decode(data)
end

function _M.encode(data)
    return json_encode(data)
end

return _M
