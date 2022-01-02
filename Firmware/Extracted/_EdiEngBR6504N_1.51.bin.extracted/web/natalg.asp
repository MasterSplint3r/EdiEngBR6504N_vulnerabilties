<html>
<head>
<link rel="stylesheet" href="set.css">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Application Layer Gateway</title>

<!--  Call the multiple languages text and the JavaScript document.  -->
    <script type="text/javascript" src="javascript.js"></script>
    <script type="text/javascript" src="file/qosnat-n.var"></script>

<script>
var ALGArray = new Array("Amanda","Egg","FTP","H323","IRC","MMS","Quake3","Talk","TFTP","IPsec","Starcraft","MSN");
//,"PPTP Pass Through");
var ALGComArray = new Array(
	natALGComArrayAmanda,
	natALGComArrayEgg,
	natALGComArrayFTP,
	natALGComArrayH323,
	natALGComArrayIRC,
	natALGComArrayMMS,
	natALGComArrayQuake3,
	natALGComArrayTalk,
	natALGComArrayTFTP,
	natALGComArrayIPsec,
	natALGComArrayStarcraft,
	natALGComArrayMSN);
	//"Support for PPTP Pass Through.");
function saveChanges() {
var longVal=0;
if (document.ALG.Index0.checked==true)	longVal |= 0x001;
if (document.ALG.Index1.checked==true)	longVal |= 0x002;
if (document.ALG.Index2.checked==true)	longVal |= 0x004;
if (document.ALG.Index3.checked==true)	longVal |= 0x008;
if (document.ALG.Index4.checked==true)	longVal |= 0x010;
if (document.ALG.Index5.checked==true)	longVal |= 0x020;
if (document.ALG.Index6.checked==true)	longVal |= 0x040;
if (document.ALG.Index7.checked==true)	longVal |= 0x080;
if (document.ALG.Index8.checked==true)	longVal |= 0x100;
if (document.ALG.Index9.checked==true)	longVal |= 0x200;
if (document.ALG.Index10.checked==true)	longVal |= 0x400;
if (document.ALG.Index11.checked==true)	longVal |= 0x800;
document.ALG.appLyGatewayValue.value=longVal;
  return true;
}	
</script>
</head>

<body class="background">
<blockquote>
	<table border="0" width="520"  align="center">
		<tr>
			<td>
  <p align="center"><b><font class="titlecolor" size="4"><script>dw(natAlg)</script></font></b></p>

<p><font class="textcolor" size="2"><script>dw(natAlgInfo)</script></font></p>
			</td>
		</tr>
	</table>
	<br>
<form action=/goform/formALGSetup method=POST name="ALG">
  <div align="center">
  <table border=1 width="520" cellspacing=0 cellpadding=0 align="center">
      <input type="hidden" value="<% getInfo("appLayerGateway"); %>" name="appLyGatewayValue">
      <tr class="stable">
        <td width="6%"><font size=2><script>dw(enable)</script></font></td>
        <td width="24%"><font size=2><script>dw(name)</script></font></td>
        <td width="70%"><font size=2><script>dw(comment)</script></font></td>
      </tr>
<script>
var val=0x001;
for(i=0;i<12;i++){
	document.write("<tr class=table2 align=center>");
	if (document.ALG.appLyGatewayValue.value & val) 
		document.write("<td><input type=\"checkbox\" name=\"Index"+i+"\" checked></td>");
	else
		document.write("<td><input type=\"checkbox\" name=\"Index"+i+"\"></td>");
	document.write("<td><font size=2>" + ALGArray[i] + "</font></td>");
	document.write("<td align=left><font size=2>&nbsp;" + showText(ALGComArray[i]) + "</font></td></tr>");
	val *=2;
}
</script>
  </table></div>
	<br>

  <table width="520" border="0" cellspacing="0" cellpadding="0"  align="center">
    <tr>
      <td align="right">
<script>buffer='<input type=submit value="'+showText(apply1)+'" name="B1" style ="width:100px" onclick="return saveChanges()">';document.write(buffer);</script>
        <input type=hidden value="/natalg.asp" name="wlan-url">
<script>buffer='<input type=button value="'+showText(cancel1)+'" style ="width:100px" onClick="document.ALG.reset();">';document.write(buffer);</script>
      </td>
    </tr>
  </table>
</form>
</blockquote>
</body>
</html>