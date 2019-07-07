<%@page import="com.itextpdf.text.log.SysoLogger"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page import="java.util.*"%>
<%-- Java 自带的文件操作包 --%>
<%@ page import="java.io.*"%>
<%@ page import="java.lang.*"%>
<%-- FileUpload组件用到的文件上传类 --%>
<%@ page import="org.apache.commons.fileupload.*"%>
<%@ page import="org.apache.commons.fileupload.disk.*"%>
<%@ page import="org.apache.commons.fileupload.servlet.*"%>

<%!String fileName = "";%><%--存储文件名称 用于给js传值 --%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>选择排列方式</title>
<!-- Bootstrap -->
<link href="../css/bootstrap.min.css" rel="stylesheet">
<script src="../css/jquery.min.js"></script>
<script src="../css/bootstrap.js"></script>
<style>
.container {
	herght: 300px;
}
</style>
</head>

<body>

	<div class="container">
		<h1>选择排列方式</h1>
		<div class="col-md-12">
			<%
				//取得整个web应用的物理根路径（注意不是jsp项目根路径）
				String root = request.getSession().getServletContext().getRealPath("/");
				//设置上传文件的保存路径（绝对路径/物理路径）
				String savePath = root + "image/";
				//创建一个基于磁盘文件项目的工厂
				DiskFileItemFactory factory = new DiskFileItemFactory();
				//创建文件上传对象	
				ServletFileUpload upload = new ServletFileUpload(factory);
				//解析request请求并返回FileItem对象集合
				List items = upload.parseRequest(request);
				//遍历集合
				Iterator iter = items.iterator();
				//如果集合中有值
				while (iter.hasNext()) {
					//取出FileItem对象
					FileItem item = (FileItem) iter.next();
					//判断是否是文本域(type='file')控件
					if (item.isFormField()) {
						//普通控件的时候，取得空间的值
						String name = item.getString("GBK");
						//输出
						out.print("文本框取到的值: " + name + "<br/>");
					} else {
						//取得文件名字
						fileName = item.getName();
						//创建一个java文件对象，参数是要存放的路径
						File savedFile = new File(savePath + fileName);
						if (fileName.endsWith(".ppt") || fileName.endsWith(".pptx")) {
							//保存上传的文件	        
							item.write(savedFile);
							//输出
							out.print("<br>文件上传结果：上传成功：" + fileName);
							System.out.println("文件存储的位置: " + savePath);
						} else {
							//item.write(savedFile);非ppt文件不保存，避免恶意文件
							out.print("<br>* 上传结果：上传失败！你上传的" + fileName + "不是PPT文档，无法转换。请检查文件是否正确，然后重新上传。");
						}
					}
				}
			%>

		</div>
		<div class="col-md-6">
			<h3 style="color: #990066">普通用户模式</h3>
			<br>
			<h4>请选择排列方式：</h4>

			<form>
				<div class="radio">
					<div class="radio">
						<label> &nbsp&nbsp<input type="radio" name="chooser" 
							value="1*2" checked="checked" onclick= "javascript:preview0()"/>1*2
						</label>
					</div>
					<div class="radio">
						<label> &nbsp&nbsp<input type="radio" name="chooser"
							value="1*3" onclick= "javascript:preview1()"/>1*3
						</label>
					</div>
					<div class="radio">
						<label> &nbsp&nbsp<input type="radio" name="chooser"
							value="2*4" onclick= "javascript:preview2()"/>2*4
						</label>
					</div>
					<div class="radio">
						<label> &nbsp&nbsp<input type="radio" name="chooser"
							value="2*5" onclick= "javascript:preview3()"/>2*5
						</label>
					</div>
					<div class="radio">
						<label> &nbsp&nbsp<input type="radio" name="chooser"
							value="3*7" onclick= "javascript:preview4()"/>3*7
						</label>
					</div>
					<div class="radio">
						<label> &nbsp&nbsp<input type="radio" name="chooser"
							value="3*8" onclick= "javascript:preview5()"/>3*8
						</label>
					</div>
				</div>
			</form>

			<br>
			<h4>请选择你上传的PPT画幅比例：</h4>
			<form>
				<div class="radio">
					<label> &nbsp&nbsp<input type="radio" name="scale"
						value="1*2" onclick= "javascript:preview_0()" checked >4:3<br>
					</label>
				</div>
				<div class="radio">
					<label> &nbsp&nbsp<input type="radio" name="scale"
						value="1*3" onclick= "javascript:preview_1()" >16:9<br>
					</label>
				</div>
			</form>
			<br> <br> <input id="userBegin" type="button"
				class="btn btn-primary btn-lg btn-block" onclick="test1()"
				value="开始转换">
		</div>
		
		<style>
		img{border:solid 1px green;}
		</style>
		<!-- 效果预览图 -->
		<div class="col-md-6">
			<h3 style="color: #990066">&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp效果预览（示例模板）</h3>
			&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp 
			<img  src="../assets/images/default.png" id="picture" border="5" alt="图片加载失败" width="300" height="425"/>
			
			<br> <br> <br> <br> <br> <br>
		</div>

		<script>
		var rank=0;
		var scale=0;
		
		function preview0()
		{
			rank=0;
			preview();	
		}
		function preview1()
		{
			rank=1;
			preview();
		}
		function preview2()
		{
			rank=2;
			preview();
		}
		function preview3()
		{
			rank=3;
			preview();
		}
		function preview4()
		{
			rank=4;
			preview();
		}
		function preview5()
		{
			rank=5;
			preview();
		}
		
		function preview_0()
		{
			scale=0;
			preview();
		}
		function preview_1()
		{
			scale=1;
			preview();
		}
		
		function preview()
		{
			if(rank==0)
			{
				if(scale==0)
				{
					var pictureUrl = "../assets/images/4.3.1.2.png";
					document.getElementById("picture").src = pictureUrl;	
				}
				else
				{
					var pictureUrl = "../assets/images/16.9.1.2.png";
					document.getElementById("picture").src = pictureUrl;	
				}
			}
			else if(rank==1)
			{
				if(scale==0)
				{
					var pictureUrl = "../assets/images/4.3.1.3.png";
					document.getElementById("picture").src = pictureUrl;	
				}
				else
				{
					var pictureUrl = "../assets/images/16.9.1.3.png";
					document.getElementById("picture").src = pictureUrl;	
				}
			}
			else if(rank==2)
			{
				if(scale==0)
				{
					var pictureUrl = "../assets/images/4.3.2.4.png";
					document.getElementById("picture").src = pictureUrl;	
				}
				else
				{
					var pictureUrl = "../assets/images/16.9.2.4.png";
					document.getElementById("picture").src = pictureUrl;	
				}
			}
			else if(rank==3)
			{
				if(scale==0)
				{
					var pictureUrl = "../assets/images/4.3.2.5.png";
					document.getElementById("picture").src = pictureUrl;	
				}
				else
				{
					var pictureUrl = "../assets/images/16.9.2.5.png";
					document.getElementById("picture").src = pictureUrl;	
				}
			}
			else if(rank==4)
			{
				if(scale==0)
				{
					var pictureUrl = "../assets/images/4.3.3.7.png";
					document.getElementById("picture").src = pictureUrl;	
				}
				else
				{
					var pictureUrl = "../assets/images/16.9.3.7.png";
					document.getElementById("picture").src = pictureUrl;	
				}
			}
			else if(rank==5)
			{
				if(scale==0)
				{
					var pictureUrl = "../assets/images/4.3.3.8.png";
					document.getElementById("picture").src = pictureUrl;	
				}
				else
				{
					var pictureUrl = "../assets/images/16.9.3.8.png";
					document.getElementById("picture").src = pictureUrl;	
				}
			}
		}
		</script>

		<!-- 开发者模式begin -->
		<div class="col-md-6">
			<h3 style="color: #990066">* 开发者模式</h3>
			<br>
			<h4>你也可以输入自定义参数：</h4>
			<div class="col-md-3">
				<form>
					起点横坐标<input id="QI_HENG" class="form-control" name="zidingyi"
						type="text"><br> 起点竖坐标<input id="QI_SHU"
						class="form-control" name="zidingyi" type="text"><br>
					图的横长度<input id="TU_HENG" class="form-control" name="zidingyi"
						type="text"><br> 图的竖长度<input id="TU_SHU"
						class="form-control" name="zidingyi" type="text"><br>

				</form>
			</div>

			<div class="col-md-3">
				竖向减<input id="SHU_JIAN" class="form-control" name="zidingyi"
					type="text"><br> 竖向增<input id="HENG_ZENG"
					class="form-control" name="zidingyi" type="text"><br>
				横求余<input id="HENG_YU" class="form-control" name="zidingyi"
					type="text"><br> 竖求余<input id="SHU_YU"
					class="form-control" name="zidingyi" type="text"><br>

			</div>
			<br> <input type="button"
				class="btn btn-warning btn-lg btn-block" onclick="developer()"
				disabled="disabled" value="开始转换 (暂未开启，敬请期待)">
		</div>
		<!-- 开发者模式end -->

		<!-- 选择排列 比例 end -->

		<script>
		//选择排列方式 比例
		function test1() 
		{
			var myname= "<%=fileName%>";
			var mychoose;
			var choosenum;
			var obj = document.getElementsByName("chooser");
		    for(var i=0; i<obj.length; i ++)
		    {
		        if(obj[i].checked)
		        {
		        	choosenum=i;
		        	mychoose = obj[i].value;
		            //alert(obj[i].value);
		            //alert("文件名为：" + myname + "你选择的排列方式为：" + mychoose);
		            break;
		        }
		    }
			
		    var scale;
		    var obj1 = document.getElementsByName("scale");
		    if(obj1[0].checked)
	        {
		    	 scale = 0;
		    	 alert("文件名为：" + myname + "，你选择的排列方式为：" + mychoose+"，你选择的比例为4：3");
	        }
		    else if(obj1[1].checked)
	        {
		    	 scale = 1;
		    	 alert("文件名为：" + myname + "，你选择的排列方式为：" + mychoose+"，你选择的比例为16：9");
	        }
		    else
	    	{
		    	 scale = 0;
		    	 alert("文件名为：" + myname + "，你选择的排列方式为：" + mychoose+"，你没有选择比例，默认4：3");
	    	}
		    
			//跳转
			var url = "convert.jsp?myname=" + myname + "&choosenum=" + choosenum+ "&scale=" + scale;
			window.location.href = url;
		}
	</script>

		<script>
		//开发者模式
		function developer() 
		{
			var myname= "<%=fileName%>
			";
				var mychoose;
				var choosenum;
				var obj = document.getElementsByName("chooser");

				//获取文本框里的值
				var QI_HENG = document.getElementById("QI_HENG").value;
				var QI_SHU = document.getElementById("QI_SHU").value;
				var TU_HENG = document.getElementById("TU_HENG").value;
				var TU_SHU = document.getElementById("TU_SHU").value;
				var SHU_JIAN = document.getElementById("SHU_JIAN").value;
				var HENG_ZENG = document.getElementById("HENG_ZENG").value;
				var HENG_YU = document.getElementById("HENG_YU").value;
				var SHU_YU = document.getElementById("SHU_YU").value;

				alert("自定义数据：" + QI_HENG + "," + QI_SHU + "," + TU_HENG + ","
						+ TU_SHU + "," + SHU_JIAN + "," + HENG_ZENG + ","
						+ HENG_YU + "," + SHU_YU);

				//跳转
				var url = "developer.jsp?QI_HENG=" + QI_HENG + "&QI_SHU="
						+ QI_SHU + "&TU_HENG=" + TU_HENG + "&TU_SHU=" + TU_SHU
						+ "&SHU_JIAN=" + SHU_JIAN + "&HENG_ZENG=" + HENG_ZENG
						+ "&HENG_YU=" + HENG_YU + "&SHU_YU=" + SHU_YU;
				window.location.href = url;
			}
		</script>

	</div>
</body>
</html>
