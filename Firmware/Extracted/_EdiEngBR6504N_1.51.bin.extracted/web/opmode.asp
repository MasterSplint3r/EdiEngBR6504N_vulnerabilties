<html>
<head>
<link rel="stylesheet" href="set.css">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Operation Mode</title>
<script type="text/javascript" src="javascript.js"></script>
<script type="text/javascript" src="file/miscellaneous-n.var"></script>
<script type="text/javascript" src="common.js"></script>
<script>
function evaltF()
{
	if (document.fmOpMode.opMode[1].checked==true){
		parent.lFrame.showMenu(1,"enWIsp");
	}
	else {
		parent.lFrame.showMenu(1,"disWIsp");
	}
	return true;
}
</script>

</head>
<body class="background" style="background-color: #FFFFFF" background="file/back-a.gif">
<blockquote>
<p align="center"><b><font class="titlecolor" size="4">
<font face="Times New Roman" color="#000080"><script>dw(wanType)</script></font></font></b></p>
<div align="center">
	<table border="0" width="540" cellspacing="1" cellpadding="0" id="table1">
		<tr>
			<td><font class="textcolor"  size="2"><script>dw(opmodeContent)</script></font></td>
		</tr>
	</table>
</div>
<form action=/goform/formOpMode method=POST name="fmOpMode">
<div align="center">
<table border="1" cellspacing="0" width="540">
	<tr>
		<td bgcolor="#808080">
			<font color="#FFFFFF">
			<input type="radio" value="0" name="opMode"></font><font size=2 color="#FFFFFF"> <b><script>dw(ethernet)</script>:</b> </font>
		</td>
		<td bgcolor="#FFFFFF" width="385">
			<font style="font-size: 9pt"><script>dw(opmodeContent2)</script></font><span style="font-size: 9pt">
			</span>
		</td>
	</tr>
	
	<tr>
		<td bgcolor="#808080">
		<font color="#FFFFFF">
		<input type="radio" value="1" name="opMode"></font><font size=2 color="#FFFFFF"> <b><script>dw(wirelessISP)</script>:</b> </font>
		</td>
		<td bgcolor="#FFFFFF" width="385">
			<font style="font-size: 9pt"><script>dw(opmodeContent3)</script></font><span style="font-size: 9pt">
			</span>
		</td>
	</tr>
</table>
</div>
<script>
	opmode = <% write(getIndex("opMode")); %> ;
	document.fmOpMode.opMode[opmode].defaultChecked= true;
	document.fmOpMode.opMode[opmode].checked= true;
</script>

<br>
<table width="540" border="0" cellspacing="0" cellpadding="0" align="center">
<tr><div align="right">
<input type=hidden value="/opmode.asp" name="submit-url">
<script>buffer='<input type=submit value="'+showText(apply1)+'" name="save" style ="width:100px" onclick="return evaltF();">';document.write(buffer);</script>
<script>buffer='<input type=button value="'+showText(cancel1)+'" style ="width:100px" onClick="document.fmOpMode.reset();">';document.write(buffer);</script>
</div>
</tr>
</table>

</form>
</blockquote>
</font>
</body>

</html>
