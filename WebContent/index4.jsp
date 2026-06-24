<%@ page language="java" import="dbtaobao.connDb,java.util.*" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
ArrayList<String[]> list = connDb.index_4();
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
                <li class="current"><a href="#">各省份的总成交量对比</a></li>

                <li><a href="./index6.jsp">回头客购买力对比</a></li>
                <li><a href="./index7.jsp">购买转化漏斗图</a></li>
                <li><a href="./index8.jsp">品牌销量排行</a></li>
                <li><a href="./index9.jsp">商家销量排行</a></li>
                <li><a href="./index10.jsp">省份行为分布</a></li>
                <li><a href="./index11.jsp">年龄段行为偏好</a></li>
            </ul>
        </div>
        <div class="container">
            <div class="title">各省份的总成交量对比</div>
            <div class="show">
                <div class='chart-type'>地图</div>
                <div id="main"></div>
            </div>
        </div>
    </div>
<script>
var nameMap = {
  '北京':'北京市','天津':'天津市','上海':'上海市','重庆':'重庆市',
  '河北':'河北省','山西':'山西省','辽宁':'辽宁省','吉林':'吉林省',
  '黑龙江':'黑龙江省','江苏':'江苏省','浙江':'浙江省','安徽':'安徽省',
  '福建':'福建省','江西':'江西省','山东':'山东省','河南':'河南省',
  '湖北':'湖北省','湖南':'湖南省','广东':'广东省','海南':'海南省',
  '四川':'四川省','贵州':'贵州省','云南':'云南省','陕西':'陕西省',
  '甘肃':'甘肃省','青海':'青海省','台湾':'台湾省',
  '内蒙古':'内蒙古自治区','广西':'广西壮族自治区',
  '西藏':'西藏自治区','宁夏':'宁夏回族自治区',
  '新疆':'新疆维吾尔自治区','香港':'香港特别行政区','澳门':'澳门特别行政区'
};

fetch('https://geo.datav.aliyun.com/areas_v3/bound/100000_full.json')
  .then(function(res) { return res.json(); })
  .then(function(chinaJson) {
    echarts.registerMap('china', chinaJson);
    var myChart = echarts.init(document.getElementById('main'));
    var mapData = [];
    <%
      for(String[] a : list) {
        String name = a[0];
        String val = a[1];
    %>
      mapData.push({name: nameMap['<%=name%>'] || '<%=name%>', value: <%=val%>});
    <%
      }
    %>
    option = {
      backgroundColor: '#FFFFFF',
      title: {
        text: '各省份的总成交量对比',
        left: 'center',
        top: 20,
        textStyle: { color: '#333' }
      },
      visualMap: {
        min: 0,
        max: Math.max.apply(null, mapData.map(function(d) { return d.value; })),
        left: 'left',
        top: 'center',
        text: ['高', '低'],
        calculable: true,
        precision: 0,
        itemWidth: 20,
        itemHeight: 120,
        inRange: { color: ['#fee5d9', '#fcae91', '#fb6a4a', '#de2d26', '#a50f15'] }
      },
      tooltip: {
        trigger: 'item',
        formatter: function(params) {
          return params.name + '<br/>成交量：' + (params.value || 0);
        }
      },
      series: [{
        name: '成交量',
        type: 'map',
        map: 'china',
        roam: true,
        label: { show: true, fontSize: 11, color: '#333' },
        emphasis: { label: { show: true, fontSize: 14, fontWeight: 'bold' } },
        data: mapData
      }]
    };
    myChart.setOption(option);
    myChart.resize();
    window.addEventListener('resize', function() { myChart.resize(); });
  })
  .catch(function(err) {
    document.getElementById('main').innerHTML = '<p style="color:red;text-align:center;padding-top:50px;">地图数据加载失败，请检查网络连接</p>';
  });
</script>
</body>
</html>