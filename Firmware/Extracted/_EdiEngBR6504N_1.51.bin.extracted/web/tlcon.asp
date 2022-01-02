<html>
<head>
<link rel="stylesheet" href="set.css">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Save/Reload Setting</title>
<script type="text/javascript" src="javascript.js"></script>
<script type="text/javascript" src="file/statustool-n.var"></script>
<script>
function resetClick()
{
   if ( !confirm(showText(tlconAlert)) ) {
	return false;
  }
  else
	return true;
}
</script>
</head>
<body class="background">
<blockquote>
<p align="center"><b><font class="titlecolor" size="4"><script>dw(cfgtools)</script></font></b><br><br>
<div align="center">
	<table border="0" width="520" cellspacing="0" cellpadding="0" id="table1">
		<tr>
			<td><font class="textcolor" size="2"><script>dw(cfgtoolsDoc)</script></font></td>
		</tr>
	</table>
</div><br>
<table width="520" border="1" cellspacing=0 align="center" bgcolor="#F0F0F0">
  <form action=/goform/formSaveConfig method=POST name="saveConfig">
  <tr>
    <td width="33%" align="center"><font class="textcolor" size=2><script>dw(backup)</script>: <br></td>
    <td width="65%"><font size=2>
        <script>document.write('<input type="submit" value="'+showText(save)+'..." name="save" class="btnsize">')</script>
   </tr>
  </form>
  <form method="post" action="goform/formSaveConfig" enctype="multipart/form-data" name="saveConfig">
  <tr>
    <td width="35%" align="center"><font class="textcolor" size=2><script>dw(restore)</script>: <br></td>
    <td width="65%"><font size=2><input type="file" name="binary" size=24>
          <script>document.write('<input type="submit" value="'+showText(upload)+'" name="load" class="btnsize">')</script></td>
  </tr>
  <tr>  
    <td width="35%" align="center"><font class="textcolor"size=2 ><script>dw(rstFactory)</script>: <br></td>
    <td width="65%"><font size=2><script>document.write('<input type="submit" value="'+showText(reset)+'" name="reset" onclick="return resetClick()" class="btnsize">')</script></td>
  </form>
  </tr>
</table>

</blockquote>
</body>
</html>
