<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="hanquan.*"%>
<%@ page import="java.util.*"%>
<%-- Java 自带的文件操作包 --%>
<%@ page import="java.io.*"%>
<%@ page import="java.lang.*"%>
<%@ page import="java.awt.*"%>
<%@ page import="javax.imageio.*"%>
<%-- FileUpload组件用到的文件上传类 --%>
<%@ page import="org.apache.commons.fileupload.*"%>
<%@ page import="org.apache.commons.fileupload.disk.*"%>
<%@ page import="org.apache.commons.fileupload.servlet.*"%>
<!-- poi -->
<%@ page import="org.apache.poi.hslf.usermodel.*"%>
<%@ page import="com.itextpdf.text.*"%>
<%@ page import="com.itextpdf.text.log.SysoLogger"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>转换结果</title>
	<!-- Bootstrap -->
	<link href="../css/bootstrap.min.css" rel="stylesheet">
	<script src="../css/jquery.min.js"></script>
	<script src="../css/bootstrap.js"></script>
</head>

<body>
<div class="container">
	<h1>转换结果</h1>
	<h3 style="color:#990066">文件信息</h3>
	<%!String fileName = "";%><%--存储文件名称 用于给js传值 --%>
	<%!String shortFileName;%>
	<%
	String fileName = request.getParameter("myname");						// 普通文件名
	if (fileName.endsWith(".pptx")) {
		shortFileName = fileName.substring(0, fileName.length() - 5);
	} else if (fileName.endsWith(".ppt")) {
		shortFileName = fileName.substring(0, fileName.length() - 4);
	}
	%>
	<%		
		String rankChoose = request.getParameter("choosenum");
		out.println("<br>你上传的文件名为：" + fileName);
		System.out.println("myname为：" + fileName);
		System.out.println("rankChoose为：" + rankChoose);
		int num = Integer.parseInt(rankChoose);//转换方式
		int scale = Integer.parseInt(request.getParameter("scale"));//转换比例
		switch(num)//输出选择的排列方式
		{
			case 0: out.println("<br>你选择的排列方式为：1*2");break;
			case 1: out.println("<br>你选择的排列方式为：1*3");break;
			case 2: out.println("<br>你选择的排列方式为：1*4");break;
			case 3: out.println("<br>你选择的排列方式为：2*5");break;
			case 4: out.println("<br>你选择的排列方式为：3*7");break;
			case 5: out.println("<br>你选择的排列方式为：3*8");break;
		}
		switch(scale)//输出选择的比例排列方式
		{
			case 0: out.println("<br>你选择的比例为：4：3");break;
			case 1: out.println("<br>你选择的比例为：16：9");break;
		}
	%>

	<%
		if (fileName.endsWith(".pptx"))
		{
			switch(num)
			{
				case 0: PPTtoPDF.ConvertPPTX(fileName, 1, 2, scale); break;
				case 1: PPTtoPDF.ConvertPPTX(fileName, 1, 3, scale); break;
				case 2: PPTtoPDF.ConvertPPTX(fileName, 2, 4, scale); break;
				case 3: PPTtoPDF.ConvertPPTX(fileName, 2, 5, scale); break;
				case 4: PPTtoPDF.ConvertPPTX(fileName, 3, 7, scale); break;
				case 5: PPTtoPDF.ConvertPPTX(fileName, 3, 8, scale); break;
			}
			out.print("<font size=\"3\" color=\"green\"><br><br><p>转换成功！</p></font>");
		} else if (fileName.endsWith(".ppt"))
		{
			switch(num)
			{
				case 0: PPTtoPDF.ConvertPPT(fileName, 1, 2, scale); break;
				case 1: PPTtoPDF.ConvertPPT(fileName, 1, 3, scale); break;
				case 2: PPTtoPDF.ConvertPPT(fileName, 2, 4, scale); break;
				case 3: PPTtoPDF.ConvertPPT(fileName, 2, 5, scale); break;
				case 4: PPTtoPDF.ConvertPPT(fileName, 3, 7, scale); break;
				case 5: PPTtoPDF.ConvertPPT(fileName, 3, 8, scale); break;
			}
			out.print("<font size=\"3\" color=\"green\"><br><br><p>恭喜您，转换成功！</p></font>");
		} else
		{
			out.print("<font size=\"3\" color=\"red\"><br><br><p>转换失败！你上传的文件不是ppt，无法转换！</p></font>");
		}
	%>

	<br>
	<br>
	<form>
		<input type="button" class="btn btn-warning"
			onclick="window.location.href = 'dodownload.jsp?path=C:/Users/Bug/eclipse-workspace3/.metadata/.plugins/org.eclipse.wst.server.core/tmp0/wtpwebapps/WebPPTtoPDF/image/<%=shortFileName%>/<%=shortFileName%>.pdf'"
			value="点此下载PDF文档">
	</form>
</div>
</body>
</html>
