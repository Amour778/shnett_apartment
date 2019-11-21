layui.config({
	base: "statics/js/"
}).use(['form', 'element', 'layer'],function() {
	var form = layui.form,
	layer = parent.layer === undefined ? layui.layer: parent.layer,
	element = layui.element,
	$ = layui.jquery;
/*点击元素打开界面
	$(".panel a").on("click",function() {
		window.parent.addTab($(this));
	})
*/

	
	
})