<html><head><title>WEB Upgrade</title>
<link rel="stylesheet" href="set.css">
<meta http-equiv="content-type" content="text/html;charset=utf-8">
<script type="text/javascript" src="javascript.js"></script>
<script type="text/javascript" src="file/miscellaneous-n.var"></script>
<script language="JavaScript">
function checktarget()
{
	var test;
	
	if( document.upload.target.selectedIndex == 0 )
		test = "upgrade.asp";
	else
		test = "upgradet.asp";
	document.location.replace(test);
}

function evaltF()
{
	if ( messageCheck() )
		return true;
	return false;
}

function messageCheck()
{
	var hid = document.upload;
	if(hid.binary.value.length == 0) {
		alert("Please enter a file.");
		return false;
	}else{
    	if (confirm(showText(tlupgradeConfirm)))
		{
			hid.submit();
			alert(showText(tlupgradeAlert));
		}
	}
}

function logoutF()
{
	document.upload.logout.value=1;
	document.upload.submit();
	return true;
}
</script></head>
<body class="background">
<blockquote>
<p align="center"><b><font class="titlecolor" size="4"><script>dw(firmwareUp)</script></font></b><br><br>
<div align="center">
	<table border="0" width="520" cellspacing="0" cellpadding="0" id="table1">
		<tr>
			<td><font class="textcolor" size="2"><script>dw(tlupgradeContent)</script></font></td>
		</tr>
	</table>
</div>   
<form method="post" action="goform/formUpload" enctype="multipart/form-data" name="upload">
<table border="0" cellspacing="0" cellpadding="0" width="520" align="center">
<tr>
  <td width="100%" valign="top">
 <!--<p align="center"><b><font class="textcolor" size="2">Upgrade Method</font></b>
 <font class="textcolor2" size="2"> <select name="target" onchange="checktarget()">
 <option value="0" selected="selected">WEB</option></select></font></p> -->
 <p align="center"><input type="file" size="31" maxlength="31" name="binary"></p></td>
</tr>
</table>
<br>
<br>
 <table width="520" border="0" cellspacing="0" cellpadding="0" align="center">
 <tr>
 <td align="right">
		<script>buffer='<input type=submit value="'+showText(apply1)+'" onclick="return evaltF();" style ="width:100px">';document.write(buffer);</script>
		<script>buffer='<input type=button value="'+showText(cancel1)+'" style ="width:100px" onClick="document.upload.reset();">';document.write(buffer);</script>
		<input type="hidden" value="/tlaccept.asp" name="submit-url">
		</td>
	</tr>
 </table>
 </form>
</blockquote>
</body></html>
