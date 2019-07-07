<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page import="hanquan.*,java.util.*"%>
<%--.*表示当前目录下的所有class都被引用 --%>

<html>
<body>
	<h2>这是一个在jsp页面中调用java类的简单例子</h2>
	本页面总访问量：

	<font size="5" color="purple"><%=Count.getCount()%></font>
	<br>
	<input type="button" onclick="test()" value="点击加一" />
	<script>
		function test() {
			var url = "visitCount.jsp";
			window.location.href = url;
		}
	</script>
</body>
</html>
