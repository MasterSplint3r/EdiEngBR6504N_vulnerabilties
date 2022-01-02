<html>
<head>
<link rel="stylesheet" href="set.css">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>USB Mass Storage</title>
<script type="text/javascript" src="javascript.js"></script>
<script type="text/javascript" src="file/miscellaneous-n.var"></script>
<script>
function resetClick()
{
   if ( !confirm(showText(contoolConfirm)) ) {
	return false;
  }
  else
	return true;
}
</script>
</head>
<body class="background">
<blockquote>
<p align="center"><b><font class="titlecolor" size="4"><script>dw(usbMass)</script></font></b>
<p align="center"><font class="textcolor" size="2"><script>dw(tlstorageContent)</script><br></font></p>
<ul>
<table width="520" border="0" cellspacing=0 cellpadding="0" align="center">
  <form action=/goform/formUSBStorage method=POST name="Mount">
  <tr>
    <td width="100%"><font size=2><center>
        <script>document.write('<input type="submit" value=" '+showText(ok)+' " name="OK" class="btnsize">')</script></center>
   </tr>
  </form>
</table>
<ul>
</blockquote>
</body>
</html>
