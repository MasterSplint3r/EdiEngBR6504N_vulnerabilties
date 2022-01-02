<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<script>
<%  write("wlDev = "+getIndex("wlDev"));%>
if (wlDev == 0)
	document.write("<title>Broadband Router</title>");
else 
	document.write("<title>Wireless Router</title>");
</script>
</head>
<frameset rows="85,*" border="0" framespacing="0" frameborder="no">
	<frameset cols="196,77%" border="0" framespacing="0" frameborder="no">
		<frame name="logo" scrolling="no" src="logo.html" target="_self">
		<frame name="topFrame" src="file/title.asp" scrolling="no" noresize target="_self">
	</frameset>

	<frameset cols="*" border="0" framespacing="0" frameborder="no">
	<frameset rows="*" border="0" framespacing="0" frameborder="no">
		<frameset cols="200,*" border="0" framespacing="0" frameborder="no">
			<frame name="lFrame" src="genmenu.asp" scrolling="auto" target="_self">
			<frame name="main" src="template1.html" target="_self" scrolling="auto">
		</frameset>
	</frameset>
	</frameset>
</frameset>

<noframes> 
</frameset>
<body bgcolor="#FFFFFF" text="#000000">
</body>
</noframes></html>
