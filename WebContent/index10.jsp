<%@ page language="java" import="dbtaobao.connDb,java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
ArrayList<String[]> list = connDb.index_10();
HashMap<String,int[]> provMap = new HashMap();
ArrayList<String> provList = new ArrayList();
for(String[] a:list){
  String prov=a[0]; int act=Integer.parseInt(a[1]); int n=Integer.parseInt(a[2]);
  if(!provMap.containsKey(prov)){ provMap.put(prov,new int[4]); provList.add(prov); }
  provMap.get(prov)[act]=n;
}
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
<li class="current"><a href="#">省份行为分布</a></li>
<li><a href="./index11.jsp">年龄段行为偏好</a></li>
</ul></div>
<div class="container"><div class="title">省份行为分布</div>
<div class="show"><div class="chart-type">堆叠柱状图 — 各省份点击/加购/收藏/购买分布</div>
<div id="main"></div></div></div></div>
<script>
var provinces=[]; var d0=[],d1=[],d2=[],d3=[];
<% for(String prov : provList){ int[] v=provMap.get(prov); %>
provinces.push('<%=prov%>');d0.push(<%=v[0]%>);d1.push(<%=v[1]%>);d2.push(<%=v[2]%>);d3.push(<%=v[3]%>);<% } %>
var myChart = echarts.init(document.getElementById('main'));
option = {
    title:{text:'省份行为分布',left:'center',textStyle:{fontSize:16}},
    tooltip:{trigger:'axis',axisPointer:{type:'shadow'}},
    legend:{data:['点击','加购物车','购买','收藏'],top:30},
    xAxis:{type:'category',data:provinces,axisLabel:{rotate:30,fontSize:10}},
    yAxis:{type:'value',name:'数量'},
    series:[
      {name:'点击',type:'bar',stack:'total',data:d0,itemStyle:{color:'#d9534f'}},
      {name:'加购物车',type:'bar',stack:'total',data:d1,itemStyle:{color:'#5bc0de'}},
      {name:'购买',type:'bar',stack:'total',data:d2,itemStyle:{color:'#5cb85c'}},
      {name:'收藏',type:'bar',stack:'total',data:d3,itemStyle:{color:'#f0ad4e'}}
    ]
};
myChart.setOption(option); myChart.resize();
window.addEventListener('resize',function(){myChart.resize();});
</script></body></html>