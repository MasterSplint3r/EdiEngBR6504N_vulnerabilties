<html><head><title>Wireless Setting</title>
<link rel="stylesheet" href="set.css">
<meta http-equiv="content-type" content="text/html; charset=utf-8">
<script type="text/javascript" src="javascript.js"></script>
<script type="text/javascript" src="file/qosnat-n.var"></script>
<script language="JavaScript">
function checkmode()
{
	var test = document.formWep.urllist.options[document.formWep.urllist.selectedIndex].value;
//	var test1 = "/cgi-bin/apcgi.cgi?hidden=" + test;
	document.location.replace(test);
}

</script></head>
<body class="background">
<blockquote>
<form action=/goform/formUPNPSetup method=POST name="formWep">
<p align="center"><b><font class="titlecolor" size="4"><script>dw(natUPnP)</script></font></b></p>
<div align="center">
	<table border="0" width="540" cellspacing="0" cellpadding="0" id="table1">
		<tr>
			<td><font class="textcolor" size="2"><script>dw(natUPnPInfo)</script></font></td>
		</tr>
	</table>
</div><br>
<table width="540" border="0" cellspacing="0" cellpadding="0" align="center">
  <tbody><tr>
    <td valign="top">
      <table width="540" border="1" cellspacing="0" cellpadding="0" align="center">
        <tbody><tr>
       	  <td rowspan="5" valign="top" class="table2" nowrap="nowrap">
	    <font size="2"><script>dw(natUpnpFeature)</script> :</font>
	  </td>
	  <td nowrap="niowrap" bgcolor="#F0F0F0">
          <input type=radio  value="yes" name="upnpEnable" <% if (getIndex("upnpEnable")==1) write("checked"); %>><font size="2"><script>dw(enable)</script>&nbsp;&nbsp;</font>
	  <input type=radio  value="no" name="upnpEnable" <% if (getIndex("upnpEnable")==0) write("checked"); %>><font size="2"><script>dw(disable)</script></font>
	  </td>
        </tr>
      </tbody></table>
    </td>
  </tr></tbody></table><br>
 
<table width="540" border="0" cellspacing="0" cellpadding="0" align="center">
<tr><td align="right">
	<script>buffer='<input type=submit value="'+showText(apply1)+'" style ="width:100px" onclick="return true">';document.write(buffer);</script>
	<input type="hidden" value="/natupnp.asp" name="submit-url">
	<script>buffer='<input type=button value="'+showText(cancel1)+'" style ="width:100px" onClick="document.formWep.reset();">';document.write(buffer);</script>
</td></tr>
</table>
</form>
</blockquote>
</body></html>
