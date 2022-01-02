<html><head><title></title>
<link rel="stylesheet" href="set.css">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<style>test10 {
	FONT-SIZE: 10pt; TEXT-DECORATION: none
}
A:link {
	COLOR: #ff0000; FONT-FAMILY: Arial; FONT-SIZE: 9pt; TEXT-DECORATION: none
}
A:visited {
	COLOR: #ffff00; FONT-FAMILY: Arial; FONT-SIZE: 9pt; TEXT-DECORATION: none
}
A:active {
	COLOR: #ffffff; FONT-SIZE: 9pt; TEXT-DECORATION: none
}
A:hover {
	COLOR: #FFFFFF; FONT-SIZE: 9pt; TEXT-DECORATION: none 
}
</style>
<script type="text/javascript" src="javascript.js"></script>
<script type="text/javascript" src="file/netsys-n.var"></script>
<script language="javascript">
var my_dialup=0;
var my_printer=0;
function Changes()
{
//document.wanModeset.wan.value=document.wanModeset.type[0].value;
if (document.wanModeset.type[0].checked==true) document.location.replace("wandip.asp");
if (document.wanModeset.type[1].checked==true) document.location.replace("wansip.asp");
if (document.wanModeset.type[2].checked==true) document.location.replace("wanpppoe.asp");
if (document.wanModeset.type[3].checked==true) document.location.replace("wanpptp.asp");
if (document.wanModeset.type[4].checked==true) document.location.replace("wanl2tp.asp");
if (document.wanModeset.type[5].checked==true) document.location.replace("wantelstra.asp");
//if (document.wanModeset.type[6].checked==true) document.location.replace("wanbridge.asp");
}
</script></head>
<body class="background">
<form  name="wanModeset">
<blockquote>
<table width="520" border="0" cellspacing="0" cellpadding="0" align="center">
  <tbody><tr>
    <td height="2" valign="top">
<p align="center"><font class="titlecolor" size="4"><b><script>dw(WANSettings)</script></b></font></p>
<p align="center"><font size="2" class="textcolor"><script>dw(wansetPageContent)</script></font></p>
<table border="1" width="520" cellspacing="0" cellpadding="0" height="47" align="center">
<tbody><tr>
<td width="36" height="40" valign="middle" class="table2">
<p align="left">
<input  name="type" type="radio" value="0" <% if (getIndex("wanMode")==0) write("checked"); %>></p></td>
<td width="300" height="40" valign="middle" class="table2">
<font size="2" class="textcolor" ><b><script>dw(DynamicIP)</script></b></font></td>
<td width="833" height="40" valign="middle" class="ltable">
<font size="2" class="textcolor"><script>dw(wansetPageContent2)</script></font></td>
</tr>

<tr>
<td valign="middle" height="40" width="36" class="table2">
<p align="left">
<input name="type" type="radio" value="1"  <% if (getIndex("wanMode")==1) write("checked"); %>></p></td>
<td valign="middle" height="40" width="300" class="table2">
<font size="2" class="textcolor"><b><script>dw(StaticIP)</script></b></font></td>
<td height="40" width="833" valign="middle" class="ltable">
<font size="2"class="textcolor"><script>dw(wansetPageContent3)</script></font></td>
</tr>

<tr>
<td width="36" height="40" valign="middle" class="table2">
<p align="left">
<input name="type" type="radio" value="2" <% if (getIndex("wanMode")==2) write("checked"); %>></p></td>
<td width="300" height="40" valign="middle" class="table2">
<font size="2" class="textcolor"><b><script>dw(PPPoE)</script></b></font></td>
<td width="833" height="40" valign="middle" class="ltable">
<font size="2" class="textcolor"><script>dw(wansetPageContent4)</script></font></td>
</tr>

<tr>
<td valign="middle" height="40" width="36" class="table2">
<p align="left">
<input name="type" type="radio" value="3" <% if (getIndex("wanMode")==3) write("checked"); %>></p></td>
<td valign="middle" height="40" width="300" class="table2">
<font size="2" class="textcolor"><b><script>dw(PPTP)</script></b></font></td>
<td height="40" width="833" valign="middle" class="ltable">
<font size="2" class="textcolor"><script>dw(wansetPageContent5)</script></font></td>
</tr>				

<tr>
<td width="36" height="40" valign="middle" class="table2">
<p align="left">
<input name="type" type="radio" value="6"  <% if (getIndex("wanMode")==6) write("checked"); %>></p></td>
<td width="300" height="40" valign="middle" class="table2">
<font size="2" class="textcolor"><b><script>dw(L2TP)</script></b></font></td>
<td width="833" height="40" valign="middle" class="ltable">
<font size="2" class="textcolor"><script>dw(wansetPageContent6)</script></font></td>
</tr>

<tr>
<td valign="middle" height="40" width="36" class="table2">
<p align="left">
<input name="type" type="radio" value="4" <% if (getIndex("wanMode")==4) write("checked"); %>></p></td>
<td valign="middle" height="40" width="300" class="table2">
<font size="2" class="textcolor"><b><script>dw(TelBP)</script></b></font></td>
<td height="40" width="833" valign="middle" class="ltable">
<font size="2" class="textcolor"><script>dw(wansetPageContent7)</script></font></td>
</tr>

<!--<tr>
<td width="36" height="40" valign="middle" class="table2">
<p align="left">
<input name="type" type="radio" value="5"  <% if (getIndex("wanMode")==5) write("checked"); %>></p></td>
<td width="300" height="40" valign="middle" class="table2">
<font size="2" class="textcolor"><b>Bridge</b></font></td>
<td width="833" height="40" valign="middle" class="ltable">
<font size="2" class="textcolor">Bridge packets to LAN.</font></td>
</tr>
-->
				<tr>
					<td valign="middle" align="left" colspan="3" class="stable">
						<p align="center"><script>document.write('<input type="button" value="' + showText(moreConfig) + '" onClick="Changes();" class="btnsize">')</script></p></td>
				</tr>
			</tbody></table>
    </td>
  </tr>
</tbody></table>
</blockquote>
</form></body></html>
