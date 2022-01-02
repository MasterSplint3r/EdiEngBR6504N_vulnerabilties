<html>
<head>
<link rel="stylesheet" href="set.css">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

<!--  Call the multiple languages text and the JavaScript document.  -->
    <script type="text/javascript" src="javascript.js"></script>
    <script type="text/javascript" src="file/netsys-n.var"></script>

<title>WAN DDNS Setup </title>
<script language="JavaScript" src="file/function.js"></script>
<% language=javascript %>
<SCRIPT>
function saveChanges()
{
	if (document.ddns.ddnsEnable[1].checked==true)
		return true;
	if (document.ddns.ddnspvidSel.value!="dhis") {

		if (!strRule(document.ddns.ddnsName, showText(domainName)))
			return false;
		if (!strRule(document.ddns.ddnsAccount, showText(accoutEm)))
			return false;
		if (!strRule(document.ddns.ddnsPass,showText(ddnsPass)))
			return false;

	} else {
		if (!strRule(document.ddns.dhisHostID,showText(hostID)))
			return false;
		if ( validateKey( document.ddns.dhisHostID.value ) == 0 ) {
			alert(showText(wanddnsAlert));
			setFocus(document.ddns.dhisHostID);
			return false;
		}
		if (document.ddns.dhisISAddr.value=="") {
    		alert(showText(wanddnsAlert2));
			setFocus(document.ddns.dhisISAddr);
			return false;
		}
		if (document.ddns.dhisSelect.value == 0 ) {
			if (!strRule(document.ddns.dhispass,showText(hostPass)))
				return false;
		}

	}
   return true;
}

function DDNSEnable() {
	with(document.ddns) {
		if (ddnsEnable[0].checked==false) {
			ddnspvidSel.disabled = true;
			ddnsName.disabled = true;
			ddnsAccount.disabled = true;
			ddnsPass.disabled = true;
			dhisHostID.disabled = true;
			dhisISAddr.disabled = true;
			dhisSelect.disabled = true;
			dhispass.disabled = true;
			dhisAuthP1.disabled = true;
			dhisAuthP2.disabled = true;
			dhisAuthQ1.disabled = true;
			dhisAuthQ2.disabled = true;
		}
		else{
			ddnspvidSel.disabled = false;
			ddnsName.disabled = false;
			ddnsAccount.disabled = false;
			ddnsPass.disabled = false;
			dhisHostID.disabled = false;
			dhisISAddr.disabled = false;
			dhisSelect.disabled = false;
			dhispass.disabled = false;
			dhisAuthP1.disabled = false;
			dhisAuthP2.disabled = false;
			dhisAuthQ1.disabled = false;
			dhisAuthQ2.disabled = false;
		}
	}
}

function displayObj() {
	if (document.ddns.ddnspvidSel.value != "dhis") {
		document.getElementById('genId').style.display = "block";
		document.getElementById('dhisId').style.display = "none";
		document.getElementById('passId').style.display = "none";
		document.getElementById('authId').style.display = "none";
	}
	else {
		document.getElementById('genId').style.display = "none";
		document.getElementById('dhisId').style.display = "block";
		if (document.ddns.dhisSelect.value == 0) {
			document.getElementById('passId').style.display = "block";
			document.getElementById('authId').style.display = "none";
		}
		else {
			document.getElementById('passId').style.display = "none";
			document.getElementById('authId').style.display = "block";
		}
	}
}

</SCRIPT>
</head>

<body class="background">
<blockquote>



<table border="0" width="520"  align="center">
	<tr>
		<td>
<p align="center"><b><font class="titlecolor" size="4">
    <script>dw(DDNS)</script></font></b>
<font class="textcolor"  size="2">
   <script>dw(wanddnsContent)</script>
</font></p><br>
		
		
		</td>
	</tr>
</table>

<form action=/goform/formDDNSSetup method=POST name="ddns">
<input type="hidden" value="<% getInfo("ddnspvidSel"); %>" name="ddnspvidSelGet">




<div align="center">




<table border=1 width="520" cellspacing=0 cellpadding=0>
<tr>
	<td class="table1" width="30%"><font size=2><script>dw(DynamicDNS)</script>:&nbsp;</td>
	<td class="table2" width="70%"><font size=2>
	<p style="text-align: left">&nbsp;
	<input type="radio" name="ddnsEnable"onClick="DDNSEnable();" value="1" <% if (getIndex("ddnsEnable")==1) write("checked"); %>><script>dw(enabled)</script>
	<input type="radio" name="ddnsEnable"onClick="DDNSEnable();" value="0" <% if (getIndex("ddnsEnable")==0) write("checked"); %>><script>dw(disabled)</script></td>
</tr>
</table>



</div>
<div align="center">



<table border=1 width="520" cellspacing=0 cellpadding=0>
<tr>
	<td class="table1" width="30%"><font size=2><script>dw(provider)</script>:&nbsp;</td>
	<td class="table2" width="70%"><font size=2>
	<p style="text-align: left">&nbsp;<select name="ddnspvidSel" onChange="displayObj();">
	<script>
	var PvidTbl = new Array("qdns","dhs","dyndns","ods","tzo","gnudip","dyns","zoneedit","dhis","cybergate");
	var PvidName = new Array("3322(qdns)","DHS","DynDNS","ODS","TZO","GnuDIP","DyNS","ZoneEdit","DHIS","CyberGate");
	for (i=0;i<10;i++) {
		if(PvidTbl[i]==document.ddns.ddnspvidSelGet.value)
			document.write("<option value=\""+PvidTbl[i]+"\" selected>"+PvidName[i]+"</option>");
		else
			document.write("<option value=\""+PvidTbl[i]+"\">"+PvidName[i]+"</option>");
	}
	</script></select></td>
</tr>
</table>




</div>




<span id="genId">
<div align="center">
<table border=1 width="520" cellspacing=0 cellpadding=0>
<tr>
	<td class="table1" width="30%"><font size=2><script>dw(domainName)</script>:&nbsp;</td>
	<td class="table2" width="70%"><font size=2>
	<p style="text-align: left">&nbsp;<input type="text" name="ddnsName" size="25" maxlength="30" value="<% getInfo("ddnsName"); %>"></td>
</tr>
</table>

</div>
<div align="center">

<table border=1 width="520" cellspacing=0 cellpadding=0>
<tr>
	<td class="table1" width="30%"><font size=2><script>dw(account)</script>:&nbsp;</td>
	<td class="table2" width="70%"><font size=2>
	<p style="text-align: left">&nbsp;<input type="text" name="ddnsAccount" size="25" maxlength="30" value="<% getInfo("ddnsAccount"); %>"></td>
</tr>
</table>

</div>
<div align="center">

<table border=1 width="520" cellspacing=0 cellpadding=0>
<tr>
	<td class="table1" width="30%"><font size=2><script>dw(passKey)</script>:&nbsp;</td>
	<td class="table2" width="70%"><font size=2>
	<p style="text-align: left">&nbsp;<input type="password" name="ddnsPass" size="25" maxlength="30" value="<% getInfo("ddnsPass"); %>"></td>
</tr>
</table>
</div>
</span>



<span id="dhisId">
<div align="center">
<table border=1 width="520" cellspacing=0 cellpadding=0>
<tr>
	<td class="table1" width="30%"><font size=2><script>dw(hostID)</script>:&nbsp;</td>
	<td class="table2" width="70%"><font size=2>
	<p style="text-align: left">&nbsp;<input type="text" name="dhisHostID" size="25" maxlength="10" value="<% getInfo("dhisHostID"); %>"></td>
</tr>
</table>

</div>
<div align="center">

<table border=1 width="520" cellspacing=0 cellpadding=0>
<tr>                                              <!--ISAddr-->
	<td class="table1" width="30%"><font size=2>ISAddr :&nbsp;</td>
	<td class="table2" width="70%"><font size=2>
	<p style="text-align: left">&nbsp;<input type="text" name="dhisISAddr" size="25" maxlength="30" value="<% getInfo("dhisISAddr"); %>"></td>
</tr>
</table>

</div>
<div align="center">

<table border=1 width="520" cellspacing=0 cellpadding=0>
<tr>
	<td class="table1" width="30%"><font size=2><script>dw(authenType)</script>:&nbsp;</td>
	<td class="table2" width="70%"><font size=2>
	<p style="text-align: left">&nbsp;<select name="dhisSelect" onClick="displayObj();">
	<script>
	<%	write("dhisSelectGet = "+getIndex("dhisSelect")+";");%>
	var authTypeTbl = new Array("password","QRC");
	for (i=0;i<2;i++) {
		if(dhisSelectGet == i)
			document.write("<option value=\""+i+"\" selected>"+authTypeTbl[i]+"</option>");
		else
			document.write("<option value=\""+i+"\">"+authTypeTbl[i]+"</option>");
	}
	</script></select></td>
</tr>
</table>
</div>
</span>	


<span id="passId">	
<div align="center">
<table border=1 width="520" cellspacing=0 cellpadding=0>
<tr>
	<td class="table1" width="30%"><font size=2><script>dw(hostPass)</script>:&nbsp;</td>
	<td class="table2" width="70%"><font size=2>
	<p style="text-align: left">&nbsp;<input type="password" name="dhispass" size="25" maxlength="30" value="<% getInfo("dhispass"); %>"></td>
</tr>
</table>
</div>
</span>
	
<span id="authId">	
<div align="center">
<table border=1 width="520" cellspacing=0 cellpadding=0>
		<tr>
		<td class="table1" width="30%"><font size=2>AuthP :&nbsp;</td>
		<td class="table2" width="70%"><font size=2>
		<p style="text-align: left">&nbsp;<input type="text" name="dhisAuthP1" size="25" maxlength="50" value="<% getInfo("dhisAuthP1"); %>"></td></tr>
</table>

</div>
<div align="center">

<table border=1 width="520" cellspacing=0 cellpadding=0>
<tr>
	<td class="table1" width="30%"><font size=2>AuthP :&nbsp;</td>
	<td class="table2" width="70%"><font size=2>
	<p style="text-align: left">&nbsp;<input type="text" name="dhisAuthP2" size="25" maxlength="50" value="<% getInfo("dhisAuthP2"); %>"></td>
</tr>
</table>

</div>
<div align="center">

<table border=1 width="520" cellspacing=0 cellpadding=0>
<tr>
	<td class="table1" width="30%"><font size=2>AuthQ :&nbsp;</td>
	<td class="table2" width="70%"><font size=2>
	<p style="text-align: left">&nbsp;<input type="text" name="dhisAuthQ1" size="25" maxlength="50" value="<% getInfo("dhisAuthQ1"); %>"></td>
</tr>
</table>

</div>
<div align="center">

<table border=1 width="520" cellspacing=0 cellpadding=0>
<tr>
	<td class="table1" width="30%"><font size=2>AuthQ :&nbsp;</td>
	<td class="table2" width="70%"><font size=2>
	<p style="text-align: left">&nbsp;<input type="text" name="dhisAuthQ2" size="25" maxlength="50" value="<% getInfo("dhisAuthQ2"); %>"></td>
</tr>
</table>
</div>
</span>

<script>
	DDNSEnable();
	displayObj();
</script>
 </table>

<br>
<table width="520" border="0" cellspacing="0" cellpadding="0" align="center">
<tr><td align="right">
	<script>buffer='<input type=submit value="'+showText(apply1)+'" name="save" onclick="return saveChanges();" style ="width:100px">';document.write(buffer);</script>
	<input type="hidden" value="/wanddns.asp" name="submit-url">
	<script>buffer='<input type=button value="'+showText(cancel1)+'" style ="width:100px" onClick="document.ddns.reset();">';document.write(buffer);</script>
</td>
</tr>
</table>
</form>
</blockquote>
</body>
</html>