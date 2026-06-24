<%@ page language="java" import="dbtaobao.connDb,java.util.*" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
ArrayList<String[]> list = connDb.index_6();
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
                <li><a href="./index3.jsp">商品类别交易额对比</a></li>
                <li><a href="./index4.jsp">各省份的总成交量对比</a></li>

                <li class="current"><a href="#">回头客购买力对比</a></li>
                <li><a href="./index7.jsp">购买转化漏斗图</a></li>
                <li><a href="./index8.jsp">品牌销量排行</a></li>
                <li><a href="./index9.jsp">商家销量排行</a></li>
                <li><a href="./index10.jsp">省份行为分布</a></li>
                <li><a href="./index11.jsp">年龄段行为偏好</a></li>
            </ul>
        </div>
        <div class="container">
            <div class="title">回头客购买力对比</div>
            <div class="show">
                <div class='chart-type'>柱状图 — 各年龄段购买回头率</div>
                <div id="main"></div>
            </div>
        </div>
    </div>
<script>
var myChart = echarts.init(document.getElementById('main'));
var womenData = {};
var menData = {};
var cats = {};
<%
	for(String[] a : list){
		String age = a[0];
		String gender = a[1];
		String num = a[2];
		if(gender.equals("0")){
			%>womenData['<%=age%>'] = <%=num%>;cats['<%=age%>'] = 1;<%
		}else if(gender.equals("1")){
			%>menData['<%=age%>'] = <%=num%>;cats['<%=age%>'] = 1;<%
		}
	}
%>
var ageList = Object.keys(cats).sort(function(a,b){return a-b;});
var ageLabels = {'0':'未知','1':'<18岁','2':'18-24岁','3':'25-29岁','4':'30-34岁','5':'35-39岁','6':'40-49岁','7':'50岁以上'};
var ageNames = ageList.map(function(a){return ageLabels[a]||a+'岁';});
var womenValues = ageList.map(function(a){ return womenData[a] || 0; });
var menValues = ageList.map(function(a){ return menData[a] || 0; });

option = {
    title: { text: '回头客预测分数对比', left: 'center', textStyle: { fontSize: 16 } },
    tooltip: { trigger: 'axis', axisPointer: { type: 'shadow' } },
    legend: { data: ['女性', '男性'], top: 30 },
    xAxis: { type: 'category', data: ageNames, name: '年龄段' },
    yAxis: { type: 'value', name: '购买次数' },
    series: [{
        name: '女性', type: 'bar', data: womenValues,
        itemStyle: { color: '#de2d26' }
    }, {
        name: '男性', type: 'bar', data: menValues,
        itemStyle: { color: '#3182bd' }
    }]
};
myChart.setOption(option);
myChart.resize();
window.addEventListener('resize', function() { myChart.resize(); });
</script>
</body>
</html>