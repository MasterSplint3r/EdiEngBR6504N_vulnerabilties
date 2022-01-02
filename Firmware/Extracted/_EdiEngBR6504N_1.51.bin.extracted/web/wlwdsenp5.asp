<html>
<head>
<link rel="stylesheet" href="set.css">
<meta http-equiv="Content-Type" content="text/html; charset =utf-8">
<title>WDS Security Settings</title>
<script language ="javascript" src ="javascript.js"></script>
<script language ="javascript" src ="file/wireless-n.var"></script>
<script language="JavaScript" src="file/function.js"></script>
<SCRIPT>
//<% write("apMode = "+getIndex("apMode")+";");%>
apMode=5;

<% write("methodVal = "+getIndex("wdsEncrypt")+";");%>
<% write("opMode = "+getIndex("opMode")+";");%>
<% write("APSecMode = "+getIndex("secMode")+";");%>

function wlValidateKey(idx, str, len)
{
  if (document.formWdsEncrypt.defaultTxKeyId.selectedIndex==idx && str.length==0) {
	alert(showText(wlValidateKeyAlert));
	return 0;
  }
  if (str.length ==0)
  	return 1;

  if ( str.length != len) {
  	idx++;
	alert(showText(wlValidateKeyAlert2) + idx + showText(wlValidateKeyAlert3) + len + showText(wlValidateKeyAlert4));
	return 0;
  }

  if ( str == "*****" ||
       str == "**********" ||
       str == "*************" ||
       str == "****************" ||
       str == "**************************" ||
       str == "********************************" )
       return 1;

  if (document.formWdsEncrypt.format.selectedIndex==0)
       return 1;

  for (var i=0; i<str.length; i++) {
    if ( (str.charAt(i) >= '0' && str.charAt(i) <= '9') ||
			(str.charAt(i) >= 'a' && str.charAt(i) <= 'f') ||
			(str.charAt(i) >= 'A' && str.charAt(i) <= 'F') )
			continue;

	alert(showText(wlValidateKeyAlert5));
	return 0;
  }

  return 1;
}

function updateFormat()
{
  if (document.formWdsEncrypt.length.selectedIndex == 0) {
    document.formWdsEncrypt.format.options[0].text = 'ASCII (5' + showText(wlencryptStrCharaolitec) +')';
    document.formWdsEncrypt.format.options[1].text = 'Hex (10' + showText(wlencryptStrCharaolitec) +')';
  }
  else if (document.formWdsEncrypt.length.selectedIndex == 1){
    document.formWdsEncrypt.format.options[0].text = 'ASCII (13' + showText(wlencryptStrCharaolitec) +')';
    document.formWdsEncrypt.format.options[1].text = 'Hex (26' + showText(wlencryptStrCharaolitec) +')';
  }

  <% type = getIndex("keyType");
     write("document.formWdsEncrypt.format.options[" +type+ "].selected = \'true\';");
  %>

  setDefaultKeyValue();
}

function setDefaultKeyValue()
{
	if (document.formWdsEncrypt.length.selectedIndex == 0) {
		if ( document.formWdsEncrypt.format.selectedIndex == 0) {
			document.formWdsEncrypt.key1.maxLength = 5;
			document.formWdsEncrypt.key2.maxLength = 5;
			document.formWdsEncrypt.key3.maxLength = 5;
			document.formWdsEncrypt.key4.maxLength = 5;
			document.formWdsEncrypt.key1.value = "*****";
			document.formWdsEncrypt.key2.value = "*****";
			document.formWdsEncrypt.key3.value = "*****";
			document.formWdsEncrypt.key4.value = "*****";
		}
		else {
			document.formWdsEncrypt.key1.maxLength = 10;
			document.formWdsEncrypt.key2.maxLength = 10;
			document.formWdsEncrypt.key3.maxLength = 10;
			document.formWdsEncrypt.key4.maxLength = 10;
			document.formWdsEncrypt.key1.value = "**********";
			document.formWdsEncrypt.key2.value = "**********";
			document.formWdsEncrypt.key3.value = "**********";
			document.formWdsEncrypt.key4.value = "**********";
		}
	}
	else if (document.formWdsEncrypt.length.selectedIndex == 1) {
  		if ( document.formWdsEncrypt.format.selectedIndex == 0) {
			document.formWdsEncrypt.key1.maxLength = 13;
			document.formWdsEncrypt.key2.maxLength = 13;
			document.formWdsEncrypt.key3.maxLength = 13;
			document.formWdsEncrypt.key4.maxLength = 13;
			document.formWdsEncrypt.key1.value = "*************";
			document.formWdsEncrypt.key2.value = "*************";
			document.formWdsEncrypt.key3.value = "*************";
			document.formWdsEncrypt.key4.value = "*************";
		}
		else {
			document.formWdsEncrypt.key1.maxLength = 26;
			document.formWdsEncrypt.key2.maxLength = 26;
			document.formWdsEncrypt.key3.maxLength = 26;
			document.formWdsEncrypt.key4.maxLength = 26;
			document.formWdsEncrypt.key1.value = "**************************";
			document.formWdsEncrypt.key2.value = "**************************";
			document.formWdsEncrypt.key3.value = "**************************";
			document.formWdsEncrypt.key4.value = "**************************";
		}
	}
}

function saveChanges()
{
	var keyLen;
	var strMethod = document.formWdsEncrypt.method.value;
	var str = document.formWdsEncrypt.wdsPskValue.value;

if ( strMethod==1) {
	if (document.formWdsEncrypt.length.selectedIndex == 0) {
		if ( document.formWdsEncrypt.format.selectedIndex == 0)
			keyLen = 5;
		else
			keyLen = 10;
	}
	else if (document.formWdsEncrypt.length.selectedIndex == 1) {
		if ( document.formWdsEncrypt.format.selectedIndex == 0)
			keyLen = 13;
		else
			keyLen = 26;
	}
	else {
		if ( document.formWdsEncrypt.format.selectedIndex == 0)
			keyLen = 16;
		else
			keyLen = 32;
	}

	if (wlValidateKey(0,document.formWdsEncrypt.key1.value, keyLen)==0) {
		document.formWdsEncrypt.key1.focus();
		return false;
	}
	if (wlValidateKey(1,document.formWdsEncrypt.key2.value, keyLen)==0) {
		document.formWdsEncrypt.key2.focus();
		return false;
	}
	if (wlValidateKey(2,document.formWdsEncrypt.key3.value, keyLen)==0) {
		document.formWdsEncrypt.key3.focus();
		return false;
	}
	if (wlValidateKey(3,document.formWdsEncrypt.key4.value, keyLen)==0) {
		document.formWdsEncrypt.key4.focus();
		return false;
	}
}
//********** psk **********
if (strMethod==2) {
	if (document.formWdsEncrypt.wdsPskFormat.selectedIndex==1) {
		if (str.length != 64) {
			alert(showText(saveChangesAlert));
			document.formWdsEncrypt.wdsPskValue.focus();
			return false;
		}
			defPskFormat=document.formWdsEncrypt.wdsPskFormat.selectedIndex;
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
				alert(showText(saveChangesAlert2));
				document.formWdsEncrypt.wdsPskValue.focus();
				return false;
  			}
		}
	}
	else {
		if (str.length < 8) {
			alert(showText(saveChangesAlert3));
			document.formWdsEncrypt.wdsPskValue.focus();
			return false;
		}
		if (str.length > 63) {
			alert(showText(saveChangesAlert4));
			document.formWdsEncrypt.wdsPskValue.focus();
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

	
	for (i=0; i<3; i++) {
		if (document.formWdsEncrypt.method.value == i) {
			if(apMode == 5 && APSecMode == 1)
				document.getElementById('wepId').style.display = "none";
			else
				document.getElementById('wepId').style.display = wepTbl[i];
			document.getElementById('wpaId').style.display = wpaTbl[i];
    		document.getElementById('pskId').style.display = pskTbl[i];
	    }
	}

	lengthClick();
}

</SCRIPT>
</head>
<body class="background">
<blockquote>

<p align="center"><b><font class="titlecolor" size="4"><script>dw(wdsSecureSet)</script></font></b></p>
<table width="520" border="0" cellspacing="0" cellpadding="0" align="center">
<tr><td><font class="textcolor" size="2"><script>dw(wlWdsEnp)</script></font>
</td></tr></table><br>


<form action=/goform/formWdsEncrypt method=POST name="formWdsEncrypt">
<input type="hidden" name="wepEnabled" value="ON">

<table border=1 width="520" cellspacing=0 align="center">
	<tr class="table2"><td width="35%"><font size="2"><script>dw(encryption)</script> :&nbsp;</font></td>
	<td width="65%" align="left"><font size="2">&nbsp;<select size="1" name="method" onChange="displayObj();">
	<script>
	var modeTbl = new Array(showText(disabled),"WEP","WPA pre-shared key");

	if( apMode == 5 )
		methodVal = APSecMode;
	for ( i=0; i<3; i++) {
		if ( i == methodVal) {
			if (opMode==1) {
				if (i!=3)
					document.write('<option selected value="'+i+'">'+modeTbl[i]+'</option>');
			}
			else
				document.write('<option selected value="'+i+'">'+modeTbl[i]+'</option>');
		}
		else {
				if( apMode == 5 ){
					if(APSecMode == i )
						document.write('<option value="'+i+'">'+modeTbl[i]+'</option>');
					else if( i==2 && APSecMode == 3 )
						document.write('<option value="'+i+'">'+modeTbl[i]+'</option>');
				}
				else{
					document.write('<option value="'+i+'">'+modeTbl[i]+'</option>');	
				}
		}
	}
	</script></select></font></td></tr>
</table>


<span id="wepId">
<table border=1 width="520" cellspacing=0 align="center">
	<tr class="table2"><td width="35%"><font size="2"><script>dw(keyLen)</script> :&nbsp;</font></td>
	<td width="65%" align="left"><font size=2>&nbsp;<select size="1" name="length" ONCHANGE=lengthClick()>
	<option value=1 <% if ( getIndex("wep") != 2) write("selected"); %>>64-bit</option>
	<option value=2 <% if ( getIndex("wep") == 2) write("selected"); %>>128-bit</option>
	</select></td></tr>
</table>


<table border=1 width="520" cellspacing=0 align="center">
	<tr  class="table2"><td width="35%"><font size="2"><script>dw(keyFrm)</script> :&nbsp;</font></td>
	<td width="65%" align="left"><font size=2>&nbsp;<select size="1" name="format" ONCHANGE=setDefaultKeyValue()>
	<option value=1>ASCII</option>
	<option value=2>Hex</option>
	</select></td></tr>
</table>


<table border=1 width="520" cellspacing=0 align="center">
	<tr class="table2"><td width="35%"><font size="2"><script>dw(keyTx)</script> :&nbsp;</font></td>
	<td width="65%" align="left">&nbsp;<select size="1" name="defaultTxKeyId">
	<option <% choice = getIndex("defaultKeyId"); if (choice == 1) write("selected"); %> value="1"><script>dw(keyolitec)</script> 1</option>
	<option <% choice = getIndex("defaultKeyId"); if (choice == 2) write("selected"); %> value="2"><script>dw(keyolitec)</script> 2</option>
	<option <% choice = getIndex("defaultKeyId"); if (choice == 3) write("selected"); %> value="3"><script>dw(keyolitec)</script> 3</option>
	<option <% choice = getIndex("defaultKeyId"); if (choice == 4) write("selected"); %> value="4"><script>dw(keyolitec)</script> 4</option>
	</select></td></tr>
</table>


<table border=1 width="520" cellspacing=0 align="center">
	<tr class="table2"><td width="35%"><font size="2"><script>dw(keyEncry)</script> 1 :&nbsp;</font></td>
	<td width="65%" align="left"><font size=2>&nbsp;<input type="text" name="key1" size="32" maxlength="32"></td></tr>
</table>


<table border=1 width="520" cellspacing=0 align="center">
	<tr  class="table2"><td width="35%"><font size="2"><script>dw(keyEncry)</script> 2 :&nbsp;</font></td>
	<td width="65%"  align="left"><font size=2>&nbsp;<input type="text" name="key2" size="32" maxlength="32"></td></tr>
</table>


<table border=1 width="520" cellspacing=0 align="center">
	<tr class="table2"><td width="35%"><font size="2"><script>dw(keyEncry)</script> 3 :&nbsp;</font></td>
	<td width="65%" align="left"><font size=2>&nbsp;<input type="text" name="key3" size="32" maxlength="32"></td></tr>
</table>


<table border=1 width="520" cellspacing=0 align="center">
	<tr class="table2"><td width="35%"><font size="2"><script>dw(keyEncry)</script> 4 :&nbsp;</font></td>
	<td width="65%" align="left"><font size=2>&nbsp;<input type="text" name="key4" size="32" maxlength="32"></td></tr>
</table>
</span>

<span id="wpaId" style="display:none">
<table border=1 width="520" cellspacing=0 align="center">
<tr class="table2"><td width="35%"><font size="2"><script>dw(wlCtrlWAP)</script> :&nbsp;</font></td>
	<td width="65%" align="left"><font size=2>&nbsp;<input type="radio" value="1" name="wdsWpaCipher"<% if (getIndex("wdsWpaCipher")==1) write("checked"); %>>WPA(TKIP)&nbsp;&nbsp;
	<input type="radio" name="wdsWpaCipher" value="2"<% if (getIndex("wdsWpaCipher")==2) write("checked"); %>>WPA2(AES)&nbsp;&nbsp;
</td></tr>
</table>
</span>

<span id="pskId">
<table border=1 width="520" cellspacing=0 align="center">
	<tr class="table2"><td width="35%"><font size="2"><script>dw(keyFrmPre)</script> :&nbsp;</font></td>
	<td width="65%" align="left"><font size="2">&nbsp;<select size="1" name="wdsPskFormat">
	<option value="0" <% if (getIndex("wdsPskFormat")==0) write("selected");%>>Passphrase</option>
	<option value="1" <% if (getIndex("wdsPskFormat")) write("selected");%>>Hex (64 <script>dw(wlencryptStrCharaolitec)</script>)</option>
	</select></font></td></tr>
</table>


<table border=1 width="520" cellspacing=0 align="center">
	<tr class="table2"><td width="35%"><font size="2"><script>dw(keyPre)</script> :&nbsp;</font></td>
	<td width="65%" align="left"><font size="2">&nbsp;<input type="text" name="wdsPskValue" size="32" maxlength="64" value=<% getInfo("wdsPskValue");%>></font></td></tr>
</table>
</span>
<br>

<table width="520" border="0" cellspacing="0" cellpadding="0" align="center">
	<tr><td align="right">
	<script>document.write('<input type="submit" value="'+showText(applys)+'" onClick="return saveChanges()" style ="width:100px">')</script>
	<input type="hidden" value="/wlwdsenp5.asp" name="submit-url">
	<script>document.write('<input type="reset" Value="'+showText(reset)+'" onclick="window.location.reload()"style ="width:100px">')</script>
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
