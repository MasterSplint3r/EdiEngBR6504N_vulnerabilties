<html>
<head>
<link rel="stylesheet" href="set.css">
<meta http-equiv="Content-Type" content="text/html">
<title>WDS Security Setup</title>
<script type="text/javascript" src="common.js"> </script>
<script language="JavaScript" src="file/function.js"></script>
<SCRIPT>
function setWepKeyLen(form){
  if (form.elements["encrypt"].selectedIndex == 1) {
	form.format.options[0].text = 'ASCII (5 characters)';
	form.format.options[1].text = 'Hex (10 characters)';
	
	if ( form.elements["format"].selectedIndex == 0) {
		form.elements["wepKey"].maxLength = 5;
		form.elements["wepKey"].value = "*****";
	}
	else {
		form.elements["wepKey"].maxLength = 10;
		form.elements["wepKey"].value = "**********";
	}
  }
  else {
  	form.format.options[0].text = 'ASCII (13 characters)';
	form.format.options[1].text = 'Hex (26 characters)';
	
	if ( form.elements["format"].selectedIndex == 0) {
		form.elements["wepKey"].maxLength = 13;
		form.elements["wepKey"].value = "*************";
	}
	else {
		form.elements["wepKey"].maxLength = 26;
		form.elements["wepKey"].value = "**************************";
	}
  }
}

function disableWEP(form){
	form.elements["format"].disabled = true;
	form.elements["wepKey"].disabled = true;
}

function disableWPA(form){
	form.elements["pskFormat"].disabled = true;
	form.elements["pskValue"].disabled = true;
}


function enableWEP(form){
	form.elements["format"].disabled = false;
	form.elements["wepKey"].disabled = false;
}

function enableWPA(form){
	form.elements["pskFormat"].disabled = false;
	form.elements["pskValue"].disabled = false;
}

function updateEncryptState(form){
	if (form.elements["encrypt"].selectedIndex == 0) {
		disableWEP(form);
		disableWPA(form);
	}
	if (form.elements["encrypt"].selectedIndex == 1 || form.elements["encrypt"].selectedIndex == 2) {
		setWepKeyLen(document.formWdsEncrypt);
		enableWEP(form);
		disableWPA(form);
	}
	if (form.elements["encrypt"].selectedIndex == 3 || form.elements["encrypt"].selectedIndex == 4) {
		disableWEP(form);
		enableWPA(form);
	}
}

function check_wpa_psk(form)
{
	var str = form.elements["pskValue"].value;
	if (form.elements["pskFormat"].selectedIndex==1) {
		if (str.length != 64) {
			alert('Pre-Shared Key value should be 64 characters.');
			form.elements["pskValue"].focus();
			return false;
		}
		takedef = 0;
		if (defPskFormat[wlan_id] == 1 && defPskLen[wlan_id] == 64) {
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
				alert("Invalid Pre-Shared Key value. It should be in hex number (0-9 or a-f).");
				form.elements["pskValue"].focus();
				return false;
  			}
		}
	}
	else {
		if (str.length < 8) {
			alert('Pre-Shared Key value should be set at least 8 characters.');
			form.elements["pskValue"].focus();
			return false;
		}
		if (str.length > 63) {
			alert('Pre-Shared Key value should be less than 64 characters.');
			form.elements["pskValue"].focus();
			return false;
		}
	}
  return true;
}

function validateKey_wep(form, idx, str, len)
{
 if (idx >= 0) {
  if (form.elements["defaultTxKeyId"].selectedIndex==idx && str.length==0) {
	alert('The encryption key you selected as the \'Tx Default Key\' cannot be blank.');
	return 0;
  }
  if (str.length ==0)
  	return 1;

  if ( str.length != len) {
  	idx++;
	alert('Invalid length of Key ' + idx + ' value. It should be ' + len + ' characters.');
	return 0;
  }
  }
  else {
	if ( str.length != len) {
		alert('Invalid length of WEP Key value. It should be ' + len + ' characters.');
		return 0;
  	}
  }
  if ( str == "*****" ||
       str == "**********" ||
       str == "*************" ||
       str == "**************************" )
       return 1;

  if (form.elements["format"].selectedIndex==0)
       return 1;

  for (var i=0; i<str.length; i++) {
    if ( (str.charAt(i) >= '0' && str.charAt(i) <= '9') ||
			(str.charAt(i) >= 'a' && str.charAt(i) <= 'f') ||
			(str.charAt(i) >= 'A' && str.charAt(i) <= 'F') )
			continue;

	alert("Invalid key value. It should be in hex number (0-9 or a-f).");
	return 0;
  }
  return 1;
}


function saveChangesWep(form){
	var keyLen;
	if (form.elements["encrypt"].selectedIndex == 1) {
		if ( form.elements["format"].selectedIndex == 0)
		keyLen = 5;
	else
		keyLen = 10;
	}
	else {
		if ( form.elements["format"].selectedIndex == 0)
			keyLen = 13;
		else
			keyLen = 26;
	}
	if (validateKey_wep(form, -1,form.elements["wepKey"].value, keyLen)==0) {
		form.elements["wepKey"].focus();
		return false;
	}
	return true;
}

function saveChanges(form){
	if (form.elements["encrypt"].selectedIndex == 0)
		return true;
	else if (form.elements["encrypt"].selectedIndex == 1 || form.elements["encrypt"].selectedIndex == 2)
		return saveChangesWep(form);
	else
		return check_wpa_psk(form);
}
</SCRIPT>
</head>
<body class="background">
<blockquote>
<p align="center"><b><font class="titlecolor" size="4">WDS Security Settings</font></b></p>
<table width="520" border="0" cellspacing="0" cellpadding="0" align="center">
<p align="left"><font class="textcolor" size="2">
    This page allows you setup the wireless security for WDS. When enabled, you must
    make sure each WDS device has adopted the same encryption algorithm and Key.
</font></p></td></tr></table><br>

<form action=/goform/formWdsEncrypt method=POST name="formWdsEncrypt">
<table width="520" border="1" cellspacing="0" cellpadding="0" align="center">
  <tr class="table2">
      <td width="35%"><font size=2><b>Encryption :&nbsp;</b></font></td>
      <td width="65%" align="left"><font size=2><b>
      	<select size="1" name="encrypt" onChange="updateEncryptState(document.formWdsEncrypt)">
          <option <% choice = getIndex("wdsEncrypt"); if (choice == 0) write("selected"); %> value="0">None</option>
          <option <% choice = getIndex("wdsEncrypt"); if (choice == 1) write("selected"); %> value="1">WEP 64bits</option>
          <option <% choice = getIndex("wdsEncrypt"); if (choice == 2) write("selected"); %> value="2">WEP 128bits</option>
          <option <% choice = getIndex("wdsEncrypt"); if (choice == 3) write("selected"); %> value="3">WPA (TKIP)</option>
          <option <% choice = getIndex("wdsEncrypt"); if (choice == 4) write("selected"); %> value="4">WPA2 (AES)</option>
      </b></font></td>
  </tr>
  <tr class="table2">
      <td><font size=2><b>WEP Key Format :&nbsp;</b></font></td>
      <td align="left"><font size=2><select size="1" name="format" ONCHANGE=setWepKeyLen(document.formWdsEncrypt)>
     	<option <% if (getIndex("wdsWepFormat")== 0) write("selected"); %> value=0>ASCII (5 characters)</option>
	<option <% if (getIndex("wdsWepFormat")) write("selected"); %> value=1>Hex (10 characters)</option>
       </select></font></td>
  </tr>
  <tr class="table2">
      <td><font size=2><b>WEP Key :&nbsp;</b></font></td>
      <td align="left"><font size=2>
     	<input type="text" name="wepKey" size="26" maxlength="26">
      </font></td>
  </tr>
  <tr class="table2">
      <td><font size="2"><b>Pre-Shared Key Format :&nbsp;</b></font></td>
      <td align="left"><font size="2"><select size="1" name="pskFormat">
          <option value="0" <% if (getIndex("wdsPskFormat")==0) write("selected");%>>Passphrase</option>
          <option value="1" <% if (getIndex("wdsPskFormat")) write("selected");%>>Hex (64 characters)</option>
      </select></font></td>
  </tr>
  <tr class="table2">
      <td><font size="2"><b>Pre-Shared Key :&nbsp;</b></font></td>
      <td align="left"><font size="2"><input type="text" name="pskValue" size="40" maxlength="64" value=<% getInfo("wdsPskValue");%>>
      </font></td>
  </tr>
  <script>
	form = document.formWdsEncrypt ;
	updateEncryptState(document.formWdsEncrypt);
  </script>
</table><br>

<table width="520" border="0" cellspacing="0" cellpadding="0" align="center">
<tbody><tr><td>
<div align="right">
<input type="image" src="file/apply1.gif" onClick="return saveChanges(document.formWdsEncrypt)"  width="105" height="30" border="0">
<input type="hidden" value="/wlwdsenp.asp" name="submit-url">
<a href="javascript:window.location.reload()"><img src="file/cancel.gif" alt="" border="0" width="105" height="30"></a>
</div>
</td>
</tr></tbody>
</table>

</form>

</blockquote>
</body>
</html>
