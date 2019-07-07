<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<h3>开发者模式</h3>

	<%
		int QI_HENG = Integer.parseInt(request.getParameter("QI_HENG"));
		int QI_SHU = Integer.parseInt(request.getParameter("QI_SHU"));
		int TU_HENG = Integer.parseInt(request.getParameter("TU_HENG"));
		int TU_SHU = Integer.parseInt(request.getParameter("TU_SHU"));
		int SHU_JIAN = Integer.parseInt(request.getParameter("SHU_JIAN"));
		int HENG_ZENG = Integer.parseInt(request.getParameter("HENG_ZENG"));
		int HENG_YU = Integer.parseInt(request.getParameter("HENG_YU"));
		int SHU_YU = Integer.parseInt(request.getParameter("SHU_YU"));

		out.println("<br>你输入的数据为：" + QI_HENG + "," + QI_SHU + "," + TU_HENG + "," + TU_SHU + "," + SHU_JIAN + ","
				+ HENG_ZENG + "," + HENG_YU + "," + SHU_YU);
	%>
下面调用convert函数，传参即可
	<%
		/*
			if (fileName.endsWith(".pptx"))
			{
				switch(num)//输出选择的排列方式
				{
					case 0: PPTtoPDF.ConvertPPTX(fileName, 1, 2); break;
					case 1: PPTtoPDF.ConvertPPTX(fileName, 1, 3); break;
					case 2: PPTtoPDF.ConvertPPTX(fileName, 2, 4); break;
					case 3: PPTtoPDF.ConvertPPTX(fileName, 2, 5); break;
					case 4: PPTtoPDF.ConvertPPTX(fileName, 3, 7); break;
					case 5: PPTtoPDF.ConvertPPTX(fileName, 3, 8); break;
				}
			} else if (fileName.endsWith(".ppt"))
			{
				switch(num)//输出选择的排列方式
				{
					case 0: PPTtoPDF.ConvertPPT(fileName, 1, 2); break;
					case 1: PPTtoPDF.ConvertPPT(fileName, 1, 3); break;
					case 2: PPTtoPDF.ConvertPPT(fileName, 2, 4); break;
					case 3: PPTtoPDF.ConvertPPT(fileName, 2, 5); break;
					case 4: PPTtoPDF.ConvertPPT(fileName, 3, 7); break;
					case 5: PPTtoPDF.ConvertPPT(fileName, 3, 8); break;
				}
		
			} else
			{
				out.print("<br>你上传的文件不是ppt，无法转换");
			}
		*/
	%>
</body>
</html>