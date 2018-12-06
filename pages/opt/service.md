# 服务与资费

## 服务管理

在新建商品资费之前必须配置服务，根据运营需求创建需要的服务，并配置服务的关键属性

![](http://static.toughcloud.net/toughsms/tc_20181206145956_6.png)

创建服务

![](http://static.toughcloud.net/toughsms/tc_20181206150036_7.png)

配置服务

![](http://static.toughcloud.net/toughsms/tc_20181206150119_8.png)


服务属性

- 在线数限制，用户在线达到数值后拒绝后续认证1
- 上行速率(Mbps)
- 下行速率(Mbps)
- 上行突发速率(Mbps)
- 下行突发速率(Mbps)
- 上行速率策略名，适用于思科，爱立信
- 下行速率策略名，适用于思科，爱立信
- 地址池
- 过期地址池
- 认证域, 适用于华为，思科，爱立信，中兴设备
- 扩展策略（定制属性）
- 自然月流量清零
- 启用代理拨号
- 代理拨号用户（神行者BRAS专有）
- 代理用户密码（神行者BRAS专有）
- 代理用户VLAN（神行者BRAS专有）
- 是否绑定MAC
- 是否绑定VLAN
- 过期免授权, 控制用户到期后是否继续通过认证。
- 免授权上行速率(Mbps)
- 免授权下行速率(Mbps)

> 注意配置服务属性只需要配置设备支持和自己需要的即可，并不需要全部配置

## 资费管理

资费是基于服务定价的可销售的商品，一个服务可以定义多个资费。

![](http://static.toughcloud.net/toughsms/tc_20181206150811_11.png)

创建资费

![](http://static.toughcloud.net/toughsms/tc_20181206150742_10.png)

修改资费

![](http://static.toughcloud.net/toughsms/tc_20181206150859_12.png)

资费属性快速预览

![](http://static.toughcloud.net/toughsms/tc_20181206151008_13.png)

资费在未使用前可以删除，一旦被用户订购使用就不允许再删除。