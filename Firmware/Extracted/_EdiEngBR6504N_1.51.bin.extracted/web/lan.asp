<html>
<head>
<link rel="stylesheet" href="set.css">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>LAN Interface Setup </title>
<script type="text/javascript" src="javascript.js"></script>
<script type="text/javascript" src="file/netsys-n.var"></script>
<script language="JavaScript" src="file/function.js"></script>
<% language=javascript %>
<SCRIPT>
<%  write("lanipChanged = "+getIndex("lanipChanged"));%>

function checkValue(str)
{
   for (var i=0; i<str.length; i++) {
    if ( (str.charAt(i) >= '0' && str.charAt(i) <= '9') || 
		 (str.charAt(i) >= 'A' && str.charAt(i) <= 'Z') ||
		 (str.charAt(i) >= 'a' && str.charAt(i) <= 'z') ||
		 (str.charAt(i) == '_')|| (str.charAt(i) == '-')||
		 (str.charAt(i) == '.'))
			continue;
	return 0;
  }
  return 1;
}
var timeValue = new Array("1800","3600","7200","43200","86400","172800","604800","1209600","946080000");
var timeName = new Array(showText(halfh),showText(oneh),showText(twohs),showText(halfd),showText(oned),showText(twods),showText(onewk),showText(twowks),showText(forever));
var initialDhcp;

function dhcpChange(index)
{
   if ( index == 1 ) {
   	  document.tcpip.dhcpRangeStart.disabled = false;
   	  document.tcpip.dhcpRangeEnd.disabled = false;
   	  document.tcpip.DomainName.disabled = false;
   	  document.tcpip.leaseTime.disabled = false;
  }
  else {
	  document.tcpip.dhcpRangeStart.disabled = true;
	  document.tcpip.dhcpRangeEnd.disabled = true;
   	  document.tcpip.DomainName.disabled = true;
   	  document.tcpip.leaseTime.disabled = true;
  }
}

function resetClick()
{
   dhcpChange( initialDhcp );
   document.tcpip.reset;
}

function checkClientRange(start,end)
{
  start_d = getDigit(start,4);
  start_d += getDigit(start,3)*256;
  start_d += getDigit(start,2)*256;
  start_d += getDigit(start,1)*256;

  end_d = getDigit(end,4);
  end_d += getDigit(end,3)*256;
  end_d += getDigit(end,2)*256;
  end_d += getDigit(end,1)*256;

  if ( start_d < end_d )
	return true;

  return false;
}

function saveChanges()
{
strIp = document.tcpip.ip;
strMask = document.tcpip.mask;
strStartIp = document.tcpip.dhcpRangeStart;
strEndIp = document.tcpip.dhcpRangeEnd;

	if ( !ipRule( strIp, showText(ipAddr11), "ip", 1))
		return false;
	if(!maskRule(strMask, 1))
		return false;

	if ( document.tcpip.dhcp.selectedIndex == 1) {
//********** dhcp start ip **********
		if ( strStartIp.value == strIp.value) {
			alert(showText(lanAlert));
			setFocus(strStartIp);
			return false;
		}
		
		if ( !ipRule( strStartIp, showText(dhcpStart1), "ip", 1))
			return false;

		if ( !checkSubnet(strIp.value, strMask.value, strStartIp.value)) {
			alert(showText(lanAlert2));
			setFocus(strStartIp);
			return false;
		}
//********** dhcp end ip **********
		if ( !ipRule( strEndIp, showText(dhcpEnd1), "ip", 1))
			return false;
		if ( !checkSubnet(strIp.value, strMask.value, strEndIp.value)) {
			alert(showText(lanAlert3));
			setFocus(strEndIp);
			return false;
		}
        	if ( !checkClientRange(strStartIp.value, strEndIp.value) ) {
			alert(showText(lanAlert4));
			setFocus(strStartIp);
			return false;
        	}
	}
	if (checkValue(document.tcpip.DomainName.value)==0) {
		alert(showText(lanAlert5));
		setFocus(document.tcpip.DomainName);
		return false;
	}
	if (strIp.value!=strIp.defaultValue) {
		alert(showText(lanAlert6));
		document.tcpip.ipChanged.value = 1;
	}
	document.tcpip.submit();

   //return true;
}

function addClick() {
	if ( !macRule(document.formSDHCPAdd.mac,'MAC address', 0))
		return false;
	return true;
}

function disableDelButton()
{
	document.formSDHCPDel.deleteSelDhcpMac.disabled = true;
	document.formSDHCPDel.deleteAllDhcpMac.disabled = true;
}

function goToWeb() {
	if (document.formSDHCPAdd.SDHCPEnabled.checked==true)
		document.formSDHCPEnabled.SDHCPEnabled.value="ON";
	document.formSDHCPEnabled.submit();
}
</SCRIPT>
</head>

<body class="background">
<blockquote>
<p align="center"><b><font class="titlecolor" size="4"><script>dw(lanSet)</script></font></b><br><br>
<div align="center">
	<table border="0" width="520" cellspacing="0" cellpadding="0" id="table1">
		<tr>
			<td><font class="textcolor" size="2"><script>dw(lanContent)</script></font></td>
		</tr>
	</table>
</div><br>
<form action=/goform/formTcpipSetup method=POST name="tcpip">
<table border=0 align="center" width="520" cellspacing=0 cellpadding=0><tr><td>
<h5><font class="subcolor"><script>dw(lanIP)</script></font></h5></td></tr></table>
<table border=1 align="center" width="520" cellspacing=0 cellpadding=0>
<tr>
<td class="table2" width="35%"><font size=2><script>dw(IPAddr)</script>:</td>
<td class="ltable" width="65%">&nbsp;<input type="text" name="ip" size="15" maxlength="15" value=<% getInfo("ip-rom"); %>></td>
</tr>

<tr>
<td class="table2" width="35%"><font size=2><script>dw(subnetMask)</script>:</td>
<td class="ltable" width="65%">&nbsp;<input type="text" name="mask" size="15" maxlength="15" value="<% getInfo("mask-rom"); %>"></td>
</tr>

<tr>
<td class="table2" width="35%"><font size=2><script>dw(spanTree)</script>:</td>
<td class="ltable" width="65%">&nbsp;<select size="1" name="stp">
<%  choice = getIndex("stp");
  if ( choice == 0 ) {
	write( "<option selected value=\"0\"><script>dw(disabled)</script></option>" );
	write( "<option value=\"1\"><script>dw(enabled)</script></option>" );
  }
  else {
	write( "<option value=\"0\"><script>dw(disabled)</script></option>" );
	write( "<option selected value=\"1\"><script>dw(enabled)</script></option>" );
  } %>
    </select>
</td>
</tr>
<tr>
<td class="table2" width="35%"><font size=2><script>dw(DHCPServer)</script>:&nbsp;</td>
<td class="ltable" width="65%">&nbsp;<select size="1" name="dhcp" onChange="dhcpChange(document.tcpip.dhcp.selectedIndex)">
<%  choice = getIndex("dhcp");
  if ( choice == 0 ) {
	write( "<option selected value=\"0\"><script>dw(disabled)</script></option>" );
		write( "<option value=\"2\"><script>dw(enabled)</script></option>" );
  }
  if ( choice == 2 ) {
	write( "<option value=\"0\"><script>dw(disabled)</script></option>" );
		write( "<option selected value=\"2\"><script>dw(enabled)</script></option>" );
  }  %>
   </select>
</td>
</tr>
</table>
<input type="hidden" name="leaseTimeGet" value="<% getInfo("leaseTime"); %>">
</br>
<table border=1 align="center" width="520" cellspacing="0" cellpadding="0">
<tr>
<td class="table2" width="35%"><font size=2><script>dw(leaseTime)</script>:</td>
<td class="ltable" width="65%">&nbsp;<select name="leaseTime">
  <script language="javascript">
   for(i=0;i<9;i++){
	if(timeValue[i]==document.tcpip.leaseTimeGet.value)
  	document.write("<option value=\""+timeValue[i]+"\" selected>"+timeName[i]+"</option>");
	else
 	document.write("<option value=\""+timeValue[i]+"\">"+timeName[i]+"</option>");
   }
</script></select>
</td>
</tr>

</table><br>
<table border=0 align="center" width="520" cellspacing=0 cellpadding=0><tr><td>
<h5><font class="subcolor"><script>dw(DHCPServer)</script></font></h5></td></tr></table>
<table border=1 align="center" width="520" cellspacing="0" cellpadding="0">
<tr>
<td class="table2" width="35%"><font size=2><script>dw(startIP)</script>:</td>
<td class="ltable" width="65%">&nbsp;<input type="text" name="dhcpRangeStart" size="15" maxlength="15" value="<% getInfo("dhcpRangeStart"); %>"></td>
</tr>

<tr>
<td class="table2" width="35%"><font size=2><script>dw(endIP)</script>:</td>
<td class="ltable" width="65%">&nbsp;<input type="text" name="dhcpRangeEnd" size="15" maxlength="15" value="<% getInfo("dhcpRangeEnd"); %>">
</td>
</tr>

<tr>
<td class="table2" width="35%"><font size=2><script>dw(domainName)</script>:</td>
<td class="ltable" width="65%">&nbsp;<input type="text" name="DomainName" size="20" maxlength="30" value="<% getInfo("DomainName"); %>"></td>
</tr>

<SCRIPT>
dhcpChange(document.tcpip.dhcp.selectedIndex);
</SCRIPT>
</table>
<input type=hidden value="/lan.asp" name="submit-url">
<input type=hidden value="" name="ipChanged">
</form>

<form action=/goform/formSDHCP method=POST name="formSDHCPEnabled">
  <input type="hidden" value="Add" name="addSDHCPMac">
  <input type="hidden" value="" name="SDHCPEnabled">
  <input type="hidden" value="/lan.asp" name="submit-url">
</form>


<form action=/goform/formSDHCP method=POST name="formSDHCPDel">
<table border=0 align="center" width="520" cellspacing=0 cellpadding=0><tr><td>
<font class="subcolor" size="2"><b><script>dw(staticdhcp1)</script></b></font></td></tr>
<tr><td><font size=2 class="textcolor"><script>dw(staticdhcp2)</script></font></td></tr></table>
  <table width="520" border="1" cellspacing="0" cellpadding="0" align="center">
<tr class="stable">
    <td width="10%"><font size=2><b>NO.</b></td>
    <td width="45%"><font size=2><b><script>dw(macAddr)</script></b></td>
    <td width="35%"><font size=2><b><script>dw(ipAddr11)</script></b></td>
    <td width="15%"><font size=2><b><script>dw(select1)</script></b></td>
</tr>
    <% SDHCPList(); %>
  </table>
  <br>
  <p align="center">
 <script>document.write('<input type="submit" value="'+showText(deleteSelected)+'" name="deleteSelDhcpMac" onClick="return deleteClick()" class="btnsize">')</script>&nbsp;&nbsp;
 <script>document.write('<input type="submit" value="'+showText(deleteAll)+'" name="deleteAllDhcpMac" onClick="return deleteAllClick()" class="btnsize">')</script>&nbsp;&nbsp;&nbsp;
 <script>document.write('<input type="reset" value="'+showText(reset)+'" name="reset" class="btnsize">')</script>
<input type="hidden" value="/lan.asp" name="submit-url">
 <script>
         <% entryNum = getIndex("SDHCPNum");
	        if ( entryNum == 0 ) {
			write( "disableDelButton();" );
		} %>
 </script></p>
 </form>
<br>

<form action=/goform/formSDHCP method=POST name="formSDHCPAdd">

<table width="520" border="0" cellspacing="0" cellpadding="0" align="center">
<tr>
<td><font size=2 class="textcolor"><b>
   <input type="checkbox" name="SDHCPEnabled" value="ON" <% if (getIndex("SDHCPEnabled")) write("checked"); %> onclick="goToWeb()">&nbsp;&nbsp;<script>dw(enableStaticdhcp)</script></b>
</font></td></tr></table>

<table width="520" border="1" cellspacing="0" cellpadding="0" align="center">
<tr class="table2">
<td width="5%" valign="middle" align="center" class="stable"><font size="2"><script>dw(new1)</script>
<input type="hidden" name="tiny_idx" value="0"></font></td>

<td width="42%" valign="middle" align="center"><font size="1"><script>dw(macAddr)</script>:<br>
<input type="text" name="mac" size="15" maxlength="12"></font></td>

<td width="30%" valign="middle" align="center"><font size="1"><script>dw(ipAddr11)</script>:<br>
<input type="text" name="ip" size="16" maxlength="16"></font></td>
<td width="20%" valign="middle" align="center">
<script>document.write('<input type="submit" value="'+showText(add1)+'" name="addSDHCPMac" onClick="return addClick()" class="btnsize">')</script>
<script>document.write('<input type="reset" value="'+showText(clear1)+'" name="reset" class="btnsize">')</script>
<input type="hidden" value="/lan.asp" name="submit-url"></td>
</tr>
</table>
</form>
<br>
<table width="520" border="0" cellspacing="0" cellpadding="0" align="center">
<tr><td align="right">
<script>buffer='<input type=submit value="'+showText(apply1)+'" name="B1" style ="width:100px" onclick="return saveChanges()">';document.write(buffer);</script>
<script>buffer='<input type=button value="'+showText(cancel1)+'" style ="width:100px" onClick="document.tcpip.reset();resetClick();">';document.write(buffer);</script>
</td>
</tr>
</table>
</blockquote>
</body>

</html>
