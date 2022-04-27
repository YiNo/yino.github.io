### **one way**

[github](https://github.com/yino/once-flight) [gitee](https://gitee.com/sun17ya/once-flight)

#### 应用场景
在高并发场景下，n个用户同时查询同一个商品详情就会对应n个db查询，如果能将n个db查询合并成一个db查询，那么性能db的性能肯定会提升很多，此工具包就是为了解决此问题

#### 优点
1. 减少了db压力
2. 解决了缓存击穿问题；若此时key刚好失效那么到db的请求始终只会有一个

#### 应用方式：
```go
round := 10
var wg sync.WaitGroup
barrier := onceFlight.NewOnceFlight()
wg.Add(round)
for i := 0; i < round; i++ {
    go func() {
        defer wg.Done()
        // 启用10个协程模拟获取缓存操作
        val, err := barrier.Do("get_rand_int", func() (interface{}, error) {
            time.Sleep(time.Second)
            return rand.Int(), nil
        })
        if err != nil {
            fmt.Println(err)
        } else {
            fmt.Println(val)
        }
    }()
}
wg.Wait()
```
以上代码模拟了10个goroutine 去获取db数据；第一个参数key，可以理解为标示符，第二个参数是匿名函数，封装好要做的业务逻辑。最终获得结果是
```text
=== RUN   TestNewOnceFlight
5577006791947779410
5577006791947779410
5577006791947779410
5577006791947779410
5577006791947779410
5577006791947779410
5577006791947779410
5577006791947779410
5577006791947779410
5577006791947779410
--- PASS: TestNewOnceFlight (1.00s)
```
可直接运行代码库中的once_flight_test.go

#### 代码解读：
```go
func (g *onceGroup) createCall(key string) (*call, bool) {
	g.mutex.Lock()
	// defer g.mutex.Unlock()
	// 其他相同请求
	if c, ok := g.calls[key]; ok {
		g.mutex.Unlock()
		c.wg.Wait()
		return c, true
	}
	// 第一个请求
	c := new(call)
	c.wg.Add(1)
	g.calls[key] = c
	g.mutex.Unlock()
	return c, false
}

// makeCall .
func (g *onceGroup) makeCall(c *call, key string, fn func() (interface{}, error)) {
	defer func() {
		g.mutex.Lock()
		delete(g.calls, key)
		g.mutex.Unlock()
		c.wg.Done()
	}()
	c.val, c.err = fn()
}
```
此代码充分利用了 数据结构map，若map存在则证明已经有goroutine去查询了，当前goroutine只需要等待即可；**map在go中是非线程安全的因此需要加锁**


### 总结
善用wg.wait去完成协程阻塞场景；

通过匿名函数完成业务逻辑

代码还有优化空间，加锁会导致延迟等，能否通过sync.map 线程安全的 map完成或通过原子变量完成，有待实践且优化
