
## 7.2 神行者portal对接指南（公网对接）
    
本文目的主要是针对神行者路由客户提供 portal 认证对接计费的指导.

神行者路由客户提供了无线控制器功能，继承Portal 协议支持，与神行者云平台的Portal认证平台实现完整对接。

### 路由配置

#### 网络设置

- 新增内网线路(网络设置->内网管理->新增)

![](http://static.toughcloud.net/toughsms/ldj_2019-01-31_162402.png)

- 新增外网线路(网络设置->外网管理->新增)

![](http://static.toughcloud.net/toughsms/tc_20190219093904_1.png)

- 确认内,外网通信正常(网络设置->接口管理)

![](http://static.toughcloud.net/toughsms/ldj_2019-01-31_162801.png)

#### DHCP设置
- 建立DHCP服务( DHCP 设置-> DHCP 服务->新增)

![](http://static.toughcloud.net/toughsms/ldj_2019-01-31_163126.png)

#### 认证设置
- web 服务(认证设置- web 服务->新增))

![](http://static.toughcloud.net/toughsms/ldj_2019-01-31_165219.png)

![](http://static.toughcloud.net/toughsms/ldj_2019-01-31_165550.png)

#### AC配置
- 配置管理(AC智能控制->配置管理)

![](http://static.toughcloud.net/toughsms/ldj_2019-01-31_165856.png)


### 云计费配置
####  AC控制器

- 在神行者云计费系统中配置AC控制器(无线运营->AC控制器)

> 添加AC控制器, IP 为路由配置好的内网 IP

![](http://static.toughcloud.net/toughsms/ldj_2019-01-31_170016.png)


> 设备厂商（协议），标识，COA端口，共享密钥配置和 PPPOE服务一致，AC端口在路由的系统管理->系统参数->虚拟网卡允许端口添加2000端口

- 认证域(无线运营->认证域)

**添加域**

![](http://static.toughcloud.net/toughsms/ldj_2019-01-31_170306.png)

**配置portal页面的相关属性**

![](http://static.toughcloud.net/toughsms/ldj_2019-01-31_170404.png)

**点击预览,弹出配置好的porta页面**

![](http://static.toughcloud.net/toughsms/ldj_2019-01-31_141501.png)


#### 四种认证方式
- 账号密码认证
![](http://static.toughcloud.net/toughsms/ldj_2019-02-19_163943.png)
![](http://static.toughcloud.net/toughsms/ldj_2019-02-19_164837.png)

- 固定密码认证
![](http://static.toughcloud.net/toughsms/ldj_2019-02-19_165010.png)
![](http://static.toughcloud.net/toughsms/ldj_2019-02-19_165130.png)

 - 短信认证
 ![](http://static.toughcloud.net/toughsms/ldj_2019-02-19_165246.png)
 ![](http://static.toughcloud.net/toughsms/ldj_2019-02-19_165403.png)

- 微信认证 
![](http://static.toughcloud.net/toughsms/ldj_2019-02-19_165442.png)
![](http://static.toughcloud.net/toughsms/ldj_2019-02-19_165802.png)


#### 在线信息
> 认证成功portal页面

![](http://static.toughcloud.net/toughsms/ldj_2019-01-31_144710.png)

>路由在线信息

![](http://static.toughcloud.net/toughsms/ldj_2019-01-31_170544.png)

>云计费在线信息

![](http://static.toughcloud.net/toughsms/ldj_2019-02-20_143455.png)

#### 常见问题
- 1 不弹出portal页面
>  解决方案
->  请手动点击浏览器，点击http页面辅助弹出认证页面
-> web认证设置 PORTAL_URL跳转地址是否正确
-> 检查外网通信正常,是否能ping通内网地址,mac地址是否正确

- 2 认证失败
>  解决方案
->  查看日志记录,检查路由与云计费的通信正常,重要参数是否正确
->  微信认证用户临时放行一分钟,不跳转去微信认证,会自动下线




> 如果在定位故障过程中碰到自己无法解决的问题，请联系我们的技术支持。






    



