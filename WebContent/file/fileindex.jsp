<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!-- 此页面用于上传文件。点击“上传”按钮后，发送post请求，上传后的文件被fileupload.jsp接收 -->
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	
	<title>上传您的PPT文档</title>
	
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
	<h1>文件上传</h1>
</div>

<div class="container">
		<div class="col-md-6">
			<!-- 上传文件begin -->
				<form action="fileupload.jsp" method="post" enctype="multipart/form-data">
				<br/>
					<blockquote>请先选择文件，然后点击上传按钮。</blockquote>
					<input class="btn btn-primary btn-lg btn-block" type="file" name="upfile" onclick="enableUpLoad()"/>
				<br/>
					<input id="upLoad" class="btn btn-warning btn-lg btn-block"	 accept=".ppt,.pptx" disabled="disabled" type="submit" value="上传" />
				</form>
				<br>
				<script>
					function enableUpLoad()
					{
						document.getElementById("upLoad").disabled=false;
						console.log("上传按钮生效");
					}
				</script>
			<!-- 上传文件end -->
		</div>
		
		<div class="col-md-6">
		<h3>条款说明：</h3>
			<p>1、文件上传、使用均免费；</p>
			<p>2、单个文件最大为 100M，支持ppt、pptx类型文件；</p>
			<p>3、严禁上传色情、暴力、损害他人或国家利益的非法内容；</p>
			<p>4、上传或转载的文件应是无法律纠纷的；</p>
			<p>5、因不可抗力而造成用户数据泄露，本站不承担责任，如黑客攻击、病毒入侵等；</p>
			<p>6、本站定期删除您上传的文件；</p>
			<p>7、上传即表示同意上述约定。</p>
		</div>
</div>
</body>
</html>