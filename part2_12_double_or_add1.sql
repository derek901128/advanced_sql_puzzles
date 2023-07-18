select 
    level,
    case when level < 100 then level * 2 else level + 1 end outcome 
from 
    dual
connect by 
    level <= 200
;