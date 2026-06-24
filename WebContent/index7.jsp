<%@ page language="java" import="dbtaobao.connDb,java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
ArrayList<String[]> list = connDb.index();
int click=0,cart=0,fav=0,buy=0;
for(String[] a:list){
  String act=a[0]; String n=a[1];
  if("0".equals(act)) click=Integer.parseInt(n);
  else if("1".equals(act)) cart=Integer.parseInt(n);
  else if("2".equals(act)) buy=Integer.parseInt(n);
  else if("3".equals(act)) fav=Integer.parseInt(n);
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
<li><a href="./index.jsp">所有买家各消费行为对比</a></li>
<li><a href="./index1.jsp">男女买家交易对比</a></li>
<li><a href="./index2.jsp">男女买家年龄段交易对比</a></li>
<li><a href="./index3.jsp">商品类别交易额对比</a></li>
<li><a href="./index4.jsp">各省份的总成交量对比</a></li>

<li><a href="./index6.jsp">回头客购买力对比</a></li>
<li class="current"><a href="#">购买转化漏斗图</a></li>
<li><a href="./index8.jsp">品牌销量排行</a></li>
<li><a href="./index9.jsp">商家销量排行</a></li>
<li><a href="./index10.jsp">省份行为分布</a></li>


<li><a href="./index11.jsp">年龄段行为偏好</a></li>
</ul></div>
<div class="container"><div class="title">购买转化漏斗图</div>
<div class="show"><div class="chart-type">漏斗图 — 用户从点击到购买的转化路径</div>
<div id="main"></div></div></div></div>
<script>
var myChart = echarts.init(document.getElementById('main'));
option = {
    title: { text: '购买转化漏斗', left: 'center', textStyle:{fontSize:16} },
    tooltip: { trigger: 'item', formatter: function(p){return p.name+'<br/>数量: '+p.value+'<br/>转化率: '+p.percent+'%';} },
    series: [{
        type:'funnel', left:'10%', top:60, bottom:60, width:'80%',
        minSize:'10%', maxSize:'100%', sort:'desc', gap:2,
        label: { show:true, formatter:function(p){return p.name+' ('+p.percent+'%)';} },
        data: [
            { value:<%=click%>, name:'点击' },
            { value:<%=cart%>, name:'加购物车' },
            { value:<%=fav%>, name:'收藏' },
            { value:<%=buy%>, name:'购买' }
        ]
    }]
};
myChart.setOption(option);
myChart.resize();
window.addEventListener('resize',function(){myChart.resize();});
</script>
</body></html>