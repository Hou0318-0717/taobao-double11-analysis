<%@ page language="java" import="dbtaobao.connDb,java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
ArrayList<String[]> list = connDb.index_12();
HashMap<String,int[]> ageMap = new HashMap();
String actLabels[]={"收藏","购买","加购物车","点击"};
for(String[] a:list){
  String age=a[0]; int act=Integer.parseInt(a[1]); int n=Integer.parseInt(a[2]);
  if(!ageMap.containsKey(age)) ageMap.put(age,new int[4]);
  ageMap.get(age)[act]=n;
}
ArrayList<String> ageKeys = new ArrayList(ageMap.keySet());
Collections.sort(ageKeys);
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
<li><a href="./index8.jsp">品牌销量排行</a></li><li><a href="./index9.jsp">商家销量排行</a></li>
<li><a href="./index10.jsp">省份行为分布</a></li>
<li class="current"><a href="#">年龄段行为偏好</a></li>
</ul></div>
<div class="container"><div class="title">年龄段行为偏好</div>
<div class="show"><div class="chart-type">雷达图 — 各年龄段在四种行为上的对比</div>
<div id="main"></div></div></div></div>
<script>
<% // compute max values in Java
int[] maxVals = new int[4];
for(String age : ageKeys){ int[] v=ageMap.get(age); for(int i=0;i<4;i++) if(v[i]>maxVals[i]) maxVals[i]=v[i]; }
%>
var indicator = [{name:'点击',max:<%=maxVals[0]%>},{name:'加购物车',max:<%=maxVals[1]%>},{name:'购买',max:<%=maxVals[2]%>},{name:'收藏',max:<%=maxVals[3]%>}];
var seriesData = [];
var ageMap2 = {'0':'未知','1':'<18','2':'18-24','3':'25-29','4':'30-34','5':'35-39','6':'40-49','7':'50+'};
<% for(String age : ageKeys){ int[] v=ageMap.get(age); %>
seriesData.push({name:ageMap2['<%=age%>']||'<%=age%>岁',value:[<%=v[0]%>,<%=v[1]%>,<%=v[2]%>,<%=v[3]%>]});<% } %>
var myChart = echarts.init(document.getElementById('main'));
option = {
    title:{text:'年龄段行为偏好雷达图',left:'center',textStyle:{fontSize:16}},
    tooltip:{}, legend:{data:seriesData.map(function(d){return d.name;}),bottom:0},
    radar:{indicator:indicator,shape:'circle',splitArea:{areaStyle:{color:['rgba(114,172,209,0.2)','rgba(114,172,209,0.4)','rgba(114,172,209,0.6)','rgba(114,172,209,0.8)','rgba(114,172,209,1)']}}},
    series:[{type:'radar',data:seriesData}]
};
myChart.setOption(option); myChart.resize();
window.addEventListener('resize',function(){myChart.resize();});
</script></body></html>