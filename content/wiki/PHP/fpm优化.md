### **php-fpm 优化**
采用FastCGi 协议
多进程
fpm 常用配置
1. error_log 错误日志
2. pm static|dynamic|ondemand (pm 模式)
3. static ：提前生成所有的子进程
4. dynamic：子进程是动态分配的，随着请求量的变化而变化
5. ondemand ：直接摒弃 不用
6. pm.max_children 最大子进程数量
7. pm.start_servers 启动时的进程数量 默认为 min_spare_servers+(max_spare_servers-min_spare_servers)/2
8. pm.min_spare_servers 空闲时进程数量
9. pm.max_spare_servers 空闲时最大进程数量

优点：版本迭代可以不用重启 php进程

缺点：执行效率差 一个请求就是一个子进程，进程对资源的开销很大。