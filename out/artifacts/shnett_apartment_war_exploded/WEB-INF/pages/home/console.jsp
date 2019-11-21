<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>

<div class="layui-row layui-col-space12">
    <div class="layui-col-md6">
        <div class="layui-card">
            <div class="layui-card-header">
                人员入住率
            </div>
            <div class="layui-card-body">
                <div id="user" style="height: 557px"></div>
            </div>
        </div>
    </div>
    <div class="layui-col-md6">
        <div class="layui-card">
            <div class="layui-card-header">
                公寓入住率
            </div>
            <div class="layui-card-body">
                <div id="bed" style="height:500px"></div>
                <div class="layui-form-item">
                    <div class="layui-inline">
                        <label class="layui-form-label">公寓名称</label>
                        <div class="layui-input-block">
                            <select name="SelectApartment" xm-select="SelectApartment" id="SelectApartment"
                                    lay-verType="tips"
                                    class="layui-input-inline"
                                    xm-select-radio=""
                                    xm-select-search=""
                                    xm-select-search-type="dl"
                                    xm-select-skin="default">
                            </select>
                        </div>
                    </div>

                    <div class="layui-inline">
                        <button class="layui-btn layui-btn-normal" data-method="search" id="search">搜索</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript" src="assets/echarts/echarts.min.js"></script>
<script type="text/javascript" src="assets/echarts/macarons.js"></script>
<script type="text/javascript" src="assets/echarts/vintage.js"></script>
<script type="text/javascript" src="assets/echarts/walden.js"></script>

<script>
    var apa_id = '';
    layui.use(['layer', 'formSelects', 'upload', 'admin', 'element'],
        function () {
            layer = layui.layer,
                formSelects = layui.formSelects,
                admin = layui.admin,
                element = layui.element,
                $ = layui.jquery;
            formSelects.data('SelectApartment', 'server', {
                url: "getAllApartmentInfo",
                success: function () {
                    getBedCheckInCounts('');
                }
            });
            formSelects.on('SelectApartment', function (id, vals, val, isAdd, isDisabled) {
                //id:           点击select的id
                //vals:         当前select已选中的值
                //val:          当前select点击的值
                //isAdd:        当前操作选中or取消
                //isDisabled:   当前选项是否是disabled
                console.log(vals[0]);
                if (typeof (vals[0]) == 'undefined') {
                    apa_id = '';
                } else {
                    apa_id = vals[0].value;
                }
                console.log(apa_id);
            }, true);
            admin.ajax_load_json({
                url: 'getUserCheckInCounts',
                success: function (res) {
                    if (res.code == 1) {
                        layer.alert(res.data, {icon: 5});
                        return;
                    }
                    if (res.msg == "0" && res.info=="0") {
                        layer.msg('无用户数据');
                        return;
                    }
                    var _in=0,_not_in=0;
                    _in=res.msg*1,_not_in=res.info*1;
                    var dom = document.getElementById("user");
                    var myChart = echarts.init(dom,'macarons');
                    var app = {};
                    option = null;
                    var option = {
                        title: {
                            text: '人员入住占比',
                            left: 'center',
                            top: 20
                        },
                        legend: {},
                        tooltip: {},
                        toolbox: {// 工具箱
                            show: true,
                            orient: 'horizontal',
                            feature: {
                                saveAsImage: {}
                            },
                            right: '20'
                        },
                        series: [
                            {
                                name:'入住人数',
                                type:'pie',
                                radius: ['50%', '70%'],
                                avoidLabelOverlap: false,
                                label: {
                                    normal: {
                                        formatter: '{b}:{c}' + '\n\r' + '({d}%)',
                                        show: true,
                                        position: 'left'
                                    },
                                    emphasis: {
                                        show: true,
                                        textStyle: {
                                            fontSize: '20',
                                            fontWeight: 'bold'
                                        }
                                    }
                                },
                                labelLine: {
                                    normal: {
                                        show: true
                                    }
                                },
                                data:[
                                    {value:_in, name:'已入住'},
                                    {value:_not_in, name:'未入住'}
                                ]
                            }
                        ]
                    }
                    if (option && typeof option === "object") {
                        myChart.setOption(option, true);
                    }
                }
            });

            $("#search").on('click', function () {
                getBedCheckInCounts(apa_id);
            });

            function getBedCheckInCounts(apa_id) {
                admin.ajax_load_json({
                    url: 'getBedCheckInCounts',
                    data: {
                        apa_id: apa_id
                    },
                    success: function (res) {
                        if (res.code == 1) {
                            layer.alert(res.data, {icon: 5});
                            return;
                        }
                        if (res.msg == "0" &&res.info =="0") {
                            layer.alert('无床位数据');
                            var dom = document.getElementById("bed");
                            var myChart = echarts.init(dom);
                            var app = {};
                            option = null;
                            var option = {};
                            if (option && typeof option === "object") {
                                myChart.setOption(option, true);
                            }
                            return;
                        }
                        var _in=0,_not_in=0;
                        _in=res.msg*1,_not_in=res.info*1;
                        var dom = document.getElementById("bed");
                        var myChart = echarts.init(dom,'macarons');
                        var app = {};
                        option = null;
                        var option = {
                            title: {
                                text: '床位入住占比',
                                left: 'center',
                                top: 20
                            },
                            legend: {},
                            tooltip: {},
                            toolbox: {// 工具箱
                                show: true,
                                orient: 'horizontal',
                                feature: {
                                    saveAsImage: {}
                                },
                                right: '20'
                            },
                            series: [
                                {
                                    name:'入住人数',
                                    type:'pie',
                                    radius: ['50%', '70%'],
                                    avoidLabelOverlap: false,
                                    label: {
                                        normal: {
                                            formatter: '{b}:{c}' + '\n\r' + '({d}%)',
                                            show: true,
                                            position: 'left'
                                        },
                                        emphasis: {
                                            show: true,
                                            textStyle: {
                                                fontSize: '20',
                                                fontWeight: 'bold'
                                            }
                                        }
                                    },
                                    labelLine: {
                                        normal: {
                                            show: true
                                        }
                                    },
                                    data:[
                                        {value:_in, name:'已入住'},
                                        {value:_not_in, name:'未入住'}
                                    ]
                                }
                            ]
                        }
                        if (option && typeof option === "object") {
                            myChart.setOption(option, true);
                        }
                    }
                })
            }
        });
</script>