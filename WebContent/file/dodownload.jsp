<%@page import="com.itextpdf.text.log.SysoLogger"%>
<%@ page language="java" import="java.util.*,java.io.*" pageEncoding="utf-8"%>
<%
	//下载普通文件，exe文件有时会报错

	//设置响应编码格式
	response.setCharacterEncoding("utf-8");
	//获取文件路径，将路径编码转成iso-8859-1编码方式
	String path = request.getParameter("path");
	System.out.println("path="+path);
	path = new String(path.getBytes("utf-8"));//这里不要写成iso-8859-1啊

	//建一个带有缓冲区域的输入输出对象
	BufferedInputStream in = null;
	BufferedOutputStream os = null;
	try
	{
		//System.out.println("这里执行了1");
		File file = new File(path);
		
		//System.out.println("这里执行了1.5");
		in = new BufferedInputStream(new FileInputStream(file));
		
		//System.out.println("这里执行了2");
		//制定文件默认名，这里对文件名做了处理，以免文件名出现乱码
		//为下载界面中显示的默认文件名和文件大小
		response.addHeader("Content-Disposition", "attachment;filename=" + new String(file.getName().getBytes("utf-8"), "iso-8859-1"));
		//System.out.println("这里执行了3");
		response.addHeader("Content-Length", file.length() + "");

		System.out.println("response部分="+new String(file.getName().getBytes("utf-8"), "iso-8859-1"));
		//让服务器告诉浏览器它发送的数据属于什么文件类型，最容易出错（对于.exe文件）,其他文件类型都能正常下载；
		//在网络上传输文件，最好是要将.exe文件打包，再传最好！
		response.setContentType("application/x-msdownload");

		os = new BufferedOutputStream(response.getOutputStream());
		byte[] buff = new byte[2048];
		int bytesRead;

		while (-1 != (bytesRead = in.read(buff, 0, buff.length)))
		{
			os.write(buff, 0, bytesRead);
		}
	} catch (FileNotFoundException fe)
	{
		System.out.println("文件没找到"+fe);
	} catch (final IOException e)
	{
		System.out.println("出现IOException." + e);
	} finally
	{
		if (in != null)
			in.close();
		if (os != null)
			os.close();
		out.clear();
		out = pageContext.pushBody();
	}
%>