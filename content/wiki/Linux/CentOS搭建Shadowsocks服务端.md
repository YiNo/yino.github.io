CentOS搭建Shadowsocks服务端
最新方法：
1.安装
直接依次执行下列命令：
```shell
yum install python-setuptools
easy_install pip
pip install shadowsocks
```
即可完成Shadowsocks服务端安装。
2、配置
新建/etc/shadowsocks.json文件，内容如下
```json
{
"server":"服务器IP",
"server_port":8388,
"local_address": "127.0.0.1",
"local_port":1080,
"password":"密码",
"timeout":300,
"method":"aes-256-cfb",
"fast_open": false
}
```
3、运行
前台运行(Ctrl+C或者关闭终端服务会自动停止)：
```shell
ssserver -c /etc/shadowsocks.json

后台运行(推荐，关闭终端后服务会继续运行)：
ssserver -c /etc/shadowsocks.json -d start
ssserver -c /etc/shadowsocks.json -d stop
 
```