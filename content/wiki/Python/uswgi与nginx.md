## **python uwsgi 与nginx配置**
### **nginx config**
```nginx
server{
    listen ***;
    server_name domain;
    charset utf-8;
    
    location / {
        include uwsgi_params;
        uwsgi_pass 127.0.0.1:PORT;
        uwsgi_param UWSGI_PYTHON /usr/bin/python3; // python 解释器 路径
        uwsgi_param UWSGI_CHDIR /opt/dataV; // 项目目录
        uwsgi_param UWSGI_SCRIPT run:app; // 项目的主程序
    }

}

```
### **uwsgi config**

```ini
[uwsgi]
# 监听端口
socket = 127.0.0.1:PORT
# 项目根目录
chdir = /opt/dataV
# python 启动文件 
wsgi-file = run.py
# 程序内启用的application变量名
callable = app
# 进程数量
process = 4
vacuum = true
master = true
```