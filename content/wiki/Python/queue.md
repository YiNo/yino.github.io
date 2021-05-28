## **Queue**

```
from queue import Queue
#maxsize默认为0 ，不受限
# 一旦>0,消息数又达到限制 q.put()也将阻塞
q = Queue(maxsize=0)
#阻塞程序，等待队列消息
q.get()
#获取消息，设置超时时间
q.get(timeout=5.0)
#发送消息
q.put()
#等待所有的消息都被消费完
q.join()
#查询当前队列的消息个数
q.size()
#队列消息是否被消费完 True/False
q.empty()
#检测队列里消息是否已满
q.full()
```