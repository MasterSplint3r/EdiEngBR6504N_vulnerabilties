<html>
<head>
<link rel="stylesheet" href="set.css">
<meta http-equiv="Content-Type" content="text/html; charset =utf-8">
<title>Wireless Encryption Setup</title>
<script language ='javascript' src ='javascript.js'></script>
<script language ='javascript' src ='file/fwwl-n.var'></script>
<script language="JavaScript" src="file/function.js"></script>
<SCRIPT>
<% write("apMode = "+getIndex("apMode")+";");%>
<% write("methodVal = "+getIndex("encrypt")+";");%>
<% write("opMode = "+getIndex("opMode")+";");%>

function wlValidateKey(idx, str, len)
{
  if (document.wlEncrypt.defaultTxKeyId.selectedIndex==idx && str.length==0) {
	alert(showText(wlencryptAlertBlank));
	return 0;
  }
  if (str.length ==0)
  	return 1;

  if ( str.length != len) {
  	idx++;
	alert(showText(wlencryptStrInvKey) + idx + showText(wlencryptStrShouldBe) + len + showText(wlencryptStrChara));
	return 0;
  }

  if ( str == "*****" ||
       str == "**********" ||
       str == "*************" ||
       str == "****************" ||
       str == "**************************" ||
       str == "********************************" )
       return 1;

  if (document.wlEncrypt.format.selectedIndex==0)
       return 1;

  for (var i=0; i<str.length; i++) {
    if ( (str.charAt(i) >= '0' && str.charAt(i) <= '9') ||
			(str.charAt(i) >= 'a' && str.charAt(i) <= 'f') ||
			(str.charAt(i) >= 'A' && str.charAt(i) <= 'F') )
			continue;

	alert(showText(wlencryptAlertInvVal));
	return 0;
  }

  return 1;
}

function updateFormat()
{
  if (document.wlEncrypt.length.selectedIndex == 0) {
    document.wlEncrypt.format.options[0].text = 'ASCII (5 ' + showText(wlencryptStrCharaolitec) +'))';
    document.wlEncrypt.format.options[1].text = 'Hex (10 ' + showText(wlencryptStrCharaolitec) +')';
  }
  else if (document.wlEncrypt.length.selectedIndex == 1){
    document.wlEncrypt.format.options[0].text = 'ASCII (13 ' + showText(wlencryptStrCharaolitec) +')';
    document.wlEncrypt.format.options[1].text = 'Hex (26 ' + showText(wlencryptStrCharaolitec) +')';
  }

  <% type = getIndex("keyType");
     write("document.wlEncrypt.format.options[" + type + "].selected = \'true\';");
  %>

  setDefaultKeyValue();
}

function setDefaultKeyValue()
{
	if (document.wlEncrypt.length.selectedIndex == 0) {
		if ( document.wlEncrypt.format.selectedIndex == 0) {
			document.wlEncrypt.key1.maxLength = 5;
			document.wlEncrypt.key2.maxLength = 5;
			document.wlEncrypt.key3.maxLength = 5;
			document.wlEncrypt.key4.maxLength = 5;
			document.wlEncrypt.key1.value = "*****";
			document.wlEncrypt.key2.value = "*****";
			document.wlEncrypt.key3.value = "*****";
			document.wlEncrypt.key4.value = "*****";
		}
		else {
			document.wlEncrypt.key1.maxLength = 10;
			document.wlEncrypt.key2.maxLength = 10;
			document.wlEncrypt.key3.maxLength = 10;
			document.wlEncrypt.key4.maxLength = 10;
			document.wlEncrypt.key1.value = "**********";
			document.wlEncrypt.key2.value = "**********";
			document.wlEncrypt.key3.value = "**********";
			document.wlEncrypt.key4.value = "**********";
		}
	}
	else if (document.wlEncrypt.length.selectedIndex == 1) {
  		if ( document.wlEncrypt.format.selectedIndex == 0) {
			document.wlEncrypt.key1.maxLength = 13;
			document.wlEncrypt.key2.maxLength = 13;
			document.wlEncrypt.key3.maxLength = 13;
			document.wlEncrypt.key4.maxLength = 13;
			document.wlEncrypt.key1.value = "*************";
			document.wlEncrypt.key2.value = "*************";
			document.wlEncrypt.key3.value = "*************";
			document.wlEncrypt.key4.value = "*************";
		}
		else {
			document.wlEncrypt.key1.maxLength = 26;
			document.wlEncrypt.key2.maxLength = 26;
			document.wlEncrypt.key3.maxLength = 26;
			document.wlEncrypt.key4.maxLength = 26;
			document.wlEncrypt.key1.value = "**************************";
			document.wlEncrypt.key2.value = "**************************";
			document.wlEncrypt.key3.value = "**************************";
			document.wlEncrypt.key4.value = "**************************";
		}
	}
}

function saveChanges()
{
	var keyLen;
	var strMethod = document.wlEncrypt.method.value;
	var str = document.wlEncrypt.pskValue.value;

if ( strMethod==1) {
	if (document.wlEncrypt.length.selectedIndex == 0) {
		if ( document.wlEncrypt.format.selectedIndex == 0)
			keyLen = 5;
		else
			keyLen = 10;
	}
	else if (document.wlEncrypt.length.selectedIndex == 1) {
		if ( document.wlEncrypt.format.selectedIndex == 0)
			keyLen = 13;
		else
			keyLen = 26;
	}
	else {
		if ( document.wlEncrypt.format.selectedIndex == 0)
			keyLen = 16;
		else
			keyLen = 32;
	}

	if (wlValidateKey(0,document.wlEncrypt.key1.value, keyLen)==0) {
		document.wlEncrypt.key1.focus();
		return false;
	}
	if (wlValidateKey(1,document.wlEncrypt.key2.value, keyLen)==0) {
		document.wlEncrypt.key2.focus();
		return false;
	}
	if (wlValidateKey(2,document.wlEncrypt.key3.value, keyLen)==0) {
		document.wlEncrypt.key3.focus();
		return false;
	}
	if (wlValidateKey(3,document.wlEncrypt.key4.value, keyLen)==0) {
		document.wlEncrypt.key4.focus();
		return false;
	}
}
//********** radius **********
	if (strMethod==3 || ((strMethod==0 || strMethod==1) && document.wlEncrypt.enRadius.checked==true)) {
		if ( !portRule(document.wlEncrypt.radiusPort, showText(wlencryptStrSrvPort), 0, "", 1, 65535, 1))
			return false;

		if( !ipRule( document.wlEncrypt.radiusIP, showText(wlencryptStrSrvAddr), "ip", 1))
			return false;
	}
//********** psk **********
if (strMethod==2) {
	if (document.wlEncrypt.pskFormat.selectedIndex==1) {
		if (str.length != 64) {
			alert(showText(wlencryptAlertKey64));
			document.wlEncrypt.pskValue.focus();
			return false;
		}
		takedef = 0;
		if (defPskFormat == 1 && defPskLen == 64) {
			for (var i=0; i<64; i++) {
    				if ( str.charAt(i) != '*')
					break;
			}
			if (i == 64 )
				takedef = 1;
  		}
		if (takedef == 0) {
			for (var i=0; i<str.length; i++) {
    				if ( (str.charAt(i) >= '0' && str.charAt(i) <= '9') ||
					(str.charAt(i) >= 'a' && str.charAt(i) <= 'f') ||
					(str.charAt(i) >= 'A' && str.charAt(i) <= 'F') )
					continue;
				alert(showText(wlencryptAlertInvPreVal));
				document.wlEncrypt.pskValue.focus();
				return false;
  			}
		}
	}
	else {
		if (str.length < 8) {
			alert(showText(wlencryptAlertKey8));
			document.wlEncrypt.pskValue.focus();
			return false;
		}
		if (str.length > 63) {
			alert(showText(wlencryptAlertKeyX64));
			document.wlEncrypt.pskValue.focus();
			return false;
		}
	}
}
  return true;
}

function lengthClick()
{
  updateFormat();
}

function displayObj() {

	var wepTbl = new Array("none","block","none","none");
	var wpaTbl = new Array("none","none","block","block");
	var pskTbl = new Array("none","none","block","none");
	if (apMode==1 || apMode==2 || opMode==1) 
		var enRadiusTbl = new Array("none","none","none","none");
	else
		var enRadiusTbl = new Array("block","block","none","none");
	var radiusTbl = new Array("none","none","none","block");
	var inRdsTbl = new Array("none","none","block","block","none","none");

	//if (document.wlEncrypt.method.value == 0) {
		//document.wlEncrypt.enRadius.checked=false;
	//}
	
	for (i=0; i<=4; i++) {
		if (document.wlEncrypt.method.value == i) {
			document.getElementById('wepId').style.display = wepTbl[i];
			document.getElementById('wpaId').style.display = wpaTbl[i];
			document.getElementById('pskId').style.display = pskTbl[i];
			document.getElementById('inRdsId').style.display = "none";
			document.getElementById('enRadiusId').style.display = enRadiusTbl[i];
			if (document.getElementById('enRadiusId').style.display=="block" && document.wlEncrypt.enRadius.checked==true) {
				document.getElementById('radiusId').style.display="block";
			}
			else {
				document.getElementById('radiusId').style.display = radiusTbl[i];
			}
/*			if (apMachType==1 || apMachType==2)
	    	    document.getElementById('inRdsId').style.display = inRdsTbl[i];
			else
    		    document.getElementById('inRdsId').style.display = "none";
*/
		}
	}

	lengthClick();
}
</SCRIPT>
</head>
<body class="background">
<blockquote>
<p align="center"><b><font class="titlecolor" size="4"><script>dw(wlSecureSet)</script></font></b></p>
<table width="520" border="0" cellspacing="0" cellpadding="0" align="center"><tr><td>
<p align="left"><font class="textcolor" size="2"><script>dw(wlScrInfo)</script>
</font></p></td></tr></table><br>

<form action=/goform/formWlEncrypt method=POST name="wlEncrypt">
<input type="hidden" name="wepEnabled" value="ON">

<table width="520" border="1" cellspacing="0" cellpadding="0" align="center">
	<tr class="table2"><td width="35%"><font size="2"><script>dw(encryption)</script> :&nbsp;</font></td>
	<td width="65%" align="left"><font size="2">&nbsp;<select size="1" name="method" onChange="displayObj();">
	<script>
	var modeTbl = new Array("Disable","WEP","WPA pre-shared key","WPA RADIUS");
	for ( i=0; i<4; i++) {
		if ( i == methodVal) {
			if (apMode==1 || apMode==2 || opMode==1) {
				if (i!=3)
					document.write('<option selected value="'+i+'">'+modeTbl[i]+'</option>');
			}
			else
				document.write('<option selected value="'+i+'">'+modeTbl[i]+'</option>');
		}
		else {
			if (apMode==1 || apMode==2 || opMode==1) {
				if (i!=3)
					document.write('<option value="'+i+'">'+modeTbl[i]+'</option>');
			}
			else
				document.write('<option value="'+i+'">'+modeTbl[i]+'</option>');
		}
	}
	</script></select></font></td></tr>
</table>

<span id="wepId">
<table width="520" border="1" cellspacing="0" cellpadding="0" align="center">
	<tr class="table2"><td width="35%"><font size=2><script>dw(keyLen)</script> :&nbsp;</td>
	<td width="65%" align="left"><font size=2>&nbsp;<select size="1" name="length" ONCHANGE=lengthClick()>
	<option value=1 <% if ( getIndex("wep") != 2) write("selected"); %>>64-bit</option>
	<option value=2 <% if ( getIndex("wep") == 2) write("selected"); %>>128-bit</option>
	</select></td></tr>
</table>


<table width="520" border="1" cellspacing="0" cellpadding="0" align="center">
	<tr class="table2"><td width="35%"><font size=2><script>dw(keyFrm)</script> :&nbsp;</td>
	<td width="65%" align="left"><font size=2>&nbsp;<select size="1" name="format" ONCHANGE=setDefaultKeyValue()>
	<option value=1>ASCII</option>
	<option value=2>Hex</option>
	</select></td></tr>
</table>


<table width="520" border="1" cellspacing="0" cellpadding="0" align="center">
	<tr class="table2"><td width="35%"><font size=2><script>dw(keyTx)</script> :&nbsp;</td>
	<td width="65%" align="left">&nbsp;<select size="1" name="defaultTxKeyId">
	<option <% choice = getIndex("defaultKeyId"); if (choice == 1) write("selected"); %> value="1"><script>dw(keyolitec)</script> 1</option>
	<option <% choice = getIndex("defaultKeyId"); if (choice == 2) write("selected"); %> value="2"><script>dw(keyolitec)</script> 2</option>
	<option <% choice = getIndex("defaultKeyId"); if (choice == 3) write("selected"); %> value="3"><script>dw(keyolitec)</script> 3</option>
	<option <% choice = getIndex("defaultKeyId"); if (choice == 4) write("selected"); %> value="4"><script>dw(keyolitec)</script> 4</option>
	</select></td></tr>
</table>


<table width="520" border="1" cellspacing="0" cellpadding="0" align="center">
	<tr class="table2"><td width="35%"><font size=2><script>dw(keyEncry)</script> 1 :&nbsp;</td>
	<td width="65%" align="left"><font size=2>&nbsp;<input type="text" name="key1" size="32" maxlength="32"></td></tr>
</table>


<table width="520" border="1" cellspacing="0" cellpadding="0" align="center">
	<tr class="table2"><td width="35%"><font size=2><script>dw(keyEncry)</script> 2 :&nbsp;</td>
	<td width="65%" align="left"><font size=2>&nbsp;<input type="text" name="key2" size="32" maxlength="32"></td></tr>
</table>


<table width="520" border="1" cellspacing="0" cellpadding="0" align="center">
	<tr class="table2"><td width="35%"><font size=2><script>dw(keyEncry)</script> 3 :&nbsp;</td>
	<td width="65%" align="left"><font size=2>&nbsp;<input type="text" name="key3" size="32" maxlength="32"></td></tr>
</table>


<table width="520" border="1" cellspacing="0" cellpadding="0" align="center">
	<tr class="table2"><td width="35%"><font size=2><script>dw(keyEncry)</script> 4 :&nbsp;</td>
	<td width="65%" align="left"><font size=2>&nbsp;<input type="text" name="key4" size="32" maxlength="32"></td></tr>
</table>
</span>

<span id="wpaId" style="display:none">
<table width="520" border="1" cellspacing="0" cellpadding="0" align="center">
<tr class="table2">
	<td width="35%"><font size="2"><script>dw(wlCtrlWAP)</script> :&nbsp;</font></td>
	<td width="65%" align="left"><font size=2>&nbsp;
		<input type="radio" value="1" name="wpaCipher"<% if (getIndex("wpaCipher")==1) write("checked"); %>>WPA(TKIP)&nbsp;&nbsp;
		<input type="radio" name="wpaCipher" value="2"<% if (getIndex("wpaCipher")==2) write("checked"); %>>WPA2(AES)&nbsp;&nbsp;
	<script>
	if (apMode==0 || apMode==5 || apMode==6) {
		document.write('<input type="radio" name="wpaCipher" value="3"<% if (getIndex("wpaCipher")==3) write("checked"); %>>WPA2 Mixed');
	}
	</script>
</td></tr>
</table>
</span>

<span id="pskId">
<table width="520" border="1" cellspacing="0" cellpadding="0" align="center">
	<tr class="table2"><td width="35%"><font size="2"><script>dw(keyFrmPre)</script> :&nbsp;</font></td>
	<td width="65%" align="left"><font size="2">&nbsp;<select size="1" name="pskFormat">
	<option value="0" <% if (getIndex("pskFormat")==0) write("selected");%>><script>dw(passphrase)</script></option>
	<option value="1" <% if (getIndex("pskFormat")) write("selected");%>>Hex (64 <script>dw(wlencryptStrCharaolitec)</script>)</option>
	</select></font></td></tr>
</table>


<table width="520" border="1" cellspacing="0" cellpadding="0" align="center">
	<tr class="table2"><td width="35%"><font size="2"><script>dw(keyPre)</script> :&nbsp;</font></td>
	<td width="65%" align="left"><font size="2">&nbsp;<input type="text" name="pskValue" size="32" maxlength="64" value=<% getInfo("pskValue");%>></font></td></tr>
</table>
</span>

<span id="inRdsId">
<table width="520" border="0" cellspacing="0" cellpadding="0" align="center">
<tr><td colspan="2"><font size=2 class="textcolor"><b>
   <input type="checkbox" name="sel1xMode" value="ON" <% if (getIndex("1xMode")==0) write("checked"); %>  onClick="disRADIUS();">&nbsp;&nbsp;<script>dw(wlCtrlSer)</script></b>
     </td></tr>
</table>
</span>

<span id="enRadiusId" style="display:none">
<table width="520" border="1" cellspacing="0" cellpadding="0" align="center">
<tr><td colspan="2"><font size=2 class="textcolor"><b>
   <input type="checkbox" name="enRadius" value="ON" <% if (getIndex("enable1X")==1) write("checked"); %> onClick="displayObj();">&nbsp;&nbsp;<script>dw(wlCtrlEn802)</script></b>
     </td></tr>
</table>
</span>


<span id="radiusId">
<table width="520" border="1" cellspacing="0" cellpadding="0" align="center">
	<tr class="table2"><td width="35%"><font size="2"><script>dw(wlCtrlSerIP)</script> :&nbsp;</font></td>
	<td width="65%" align="left"><font size="2">&nbsp;<input type="text" name="radiusIP" size="15"maxlength="15" value=<% getInfo("rsIp"); %>></font></td></tr>
</table>


<table width="520" border="1" cellspacing="0" cellpadding="0" align="center">
	<tr class="table2"><td width="35%"><font size="2"><script>dw(wlCtrlSerPort)</script> :&nbsp;</font></td>
	<td width="65%" align="left"><font size="2">&nbsp;<input type="text" name="radiusPort" size="5" maxlength="5" value=<% getInfo("rsPort"); %>></td></tr>
</table>


<table width="520" border="1" cellspacing="0" cellpadding="0" align="center">
	<tr class="table2"><td width="35%"><font size="2"><script>dw(wlCtrlSerPass)</script> :&nbsp;</font></td>
	<td width="65%" align="left"><font size="2">&nbsp;<input type="password" name="radiusPass" size="20" maxlength="31" value=<% getInfo("rsPassword"); %>></td></tr>
</table>
</span><br>


<table width="520" border="0" cellspacing="0" cellpadding="0" align="center">
	<tr><td align="right">
		<script>buffer='<input type=submit value="'+showText(apply1)+'" onclick="return saveChanges()" style ="width:100px">';document.write(buffer);</script>
		<input type="hidden" value="/wlencrypt.asp" name="submit-url">
 		<script>buffer='<input type=button value="'+showText(cancel1)+'" style ="width:100px" onClick="document.wlEncrypt.reset();">';document.write(buffer);</script>
	</td></tr>
</table>
<script>
updateFormat();
displayObj();
</script>
</form>
</blockquote>
</body>
</html>