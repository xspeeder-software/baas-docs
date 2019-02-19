## 7.1. 神行者BRAS对接指南

本文目的主要是针对神行者路由客户提供 PPPOE 认证对接计费的指导。

### 准备工作

- 确认神行者 BRAS 设备运行正常，内网通信正常。

![](http://static.toughcloud.net/toughsms/ldj_2018-12-26_095004.png)

> 查看接口状态，确认接口通信正常

- 确认神行者 BRAS 访问外网正常，与云计费认证地址通信正常 

![](http://static.toughcloud.net/toughsms/ldj_2018-12-26_095250.png)


### BRAS 配置

- 配置 PPPOE 用户使用的地址池

![](http://static.toughcloud.net/toughsms/ldj_2018-12-26_095635.png)

- 配置 PPPOE 认证服务

> 进入 PPPOE 配置界面

![](http://static.toughcloud.net/toughsms/ldj_2018-12-26_095428.png)

![](http://static.toughcloud.net/toughsms/ldj_2018-12-26_095842.png)

#### 重要属性说明

![](http://static.toughcloud.net/toughsms/ldj_2018-12-26_104426.png)

> 如图，RADIUS IP和端口请登录云计费系统获取。

- RADIUS服务器IP：
- 认证端口：
- RADIUS计费IP：默认与认证IP相同。
- 计费端口：
- RADIUS厂商协议：神行者路由可兼容当前主流协议，推荐使用 mikrotik
- COA端口：当前设备监听的服务端口，可支持 RADIUS 强制下线消息， 默认为3799.
- RADIUS密钥：和 RADIUS 进行通信加密的共享密钥。 
- 计费间隔：用户记账消息间隔时间，如果 RADIUS 没有下发，则当前服务会使用该参数。


### 云计费配置

- 在神行者云计费系统中配置 BRAS 信息

> 进入 ”资源管理——BRAS设备“ 界面

![](http://static.toughcloud.net/toughsms/ldj_2018-12-26_101817.png)

> 添加 BRAS 设备信息

![](http://static.toughcloud.net/toughsms/ldj_2018-12-26_102020.png)

> 设备厂商（协议），标识，COA端口，共享密钥配置和 BRAS PPPOE服务一致，如果 BRAS 设备部署在本地内网，没有固定公网IP，则将IP设置为 0.0.0.0 即可。


### 准备认证用户数据

- 配置区域小区

请参考 [区域&小区配置](../opt/area.md)

- 配置服务资费

请参考 [服务&资费配置](../opt/service.md)

- 新增认证用户

请参考 [客户业务受理](../opt/subscribe.md)

### PPPOE 拨号测试

将测试终端（PC）连接到 BRAS 的PPPOE 接口，配置客户端拨号信息。

![](http://static.toughcloud.net/toughsms/ldj_2018-12-26_103034.png)


- 检查 BRAS 设备中用户是否在线

![](http://static.toughcloud.net/toughsms/ldj_2018-12-26_103503.png)

- 检查云计费系统中用户是否在线

![](http://static.toughcloud.net/toughsms/ldj_2018-12-26_103219.png)


#### 用户拨号故障检测

如果用户拨号失败，请检查 BRAS 设备和云计费系统的相关日志进行定位

![](http://static.toughcloud.net/toughsms/ldj_2018-12-26_103902.png)

- BRAS 认证异常日志

![](http://static.toughcloud.net/toughsms/ldj_2018-12-26_103949.png)

- 云计费  认证日志

![](http://static.toughcloud.net/toughsms/ldj_2018-12-26_104226.png)


> 如果在定位故障过程中碰到自己无法解决的问题，请联系我们的技术支持。



