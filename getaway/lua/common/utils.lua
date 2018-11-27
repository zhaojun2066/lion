--
-- Created by IntelliJ IDEA.
-- User: zhaojun(JUFENG)
-- Date: 2018/11/26
-- Time: 20:12
-- To change this template use File | Settings | File Templates.
--

local _M = {}
function _M.split( str,reps )
    local resultStrList = {}
    string.gsub(str,'[^'..reps..']+',function ( w )
        table.insert(resultStrList,w)
    end)
    return resultStrList
end

function _M.table_is_nil(tb)
    if tb ~= nil and next(tb) ~= nil then
        return false
    end
    return true
end

return _M

