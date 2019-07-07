<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page import="hanquan.*,java.util.*"%><%--.*表示当前目录下的所有class都被引用 --%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="zh-CN">
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>BootStrap转换页</title>
<!-- Bootstrap -->
<link href="css/bootstrap.min.css" rel="stylesheet">
<script src="css/jquery.min.js"></script>
<script src="css/bootstrap.js"></script>
<style>
.container {
	herght: 300px;
}
</style>
</head>
<body>
	<div class="container">

		<h1>第一步：上传文件</h1>
	</div>

	<div class="container">
		<br />


		<blockquote>
			<p>
				使用的jar包是
				<code>commons-io-1.4.jar</code>
				,
				<code>commons-fileupload-1.2.1.jar</code>
			</p>
		</blockquote>
		<h3>
			<a href="file/fileindex.jsp">文件上传</a>
		</h3>

		<!-- 本页面总访问量begin -->
		本页面总访问量： <font size="5" color="orange"><%=Count.getCount()%></font> <br>
		<!-- 本页面总访问量end -->
		<a href="index2.html">网站模板</a>


	</div>

	<div class="container">
		<blockquote>
			<p>
				使用的jar包是
				<code>commons-io-1.4.jar</code>
				<br>commons-fileupload-1.2.1.jar
			</p>
		</blockquote>


		<div class="row">
			<div class="col-md-4">col-md-4</div>
			<div class="col-md-4">col-md-4</div>
			<div class="col-md-4">col-md-4</div>
			<!-- 说明：每row行共12列，分个3div，每个div平占4列，即3个*4列=12列 -->
		</div>
		<div class="row">
			<div class="col-md-4">col-md-4</div>
			<div class="col-md-8">col-md-8</div>
			<!-- 说明：每row行共12列，分个2div，第1个div占4列，第2个div则占8列，即4列+8列=12列 -->
		</div>
		<div class="row">
			<div class="col-md-3">col-md-3</div>
			<div class="col-md-6">col-md-6</div>
			<div class="col-md-3">col-md-3</div>
			<!-- 说明：每row行共12列，分个3div，每1,3个div占3列，第2个div则占6列，即3列+6列+3列=12列 -->
		</div>
	</div>
</body>
</html>
