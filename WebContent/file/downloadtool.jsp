<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="javax.servlet.*"%>
<%@ page import="java.util.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
<title>下载服务器上的文件</title>
</head>
<body>
	<h2>文件下载界面</h2>
	<form>
		输入你上传过的文件名(如123.txt,带后缀,不要有中文):<br> <input name="a" type="text"> <input
			type="button"
			onclick="window.location.href = 'dodownload.jsp?path=C:/Users/Bug/eclipse-workspace2/.metadata/.plugins/org.eclipse.wst.server.core/tmp0/wtpwebapps/TestWeb/image/' + a.value"
			value="下载">
	</form>
	<form id="form1" method="post">
		<br> <a href='../index.jsp'>返回首页</a>
	</form>
</body>
</html>
