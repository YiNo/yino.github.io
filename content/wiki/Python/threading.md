## **threading**
关于线程方面
```python
常用函数（t= threading.Thread(target=func)）：
t.start() #启动线程
t.join()#阻塞子线程 待 子线程结束后再往下进行
t.is_alive() & t.isAlive() #判断线程是否在执行状态，在执行状态返回 true 否则返回false
t.daemon = true|false #设置线程是否随主线程退出而退出，默认为False
t.name=“name”# 设置线程的名字
锁
#生成全局唯一锁
lock = threading.Lock()
#获取锁,未获取到会阻塞程序 直到获取到锁 才会往下执行
lock.acquire()
#释放锁，
lock.release()

```

例：
```python

lock = threading.Lock()
with lock :
#业务
pass
with 语句会在这个代码块执行前自动获取锁，在执行结束后自动释放锁

Event事件#通信机制
event = threading.Event()
#重置event 使得所有该event事件都处于待命状态
event.clear()
#等待接收event的指令 决定是否阻塞程序执行
event.wait()
#发送event指令，使所有设置该event事件的线程执行
event.set()
```

http://python.jobbole.com/81546/

