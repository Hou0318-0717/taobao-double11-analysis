# 淘宝双11数据分析与预测 (Taobao Double 11 Data Analysis)

基于 Spark + ECharts 的淘宝双11用户行为数据分析与可视化项目。

## 项目概述

本项目基于厦门大学数据库实验室《Spark课程综合实验案例：淘宝双11数据分析与预测》，对淘宝用户行为日志（5500万条记录）进行全流程大数据处理与分析，构建 11 个维度的 ECharts 可视化图表。

## 技术栈

| 技术 | 用途 |
|------|------|
| Ubuntu 24.04 | 操作系统 |
| Hadoop 3.4.1 | HDFS 分布式文件系统 |
| Hive 3.1.3 | 数据仓库 |
| MySQL 8.0.46 | Web 后端数据库 |
| Spark 3.5.8 | 分布式计算 + MLlib 机器学习 |
| Tomcat 9.0 | Web 应用服务器 |
| Eclipse | Java Web 开发 IDE |
| ECharts 3.7.3 | 前端可视化库 |

## 数据集

| 文件 | 记录数 | 字段 |
|------|--------|------|
| user_log.csv | 54,925,330 | user_id, item_id, cat_id, merchant_id, brand_id, month, day, action, age_range, gender, province |
| train.csv | 7,030,723 | user_id, age_range, gender, merchant_id, label |
| test.csv | 7,027,944 | user_id, age_range, gender, merchant_id, label |

### 数据字典

| 字段 | 取值 | 含义 |
|------|------|------|
| action | 0/1/2/3 | 0=点击, 1=加购物车, 2=购买, 3=收藏 |
| age_range | 0~7 | 0=未知, 1=<18, 2=18-24, 3=25-29, 4=30-34, 5=35-39, 6=40-49, 7=50+ |
| gender | 0/1/2 | 0=女, 1=男, 2=未知 |
| label | 0/1/-1 | 0=非回头客, 1=回头客, -1=超出范围 |

## 功能页面

| 页面 | 图表 | 说明 |
|------|------|------|
| index.jsp | 南丁格尔玫瑰图 | 4种消费行为分布（点击/加购/购买/收藏） |
| index1.jsp | 饼图 | 男女买家交易对比 |
| index2.jsp | 散点图 | 各年龄段×性别交易量 |
| index3.jsp | 柱状图 | TOP5 商品类别 |
| index4.jsp | 地图（GeoJSON） | 各省份成交量 |
| index6.jsp | 分组柱状图 | 回头客购买力对比 |
| index7.jsp | 漏斗图 | 购买转化路径 |
| index8.jsp | 柱状图 | TOP10 品牌销量 |
| index9.jsp | 柱状图 | TOP10 商家销量 |
| index10.jsp | 堆叠柱状图 | 省份×行为分布 |
| index11.jsp | 雷达图 | 年龄段行为偏好 |

## 快速开始

### 环境要求

- JDK 17+
- Tomcat 9.0+
- MySQL 8.0+
- ECharts 3.x（已包含在项目中）

### 部署步骤

1. 将项目导入 Eclipse（File → Import → Existing Projects）
2. 配置 Tomcat 9.0 服务器
3. 创建 MySQL 数据库并导入数据
4. 修改 `connDb.java` 中的数据库连接参数
5. 部署并启动 Tomcat
6. 访问 `http://localhost:8080/MyWebApp/`

## 参考

- [厦大数据库实验室 - 淘宝双11数据分析与预测](https://dblab.xmu.edu.cn/post/8116/)
