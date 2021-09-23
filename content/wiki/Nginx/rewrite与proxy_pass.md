### rewrite 与 proxy_pass

#### rewrite
 
- 如果正则表达式（regex）匹配到了请求的URI（request URI），这个URI会被后面的replacement替换
- rewrite的定向会根据他们在配置文件中出现的顺序依次执行
- 通过使用flag可以终止定向后进一步的处理
- 如果replacement以“http://”, “https://”, or “$scheme”开头，处理将会终止，请求结果会以重定向的形式返回给客户端（client）
- 如果replacement字符串里有新的request参数，那么之前的参数会附加到其后面，如果要避免这种情况，那就在replacement字符串后面加上“？”，eg：
- rewrite相当于是重定向到了目标网站，**浏览器会跳转到目标网站**
```text
 rewrite ^/users/(.*)$ /?user=$1? last;=
```

#### proxy_pass

- **不影响浏览器地址栏的url**
- 设置被代理server的协议和地址，URI可选（可以有，也可以没有）
- 协议可以为http或https
- 地址可以为域名或者IP，端口可选；eg：
```text
 proxy_pass http://localhost:8000/uri/;
```
- 如果proxy_pass的URL定向里包括URI，那么请求中匹配到location中URI的部分会被proxy_pass后面URL中的URI替换，eg：

```text
location /name/ {
    proxy_pass http://127.0.0.1/remote/;
}
请求http://example.com/name/test.html 会被代理到http://127.0.0.1/remote/test.html
```

- 如果proxy_pass的URL定向里不包括URI，那么请求中的URI会保持原样传送给后端server，eg：

```text
location /name/ {
    proxy_pass http://127.0.0.1;
}

请求http://example/name/test.html 会被代理到http://127.0.0.1/name/test.html
```

