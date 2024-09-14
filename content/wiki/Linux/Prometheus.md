# Prometheus

## 简介
   Prometheus受启发于Google的Brogmon监控系统（相似的Kubernetes是从Google的Brog系统演变而来），从2012年开始由前Google工程师在Soundcloud以开源软件的形式进行研发，并且于2015年早期对外发布早期版本。2016年5月继Kubernetes之后成为第二个正式加入CNCF基金会的项目，同年6月正式发布1.0版本。2017年底发布了基于全新存储层的2.0版本，能更好地与容器平台、云平台配合。

## 监控的目的/重要性
在《SRE: Google运维解密》一书中指出，监控系统需要能够有效的支持白盒监控和黑盒监控。通过白盒能够了解其内部的实际运行状态，通过对监控指标的观察能够预判可能出现的问题，从而对潜在的不确定因素进行优化。而黑盒监控，常见的如HTTP探针，TCP探针等，可以在系统或者服务在发生故障时能够快速通知相关的人员进行处理。通过建立完善的监控体系，从而达到以下目的：

- 长期趋势分析：通过对监控样本数据的持续收集和统计，对监控指标进行长期趋势分析。例如，通过对磁盘空间增长率的判断，我们可以提前预测在未来什么时间节点上需要对资源进行扩容。
- 对照分析：两个版本的系统运行资源使用情况的差异如何？在不同容量情况下系统的并发和负载变化如何？通过监控能够方便的对系统进行跟踪和比较。
- 告警：当系统出现或者即将出现故障时，监控系统需要迅速反应并通知管理员，从而能够对问题进行快速的处理或者提前预防问题的发生，避免出现对业务的影响。
故障分析与定位：当问题发生后，需要对问题进行调查和处理。通过对不同监控监控以及历史数据的分析，能够找到并解决根源问题。
- 数据可视化：通过可视化仪表盘能够直接获取系统的运行状态、资源使用情况、以及服务运行状态等直观的信息。

## Prometheus的优势
    Prometheus是一个开源的完整监控解决方案，其对传统监控系统的测试和告警模型进行了彻底的颠覆，形成了基于中央化的规则计算、统一分析和告警的新模型。 相比于传统监控系统Prometheus具有以下优点：

### 易于管理
    Prometheus核心部分只有一个单独的二进制文件，不存在任何的第三方依赖(数据库，缓存等等)。唯一需要的就是本地磁盘，因此不会有潜在级联故障的风险。
    Prometheus基于Pull模型的架构方式，可以在任何地方（本地电脑，开发环境，测试环境）搭建我们的监控系统。对于一些复杂的情况，还可以使用Prometheus服务发现(Service Discovery)的能力动态管理监控目标。

### 监控服务的内部运行状态
    Pometheus鼓励用户监控服务的内部状态，基于Prometheus丰富的Client库，用户可以轻松的在应用程序中添加对Prometheus的支持，从而让用户可以获取服务和应用内部真正的运行状态。
### 强大的数据类型
### 强大的查询语言PromQL
### 可扩展
### 易于集成
### 可视化
### 社区完善
    社区中有很多现有开源方案 高效配合grafana

## 结构

- Prometheus Server (服务端 用于存储信息等)
- Prometheus client (客户端 用于收集信息，等待服务端采集)
### Prometheus Server
从 https://prometheus.io/download/ 找到最新版的 Server软件包
Linux
```shell
export VERSION=2.4.3

curl -LO  https://github.com/prometheus/prometheus/releases/download/v$VERSION/prometheus-$VERSION.darwin-amd64.tar.

tar -xzf prometheus-${VERSION}.darwin-amd64.tar.gz

cd prometheus-${VERSION}.darwin-amd64
```

解压后Prometheus配置文件orimethes.yml
```
# my global config
global:
  scrape_interval:     15s # Set the scrape interval to every 15 seconds. Default is every 1 minute.
  evaluation_interval: 15s # Evaluate rules every 15 seconds. The default is every 1 minute.
  # scrape_timeout is set to the global default (10s).
# Alertmanager configuration
alerting:
  alertmanagers:
  - static_configs:
    - targets:
      # - alertmanager:9093
# Load rules once and periodically evaluate them according to the global 'evaluation_interval'.
rule_files:
  # - "first_rules.yml"
  # - "second_rules.yml"
# A scrape configuration containing exactly one endpoint to scrape:
# Here it's Prometheus itself.
scrape_configs:
  # The job name is added as a label `job=<job_name>` to any timeseries scraped from this config.
  - job_name: 'prometheus'
    # metrics_path defaults to '/metrics'
    # scheme defaults to 'http'.
    static_configs:
    - targets: ['localhost:9090']
```
Promtheus作为一个时间序列数据库，其采集的数据会以文件的形式存储在本地中，默认的存储路径为data/，因此我们需要先手动创建该目录：

用户也可以通过参数--storage.tsdb.path="data/"修改本地数据存储的路径。

启动prometheus服务，其会默认加载当前路径下的prometheus.yaml文件;

成功后 访问 http://localhost:9090 会看到Prometheus UI
### Prometheus client
客户端分为多种类型 [官方支持](https://prometheus.io/download/#node_exporter)
- blackbox_exporter
- consul_exporter
- graphite_exporter
- memcached_exporter （memcache 缓存）
- mysqld_exporter （MySQL 监控）
- node_exporter （常用 服务器配置）
- nginx_exporter ([社区](https://github.com/nginxinc/nginx-prometheus-exporter) 官方不支持 需要引用开源社区的)

#### 配置示例
在需要服务器监控的节点中下载
##### node_exporter
```shell
curl -OL https://github.com/prometheus/node_exporter/releases/download/v1.8.2/node_exporter-1.8.2.linux-amd64.tar.gz

tar -xzf node_exporter-1.8.2.linux-amd64.tar.gz

cd node_exporter-1.8.2.linux-amd64
# 运行 二进制文件 端口是 9100
./node_exporter/node_exporter
```
##### nginx_exporter
```shell
curl -OL https://github.com/nginxinc/nginx-prometheus-exporter/releases/download/v1.3.0/nginx-prometheus-exporter_1.3.0_linux_amd64.tar.gz

tar -xzf nginx-prometheus-exporter_1.3.0_linux_amd64.tar.gz

cd nginx-prometheus-exporter_1.3.0_linux_amd64
# 运行 二进制文件 端口是 9113
./nginx_exporter/nginx_exporter
```
##### 配置 Prometheus Server
```yml
global:
  scrape_interval:     5s
  evaluation_interval: 5s

  external_labels:
      monitor: 'dashboard'

alerting:
 alertmanagers:
 - static_configs:
    - targets:
        - "192.168.0.100:9093"

rule_files:
  - /etc/prometheus/rules/*.rules

scrape_configs:  
  - job_name: 'prometheus'
    scrape_interval: 5s
    static_configs:
      - targets: ['prometheus:9090']

  - job_name: node
    static_configs:
      - targets: ['172.20.0.10:9113','172.20.0.9:9100', '172.20.0.6:9100']

```

### 配置Grafana 
建议用docker部署
```yaml
grafana:
    image: grafana/grafana
    container_name: grafana
    user: root
#    restart: always
    ports:
      - "3000:3000"
    volumes:
      #- ./conf/grafana:/etc/grafana
      - ./prometheus/data/prometheus/grafana_data:/var/lib/grafana
    environment:
      GF_SECURITY_ADMIN_PASSWORD: ""
      GF_SECURITY_DISABLE_LOGIN_FORM: "true"
```
#### 配置 node_exporter 面板
1. 选择datasource "prometheus"
2. [dashboard](https://grafana.com/grafana/dashboards/?) 在此连接中选择合适的即可

#### 配置  nginx_exporter

1. 选择datasource "prometheus"
2. [dashboard](https://grafana.com/grafana/dashboards/?) 在此连接中选择合适的即可