<%@ page language="java" import="dbtaobao.connDb,java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
ArrayList<String[]> list = connDb.index_9();
%>
<!DOCTYPE html><html><head>
<meta charset="UTF-8"><meta http-equiv="Cache-Control" content="no-cache,no-store,must-revalidate">
<meta http-equiv="Pragma" content="no-cache"><meta http-equiv="Expires" content="0">
<title>ECharts 可视化分析淘宝双11</title>
<link href="./css/style.css" rel="stylesheet"/><script src="./js/echarts.min.js"></script>
</head><body>
<div class="header"><p>ECharts 可视化分析淘宝双11</p></div>
<div class="content"><div class="nav"><ul>
<li><a href="./index.jsp">所有买家各消费行为对比</a></li><li><a href="./index1.jsp">男女买家交易对比</a></li>
<li><a href="./index2.jsp">男女买家年龄段交易对比</a></li><li><a href="./index3.jsp">商品类别交易额对比</a></li>
<li><a href="./index4.jsp">各省份的总成交量对比</a></li><li><a href="./index6.jsp">回头客购买力对比</a></li>
<li><a href="./index7.jsp">购买转化漏斗图</a></li>
<li><a href="./index8.jsp">品牌销量排行</a></li><li class="current"><a href="#">商家销量排行</a></li>
<li><a href="./index10.jsp">省份行为分布</a></li>
<li><a href="./index11.jsp">年龄段行为偏好</a></li>
</ul></div>
<div class="container"><div class="title">商家销量排行</div>
<div class="show"><div class="chart-type">柱状图 — 销量前十商家</div>
<div id="main"></div></div></div></div>
<script>
var x=[],y=[];
<% for(String[] a:list){ %>x.push('商家<%=a[0]%>');y.push(<%=a[1]%>);<% } %>
var myChart = echarts.init(document.getElementById('main'));
option = {
    title:{text:'商家销量排行TOP10',left:'center',textStyle:{fontSize:16}},
    tooltip:{trigger:'axis',axisPointer:{type:'shadow'}},
    xAxis:{type:'category',data:x,axisLabel:{rotate:20}},
    yAxis:{type:'value',name:'销量'},
    series:[{type:'bar',data:y,itemStyle:{color:new echarts.graphic.LinearGradient(0,0,0,1,[{offset:0,color:'#56ab2f'},{offset:1,color:'#a8e063'}])}}]
};
myChart.setOption(option); myChart.resize();
window.addEventListener('resize',function(){myChart.resize();});
</script></body></html>