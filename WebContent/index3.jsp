<%@ page language="java" import="dbtaobao.connDb,java.util.*" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
ArrayList<String[]> list = connDb.index_3();
%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate">
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Expires" content="0">
<title>ECharts 可视化分析淘宝双11</title>
<link href="./css/style.css" type='text/css' rel="stylesheet"/>
<script src="./js/echarts.min.js"></script>
</head>
<body>
	<div class='header'>
        <p>ECharts 可视化分析淘宝双11</p>
    </div>
    <div class="content">
        <div class="nav">
            <ul>
                <li><a href="./index.jsp">所有买家各消费行为对比</a></li>
                <li><a href="./index1.jsp">男女买家交易对比</a></li>
                <li><a href="./index2.jsp">男女买家年龄段交易对比</a></li>
                <li class="current"><a href="#">商品类别交易额对比</a></li>
                <li><a href="./index4.jsp">各省份的总成交量对比</a></li>

                <li><a href="./index6.jsp">回头客购买力对比</a></li>
                <li><a href="./index7.jsp">购买转化漏斗图</a></li>
                <li><a href="./index8.jsp">品牌销量排行</a></li>
                <li><a href="./index9.jsp">商家销量排行</a></li>
                <li><a href="./index10.jsp">省份行为分布</a></li>
                <li><a href="./index11.jsp">年龄段行为偏好</a></li>
            </ul>
        </div>
        <div class="container">
            <div class="title">商品类别交易额对比</div>
            <div class="show">
                <div class='chart-type'>柱状图 — 销量前五的商品类别</div>
                <div id="main"></div>
            </div>
        </div>
    </div>
<script>
//基于准备好的dom，初始化echarts实例
var myChart = echarts.init(document.getElementById('main'));
// 指定图表的配置项和数据
var x = []
var y = []
<%
	for(String[] a:list){
		%>
		x.push(<%=a[0]%>);
		y.push(<%=a[1]%>);
		<%
	}
%>
option = {
    title: { text: '销量前五的商品类别', left: 'center', textStyle: { fontSize: 16 } },
    color: ['#3398DB'],
    tooltip : {
        trigger: 'axis',
        axisPointer : { type : 'shadow' },
        formatter: function(params) {
            var p = params[0];
            return '商品类别: ' + p.name + '<br/>成交量: ' + p.value;
        }
    },
    grid: { left: '3%', right: '4%', bottom: '10%', containLabel: true },
    xAxis : [{
        type : 'category', data : x, axisLabel: { rotate: 15 },
        axisTick: { alignWithLabel: true },
        name: '商品类别ID'
    }],
    yAxis : [{ type : 'value', name: '成交量' }],
    series : [{
        name:'成交量', type:'bar', barWidth: '50%', data:y,
        itemStyle: { color: new echarts.graphic.LinearGradient(0,0,0,1,[{offset:0,color:'#83bff6'},{offset:1,color:'#188df0'}]) }
    }]
};
// 使用刚指定的配置项和数据显示图表。
myChart.setOption(option);
myChart.resize();
window.addEventListener('resize', function() { myChart.resize(); });
</script>
</body>
</html>