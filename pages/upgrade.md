# 软件升级管理

## 全量升级

- 通过 sftp 上传覆盖


通过这种方式升级，可以直接上传本地升级版本文件，注意升级前备份原目录和数据库


- 通过预置升级脚本升级

在服务器网络条件较好的情况下，可通过程序预置的升级脚本升级(自动备份原目录到/home/toughsms)：

    cd /opt/toughsms
    bin/upgrade latest


## 管理界面在线升级

除了手工实现全量升级，系统也提供了升级界面快速升级

进入系统管理-升级管理界面

![](http://static.toughcloud.net/toughsms/tc_20180606123326_1.png)

在这个界面中提供了按模块单独升级的模式，系统的不同模块，并不总是同步发布，因此升级也是可以分开的。


- 最新RPCD模块发布包 toughsms-rpcd-latest.jar

该模块主要提供核心的认证计费逻辑处理服务，作为独立的模块部署和发布，该模块包只有一个，保持最新的版本状态。

- RPCD模块的迭代版本 toughsms-rpcd-build_xxxxxxx.jar

不同于 toughsms-rpcd-latest.jar， 这个发布包是迭代更替的，每个发布包表示某个阶段的特定版本。最新的包和 toughsms-rpcd-latest.jar 是一致的。

- 最新主程序升级发布 toughsms-latest-patch-linux-x64.tar.bz2

主应用程序升级（补丁）发布包，不包含 RPCD 模块以及系统依赖，可以支持主程序的快速升级

- 主程序升级迭代版本 toughsms-patch_xxxxxxx-patch-linux-x64.tar.bz2

每个发布包表示某个阶段的特定版本。最新的包和 toughsms-latest-patch-linux-x64.tar.bz2 是一致的。