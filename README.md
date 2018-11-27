### Lion
-------------------
openresty 网关

### 功能
   统一网关
   限流

### 配置格式
       {
           "user_server": {
               "ups": [
                   {
                       "host": "loacalhost",
                       "port": 8080
                   },
                   {
                       "host": "loacalhost",
                       "port": 8080
                   }
               ],
               "userservice": {
                   "interfaces": {
                       "user_server.userservice.getUser.1": {
                           "uri": "/user/getUser"
                       },
                       "user_server.userservice.delUser.1": {
                           "uri": "/user/delUser"
                       }
                   }
               },
               "memberservice": {
                   "interfaces": {
                       "user_server.memberservice.getUser.1": {
                           "uri": "/mgroup/member/getMember"
                       }
                   }
               }
           },
           "order_server": {
               "ups": [
                   {
                       "host": "loacalhost",
                       "port": 8080
                   },
                   {
                       "host": "loacalhost",
                       "port": 8080
                   }
               ],
               "orderservice": {
                   "interfaces": {
                       "order_server.orderservice.findOrderList.1": {
                           "uri": "/order/findOrderList"
                       }
                   }
               }
           }
       }