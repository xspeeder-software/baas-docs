# 系统安装配置

## 操作系统环境

建议 CentOS 7

## 数据库环境

建议 mariadb

安装软件模块列表

- mariadb-server

## 依赖模块列表

- bzip2  # 版本文件解压缩
- python-devel # 编译python扩展
- python-virtualenv # python运行虚拟环境支持模块
- gcc # 编译扩展模块
- mariadb-devel # 编译python数据库驱动模块
- openssl # 加密模块依赖
- czmq # 消息通信模块
- czmq-devel # 消息通信模块扩展编译
- openjdk8 # RADIUS java核心组件运行支持

安装指令：

    yum install -y mariadb-server mariadb mariadb-libs bzip2 python-devel python-virtualenv gcc mariadb-devel openssl java czmq czmq-devel

## 获取最新的安装文件 

最新版本文件下载地址 http://toughsms.upgrade.toughcloud.net/toughsms-latest-linux-x64.tar.bz2 

解压至 /opt 目录

    curl http://toughsms.upgrade.toughcloud.net/toughsms-latest-linux-x64.tar.bz2 -o /opt/toughsms-linux-x64.tar.bz2
    cd /opt
    tar xvf toughsms-linux-x64.tar.bz2

进入解压后的程序目录

    cd /opt/toughsms

执行 python 虚拟运行环境创建指令,

    make venv

> 注意：如果创建过程中如果出现编译错误，请检查编译依赖环境是否缺少模块。重新创建可以执行指令

    make clean && make venv

python虚拟运行环境创建成功后，会有一个专有目录，/opt/toughsms/venv , 这是一个相对独立的 python运行环境，包含了本系统运行所依赖的的所有python模块，这些python模块有些是经过gcc编译的二进制模块，将此目录复制到同样的操作系统环境，可以免去再次编译过程。

python 依赖模块列表，请参见 /opt/toughsms/requirements.txt 文件，这些文件已经下载到 /opt/toughsms/deps目录，执行指令时会自动从目录查找，如果不存在则会从网上下载。

如果后续版本有新的python模块加入，不需要重新创建 venv 环境，只需把模块加入/opt/toughsms/requirements.txt， 再执行指令：

    make uplib

或者

    venv/bin/pip install -U -f deps -r requirements.txt

> 注意：以上指令都必须在 /opt/toughsms 目录下运行


## 执行安装

    cd /opt/toughsms 
    
    make install

该指令执行了如下过程：

	groupadd toughsms
	useradd toughsms -g toughsms -M -d /home/toughsms -s /bin/false
	mkdir -p /home/toughsms/data
	mkdir -p /home/toughsms/upfile
	mkdir -p /home/toughsms/backup
	mkdir -p /home/toughsms/logs
	install etc/toughsmsd.conf /etc/toughsmsd.conf
	install -m 600 etc/toughsms.env /etc/sysconfig/toughsms
	install -m 600 etc/toughsms.service /usr/lib/systemd/system/toughsms.service
	chown -R toughsms.toughsms /opt/toughsms
	chown -R toughsms.toughsms /var/toughsms
	chown -R toughsms.toughsms /home/toughsms
	systemctl enable toughsms && systemctl daemon-reload

## 软件配置

执行安装过程会复制三个重要的配置文件

- 服务进程配置文件 /etc/toughsmsd.conf  

该文件配置了所有相关的服务进程，通常无需修改

不过在不同内存的服务器需要调整以下参数

    [program:radiusrpcd]
    command=java -server -Xms64m -Xmx1024m -jar /opt/toughsms/bin/toughsms-rpcd.jar --server.port=1822
    dictionary=/opt/toughsms
    stopasgroup=true
    killasgroup=true
    startretries = 10
    autorestart = true
    redirect_stderr=true
    stdout_logfile=/home/toughsms/logs/toughsms-rpcd.log

其中 -Xms64m 是运行最小内存 -Xmx1024m 试运行最大内存，一般配置不超过一半内存。 -Xmx4096m 已经足够支撑上十万的用户缓存，该配置也与后续的软件线程池配置有关，如果修改java线程池，也可能需要修改此配置


- 系统 systemd  服务配置文件 /usr/lib/systemd/system/toughsms.service


    [Unit]  
    Description=toughsms
    After=network.target
    
    [Service]
    EnvironmentFile=/etc/sysconfig/toughsms
    Type=forking
    User=toughsms
    LimitNOFILE=65535
    LimitNPROC=65535
    ExecStart=/opt/toughsms/venv/bin/supervisord -c /etc/toughsmsd.conf
    ExecReload=/opt/toughsms/venv/bin/supervisorctl -c /etc/toughsmsd.conf restart all
    ExecStop=/opt/toughsms/venv/bin/supervisorctl -c /etc/toughsmsd.conf shutdown
    PrivateTmp=true  
       
    [Install]  
    WantedBy=multi-user.target  

通常该文件无需修改，注意如果修改， 必须执行 systemctl daemon-reload  才能使修改生效


- 程序环境变量参数配置 /etc/sysconfig/toughsms

> 注意： 修改 /etc/sysconfig/toughsms 后，必须执行 systemctl daemon-reload


该文件定义了程序运行的主要参数：

    # web 管理模块与主RPC服务模块的配置
    
    # python 模块 supervisor提供的rpc接口地址， 提供服务进程重启，停止，日志查看的功能
    TOUGHSMS_SUPERVISOR_URL=http://ctlman:ctlroot@127.0.0.1:9002/RPC2  
    # 主程序 WEB 服务端口，提供浏览器访问
    TOUGHSMS_WEB_PORT=1821
    # WEB 管理模块的文件上传目录
    TOUGHSMS_UPLOAD_DIR=/home/toughsms/upfiles
    # 数据库备份目录
    TOUGHSMS_BACKUP_DIR=/home/toughsms/backup
    # WEB 管理模块的日志目录
    TOUGHSMS_LOGDIR=/home/toughsms/logs
    # WEB 管理模块数据库配置
    TOUGHSMS_SQLA_TYPE=mysql
    TOUGHSMS_SQLA_URL=mysql://toughsms:toughsms@127.0.0.1:3306/toughsms?charset=utf8
    # WEB 管理模块的RPC配置，该配置可支持分布式环境， TOUGHSMS_RPCD_BIND 是服务端监听地址， TOUGHSMS_RPCD_CONNECT是客户端连接地址
    TOUGHSMS_RPCD_BIND="tcp://0.0.0.0:18789,tcp://0.0.0.0:18790"
    TOUGHSMS_RPCD_CONNECT="tcp://127.0.0.1:18789,tcp://127.0.0.1:18790"
    
    # RADIUS RPC 服务数据库配置
    RADIUS_RPCD_DBPWD=toughsms
    RADIUS_RPCD_DBUSER=toughsms
    RADIUS_RPCD_DBPOOL=60
    RADIUS_RPCD_JDBC_URL=jdbc:mysql://127.0.0.1:3306/toughsms?useUnicode=true&characterEncoding=UTF-8
    
    # RADIUS RPC 服务任务线程池
    RADIUS_RPCD_TASK_POOL=2
    # RADIUS RPC 服务 在线API接口地址
    RADIUS_RPCD_HTTP_URL=http://127.0.0.1:1822
    
    # RADIUS RPC 服务主机地址
    RADIUS_RPCD_HOST=127.0.0.1
    # RADIUS RPC 服务 日志debug开关 0/1
    RADIUS_RPCD_DEBUG=0
    #RADIUS RPC 服务 监听地址
    RADIUS_RPCD_BIND=0.0.0.0
    # RADIUS RPC 服务 监听端口
    RADIUS_RPCD_PORT=1815
    # RADIUS RPC 服务连接线程池
    RADIUS_RPCD_IO_WORKER=4
    # RADIUS RPC 服务消息处理线程池
    RADIUS_RPCD_SERVICE_WORKER=32
    # RADIUS RPC 服务每个消息线程处理的最大消息数
    RADIUS_RPCD_WORKER_QUEUE=256
    # RADIUS RPC 服务每个客户端的最大连接数
    RADIUS_RPCD_CLIENT_POOL=1000
    
    # RADIUS 引擎主机地址
    RADIUSD_HOSTNAME=radiusd_server
    # RADIUS 引擎每个进程的最大连接数
    RADIUSD_POOL=900
    # RADIUS 引擎消息收发进程
    RADIUSD_WORKER=4
    # RADIUS 引擎监听的UDP认证端口
    RADIUSD_AUTH_PORT=1812
    # RADIUS 引擎监听的UDP记账端口
    RADIUSD_ACCT_PORT=1813
    RADIUSD_IGNORE_PASSWD=0
    # RADIUS 引擎日志DEBUG开关 0/1
    RADIUSD_DEBUG=0
    # RADIUS 引擎消息统计文件地址
    RADIUSD_STAT_FILE=/home/toughsms/radiusd_stat.json
    # RADIUS 引擎日志目录
    RADIUSD_LOGDIR=/home/toughsms

> RADIUS RPC服务端的并发控制总数 = RADIUS_RPCD_SERVICE_WORKER x RADIUS_RPCD_WORKER_QUEUE

> RADIUS RPC客户端的并发控制总数 = RADIUSD_WORKER x RADIUSD_POOL

> RADIUS_RPCD_CLIENT_POOL 是保留参数，以后可能隐藏或弃用，RADIUS_RPCD_CLIENT_POOL >= RADIUSD_POOL


## 初始化数据库

使用 mysql 管理用户创建数据库，并赋权（注意你可能需要修改密码）：

    create database toughsms DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
    GRANT ALL ON toughsms.* TO toughsms@'127.0.0.1' IDENTIFIED BY 'toughsms' WITH GRANT OPTION;FLUSH PRIVILEGES;

进入程序目录，执行初始化数据库指令

    make initdb

或者

    venv/bin/python toughsms.py --cmd=initdb

## 启动服务

通过  systemctl 指令来管理服务进程

启动：

    systemctl start toughsms

停止：

    systemctl stop toughsms

状态：

    systemctl status toughsms

重启：

    systemctl restart toughsms

## 程序升级

- 通过 sftp 上传覆盖


通过这种方式升级，可以直接上传本地升级版本文件，注意升级前备份原目录和数据库


- 通过预置升级脚本升级

在服务器网络条件较好的情况下，可通过程序预置的升级脚本升级(自动备份原目录到/home/toughsms)：

    cd /opt/toughsms
    bin/upgrade latest

​    