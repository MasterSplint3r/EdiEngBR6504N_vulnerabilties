<html>
<head>
<link rel="stylesheet" href="set.css">
<meta http-equiv="Content-Type" content="text/html">
<title>Wireless Encryption Setup</title>
<script language="JavaScript" src="file/function.js"></script>
<SCRIPT>
var oldEapVal=0;
function openWindow(url, windowName) {
	var wide=660;
	var high=420;
	if (document.all)
		var xMax = screen.width, yMax = screen.height;
	else if (document.layers)
		var xMax = window.outerWidth, yMax = window.outerHeight;
	else
	   var xMax = 640, yMax=500;
	var xOffset = (xMax - wide)/2;
	var yOffset = (yMax - high)/3;

	var settings = 'width='+wide+',height='+high+',screenX='+xOffset+',screenY='+yOffset+',top='+yOffset+',left='+xOffset+', resizable=yes, toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes';

	window.open( url, windowName, settings );
}

function showMacClick(url) {
	openWindow(url, 'showCert' );
}

function wlValidateKey(idx, str, len)
{
  if (document.wlEncrypt.defaultTxKeyId.selectedIndex==idx && str.length==0) {
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

	alert("Invalid key value. It should be in hex number (0-9 or a-f).");
	return 0;
  }

  return 1;
}

function secCltCer() {
	document.wlEncrypt.cltload.value="Edit";
}

function secSerCer() {
	document.wlEncrypt.serload.value="Edit";
}

function updateFormat()
{
  if (document.wlEncrypt.length.selectedIndex == 0) {
    document.wlEncrypt.format.options[0].text = 'ASCII (5 characters)';
    document.wlEncrypt.format.options[1].text = 'Hex (10 characters)';
  }
  else if (document.wlEncrypt.length.selectedIndex == 1){
    document.wlEncrypt.format.options[0].text = 'ASCII (13 characters)';
    document.wlEncrypt.format.options[1].text = 'Hex (26 characters)';
  }
  else {
    document.wlEncrypt.format.options[0].text = 'ASCII (16 characters)';
    document.wlEncrypt.format.options[1].text = 'Hex (32 characters)';
  }

  <% type = getIndex("staKeyType");
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
	var str = document.wlEncrypt.psk.value;

	if ( (strMethod==0 && document.wlEncrypt.wepTp.value==1) || strMethod==1) {
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
//********** psk **********
	if (strMethod==2) {
		if (str.length < 8) {
			alert('Pre-Shared Key value should be set at least 8 characters.');
			document.wlEncrypt.psk.focus();
			return false;
		}
		if (str.length > 63) {
			alert('Pre-shared key value should be less than 64 characters.');
			document.wlEncrypt.psk.focus();
			return false;
		}
	}
//********** radius **********
	if ( ((document.wlEncrypt.enRadius.checked==true)
		&& (document.getElementById('radiusId').style.display=="block"))
		||(document.wlEncrypt.method.value==3)) {
	
		if (document.wlEncrypt.identity.value=="") {
			alert('Identity cannot be empty!');
			setFocus(document.wlEncrypt.identity);
			return false;
		}
		if (document.wlEncrypt.eapType.value==0 || document.wlEncrypt.eapType.value==2) {
			if (document.wlEncrypt.eapId.value=="") {
				alert('Tunnel ID cannot be empty!');
				setFocus(document.wlEncrypt.eapId);
				return false;
			}
			if (document.wlEncrypt.eapPass.value=="") {
				alert('Tunnel Password cannot be empty!');
				setFocus(document.wlEncrypt.eapPass);
				return false;
			}
		} 
		if (document.wlEncrypt.eapType.value==3) {
			if (document.wlEncrypt.md5Pass.value=="") {
				alert('Password cannot be empty!');
				setFocus(document.wlEncrypt.md5Pass);
				return false;
			}
		}
//********** certificate **********
		if (document.wlEncrypt.eapType==1 || document.wlEncrypt.enCltCer.checked==true) {
			if (document.wlEncrypt.cltPass.value=="") {
				alert('client certificate password cannot be empty!');
				setFocus(document.wlEncrypt.cltPass);
				return false;
			}
		}
	}

	return true;
}



function lengthClick() {
	updateFormat();
}


function addEap(type){
	if ((oldEapVal==type) || (document.wlEncrypt.eapType.value==3 && document.wlEncrypt.method.value!=3))
		return;
	if (type==3)
		document.wlEncrypt.eapType.options[3] = null;
	else
		document.wlEncrypt.eapType.options[3] = new Option("MD5-Challenge",3);
	oldEapVal=type;
}



function displayObj(checkVal) {
	var showWepTp = new Array("block","none","none","none");
	var showWpaTp = new Array("none","none","block","block");
	var showWep = new Array("block","block","none","none");
	var showPsk = new Array("none","none","block","none");
	var showRadius = new Array("block","block","none","none");

	var showPeap = new Array("block","none","none","none");
	var showTtls = new Array("none","none","block","none");
	var showPass = new Array("block","none","block","none");


	if ((apMode == 2) && (document.wlEncrypt.staSsidVal.value=="any") && (checkVal==1)) {
		alert('The security settings is not enabled when the SSID is "any".');
		document.wlEncrypt.method.value=0;
		document.wlEncrypt.wepTp.value=0;
		document.wlEncrypt.enRadius.checked=false;
		return false;
	}

	addEap(document.wlEncrypt.method.value);
	for (i=0; i<=3; i++) {
	    if (document.wlEncrypt.method.value == i) {
			document.getElementById('wepTpId').style.display = showWepTp[i];
    	    document.getElementById('wpaTpId').style.display = showWpaTp[i];

			if ( i==0 && document.wlEncrypt.wepTp.value==0)
				document.getElementById('wepId').style.display = "none";
			else
				document.getElementById('wepId').style.display = showWep[i];
			document.getElementById('pskId').style.display = showPsk[i];
			if (apMode==1)
				document.getElementById('radiusId').style.display = "none";
			else
				document.getElementById('radiusId').style.display = showRadius[i];
		}

//**********
			if ( ((document.wlEncrypt.enRadius.checked==true)
				&& (document.getElementById('radiusId').style.display=="block"))
				||(document.wlEncrypt.method.value==3)) {
				document.getElementById('eapTpId').style.display = "block";
				for (j=0; j<=3; j++) {
					if (document.wlEncrypt.eapType.value==j) {
						document.getElementById('peapId').style.display = showPeap[j];
						document.getElementById('ttlsId').style.display = showTtls[j];
						document.getElementById('idId').style.display = showPass[j];

						document.getElementById('CerId').style.display = "block";
					}
					if ((document.wlEncrypt.eapType.value==3)
						&& (document.getElementById('eapTpId').style.display=="block")) {
						document.getElementById('passId').style.display = "block";
						document.getElementById('CerId').style.display = "none";
					}
					else
						document.getElementById('passId').style.display = "none";
				}
			}
			else {
				document.getElementById('eapTpId').style.display = "none";
				document.getElementById('peapId').style.display = "none";
				document.getElementById('ttlsId').style.display = "none";
				document.getElementById('idId').style.display = "none";
				document.getElementById('CerId').style.display = "none";
				document.getElementById('passId').style.display = "none";
			}
//**********
			if (document.getElementById('eapTpId').style.display=="block"
				&& document.wlEncrypt.eapType.value==1){
				document.wlEncrypt.enCltCer.checked=true;
				document.wlEncrypt.enCltCer.disabled=true;
			}
			else
				document.wlEncrypt.enCltCer.disabled=false;
	}
}
</SCRIPT>
</head>
<body class="background">
<blockquote>
<p align="center"><b><font class="titlecolor" size="4">Security</font></b></p>
<table width="520" border="0" cellspacing="0" cellpadding="0" align="center"><tr><td>
<p align="left"><font class="textcolor" size="2">
    This page allows you setup the wireless security. Turn on WEP or WPA by using
    Encryption Keys could prevent any unauthorized access to the wireless network.
</font></p></td></tr></table><br>


<form action=/goform/formStaEncrypt method=POST name="wlEncrypt">
<input type="hidden" name="wpaAuth" value="eap">

<input type="hidden" name="staSsidVal" value="<% getInfo("staSsid"); %>">
<table width="520" border="1" cellspacing="0" cellpadding="0" align="center">
	<tr class="table2"><td width="35%"><font size="2">Authentication Type :&nbsp;</font></td>
	<td width="65%" align="left"><font size="2">&nbsp;<select size="1" name="method" onChange="displayObj(1);">
	<script>
	<% write("wepTpVal = "+getIndex("staWep")+";");%>
	<% write("methodVal = "+getIndex("staEncrypt")+";");%>
	<% write("adhocSecMode = "+getIndex("adhocSecMode")+";");%>
	<% write("apMode = "+getIndex("apMode")+";");%>
/*		if ((apMode == 1) && (adhocSecMode == 0) ) {
			methodVal = 0;
			wepTpVal = 0;
		}
*/		if ((apMode == 1) && ((methodVal == 2) || (methodVal == 3)) ) {
			methodVal = 0;
		}

		var authTbl = new Array("Open System","Shared Key","WPA-PSK","WPA-RADIUS");
		for ( i=0; i<=3; i++) {
			if ( i == methodVal) {
				if (!(apMode==1 && (i==2 || i==3))) {
				  	document.write('<option selected value="'+i+'">'+authTbl[i]+'</option>');
				}
			}
			else {
				if (!(apMode==1 && (i==2 || i==3))) {
				  	document.write('<option value="'+i+'">'+authTbl[i]+'</option>');
				}
			}
		}
	</script></select></font></td></tr>	
</table>

<span id="wepTpId" style="display:none">
<table width="520" border="1" cellspacing="0" cellpadding="0" align="center">
	<tr class="table2"><td width="35%"><font size="2">Encryption Type:&nbsp;</font></td>
	<td width="65%" align="center"><font size="2">&nbsp;<select size="1" name="wepTp" onChange="displayObj(1);">
	<script>
		var wepTpTbl = new Array("Disable","WEP");
		for ( i=0; i<=1; i++) {
			if ( (i == wepTpVal) || (i==1 && wepTpVal==2)) {
			  	document.write('<option selected value="'+i+'">'+wepTpTbl[i]+'</option>');
			}
			else {
			  	document.write('<option value="'+i+'">'+wepTpTbl[i]+'</option>');
			}
		}
	</script></select></font></td></tr>	
</table>
</span>


<span id="wpaTpId" style="display:none">
<table width="520" border="1" cellspacing="0" cellpadding="0" align="center">
<tr class="table2"><td width="35%"><font size="2">Encryption Type :&nbsp;</font></td>
	<td width="65%" align="center"><font size=2>&nbsp;<input type="radio" value="1" name="wpaCipher"<% if (getIndex("staWpaCipher")==1) write("checked"); %>>TKIP&nbsp;&nbsp;
	<input type="radio" name="wpaCipher" value="2"<% if (getIndex("staWpaCipher")==2) write("checked"); %>>AES</td></tr>
</table>
</span>


<span id="wepId" style="display:none">
<table width="520" border="1" cellspacing="0" cellpadding="0" align="center">
	<tr><td width="35%"class="table1"><font size=2>Key Length :&nbsp;</td>
	<td width="65%" align="center"><font size=2>&nbsp;<select size="1" name="length" ONCHANGE=lengthClick()>
	<option value=1 <% if ( getIndex("staWep") != 2) write("selected"); %>>64-bit</option>
	<option value=2 <% if ( getIndex("staWep") == 2) write("selected"); %>>128-bit</option>
</table>


<table width="520" border="1" cellspacing="0" cellpadding="0" align="center">
	<tr class="table2"><td width="35%"><font size=2>Key Format :&nbsp;</td>
	<td width="65%" align="center"><font size=2>&nbsp;<select size="1" name="format" ONCHANGE=setDefaultKeyValue()>
	<option value=1>ASCII</option>
	<option value=2>Hex</option>
	</select></td></tr>
</table>


<table width="520" border="1" cellspacing="0" cellpadding="0" align="center">
	<tr class="table2"><td width="35%"><font size=2>Default Key :&nbsp;</td>
	<td width="65%" align="center">&nbsp;<select size="1" name="defaultTxKeyId">
	<option <% choice = getIndex("staDefKeyId"); if (choice == 1) write("selected"); %> value="1">Key 1</option>
	<option <% choice = getIndex("staDefKeyId"); if (choice == 2) write("selected"); %> value="2">Key 2</option>
	<option <% choice = getIndex("staDefKeyId"); if (choice == 3) write("selected"); %> value="3">Key 3</option>
	<option <% choice = getIndex("staDefKeyId"); if (choice == 4) write("selected"); %> value="4">Key 4</option>
	</select></td></tr>
</table>


<table width="520" border="1" cellspacing="0" cellpadding="0" align="center">
	<tr class="table2"><td width="35%"><font size=2>Encryption Key 1 :&nbsp;</td>
	<td width="65%" align="center"><font size=2>&nbsp;<input type="text" name="key1" size="32" maxlength="32"></td></tr>
</table>


<table width="520" border="1" cellspacing="0" cellpadding="0" align="center">
	<tr class="table2"><td width="35%"><font size=2>Encryption Key 2 :&nbsp;</td>
	<td width="65%" align="center"><font size=2>&nbsp;<input type="text" name="key2" size="32" maxlength="32"></td></tr>
</table>


<table width="520" border="1" cellspacing="0" cellpadding="0" align="center">
	<tr class="table2"><td width="35%"><font size=2>Encryption Key 3 :&nbsp;</td>
	<td width="65%" align="center"><font size=2>&nbsp;<input type="text" name="key3" size="32" maxlength="32"></td></tr>
</table>


<table width="520" border="1" cellspacing="0" cellpadding="0" align="center">
	<tr class="table2"><td width="35%"><font size=2>Encryption Key 4 :&nbsp;</td>
	<td width="65%" align="center"><font size=2>&nbsp;<input type="text" name="key4" size="32" maxlength="32"></td></tr>
</table>
</span>


<table border=0 width="520" cellspacing=3 style="display:none">
	<tr class="table2"><td width="35%"><font size="2">Pre-shared Key Format :&nbsp;</font></td>
	<td width="65%" align="center"><font size="2">&nbsp;<select size="1" name="pskFormat">
	<option value="0" <% if (getIndex("pskFormat")==0) write("selected");%>>Passphrase</option>
	<option value="1" <% if (getIndex("pskFormat")) write("selected");%>>Hex (64 characters)</option>
	</select></font></td></tr>
</table>



<span id="pskId" style="display:none">

<table width="520" border="1" cellspacing="0" cellpadding="0" align="center">
	<tr class="table2"><td width="35%"><font size="2">Pre-shared Key :&nbsp;</font></td>
	<td width="65%" align="center"><font size="2">&nbsp;<input type="text" name="psk" size="32" maxlength="64" value=<% getInfo("staPsk");%>></font></td></tr>
</table>
</span>

<span id="radiusId" style="display:none">
<table width="520" border="1" cellspacing="0" cellpadding="0" align="center">
<tr><td colspan="2"><font size=2 class="textcolor"><b>
   <input type="checkbox" name="enRadius" value="ON" <% if (getIndex("staEnRadius")==1) write("checked"); %>  onClick="displayObj(1);">&nbsp;&nbsp;Enable 802.1x Authentication</b>
     </td></tr>
</table>
</span>





<span id="eapTpId" style="display:none">
<table width="520" border="1" cellspacing="0" cellpadding="0" align="center">
	<tr class="table2"><td width="35%"><font size="2">EAP Type :&nbsp;</font></td>
	<td width="65%" align="center"><font size="2">&nbsp;<select size="1" name="eapType" onChange="displayObj(1);">
	<script>
	<% write("EapTpVal = "+getIndex("staEapTp")+";");%>
		var authTbl = new Array("PEAP","TLS","TTLS","MD5-Challenge");
		for ( i=0; i<=3; i++) {
			if ( i == EapTpVal) {
			  	document.write('<option selected value="'+i+'">'+authTbl[i]+'</option>');
			}
			else {
			  	document.write('<option value="'+i+'">'+authTbl[i]+'</option>');
			}
		}
	</script></select></font></td></tr>	
</table>

<table width="520" border="1" cellspacing="0" cellpadding="0" align="center">
	<tr class="table2"><td width="35%"><font size="2">Identity :&nbsp;</font></td>
	<td width="65%" align="center"><font size="2">&nbsp;<input type="text" name="identity" size="20"maxlength="64" value=<% getInfo("identity"); %>></font></td></tr>
</table>

</span>



<span id="passId" style="display:none">
<table width="520" border="1" cellspacing="0" cellpadding="0" align="center">
	<tr class="table2"><td width="35%"><font size="2">Password :&nbsp;</font></td>
	<td width="65%" align="center"><font size="2">&nbsp;<input type="password" name="md5Pass" size="20"maxlength="64" value=<% getInfo("md5Pass"); %>></font></td></tr>
</table>

</span>



<input type="hidden" value=<% getInfo("staProto"); %> name="staProto">
<span id="ttlsId" style="display:none">
<table width="520" border="1" cellspacing="0" cellpadding="0" align="center">
	<tr class="table2"><td width="35%"><font size="2">Tunnel Protocol :&nbsp;</font></td>
	<td width="65%" align="center"><font size="2">&nbsp;<select size="1" name="ttls" onChange="displayObj(1);">
	<script>
//		var ttlsTbl = new Array("CHAP","MSCHAP","MSCHAPv2","EAP-MD5","EAP-MSCHAPv2","EAP-TLS");
		var ttlsTbl = new Array("CHAP","MSCHAP","MSCHAPv2","EAP-MD5");
		for ( i=0; i<=3; i++) {
			if ( ttlsTbl[i] == document.wlEncrypt.staProto.value) {
			  	document.write('<option selected value="'+ttlsTbl[i]+'">'+ttlsTbl[i]+'</option>');
			}
			else {
			  	document.write('<option value="'+ttlsTbl[i]+'">'+ttlsTbl[i]+'</option>');
			}
		}
	</script></select></font></td></tr>	
</table>
</span>

<span id="peapId" style="display:none">
<table width="520" border="1" cellspacing="0" cellpadding="0" align="center">
	<tr class="table2"><td width="35%"><font size="2">Tunnel Protocol :&nbsp;</font></td>
	<td width="65%" align="center"><font size="2">&nbsp;<select size="1" name="peap" onChange="displayObj(1);">
	<script>
//		var peapTbl = new Array("MSCHAPv2","MD5","EAP-TLS");
		var peapTbl = new Array("MSCHAPv2");
		for ( i=0; i<=0; i++) {
			if ( peapTbl[i] == document.wlEncrypt.staProto.value) {
			  	document.write('<option selected value="'+peapTbl[i]+'">'+peapTbl[i]+'</option>');
			}
			else {
			  	document.write('<option value="'+peapTbl[i]+'">'+peapTbl[i]+'</option>');
			}
		}
	</script></select></font></td></tr>	
</table>
</span>


<span id="idId" style="display:none">
<table width="520" border="1" cellspacing="0" cellpadding="0" align="center">
	<tr class="table2"><td width="35%"><font size="2">Tunnel ID :&nbsp;</font></td>
	<td width="65%" align="center"><font size="2">&nbsp;<input type="text" name="eapId" size="20"maxlength="64" value=<% getInfo("eapId"); %>></font></td></tr>
</table>

<table width="520" border="1" cellspacing="0" cellpadding="0" align="center">
	<tr class="table2"><td width="35%"><font size="2">Tunnel Password :&nbsp;</font></td>
	<td width="65%" align="center"><font size="2">&nbsp;<input type="password" name="eapPass" size="20" maxlength="64" value=<% getInfo("eapPass"); %>></td></tr>
</table>
</span>


<span id="CerId" style="display:none">
<table width="520" border="1" cellspacing="0" cellpadding="0" align="center">
<tr><td colspan="2"><font size=2 class="textcolor"><b>
   <input type="checkbox" name="enCltCer" value="ON" <% if (getIndex("staEnCltCer")==1) write("checked"); %>  onClick="displayObj(1);">&nbsp;&nbsp;Enable Client Certificate</b>
     </td></tr>
</table>

<table width="520" border="1" cellspacing="0" cellpadding="0" align="center">
	<tr class="table2"><td width="35%"><font size="2">Private Key Password :&nbsp;</font></td>
	<td width="65%" align="center"><font size="2">&nbsp;<input type="text" name="cltPass" size="15"maxlength="32" value=<% getInfo("cltPass"); %>></font></td></tr>
</table>

<table width="520" border="1" cellspacing="0" cellpadding="0" align="center">
	<tr><td width="35%" align=right class="table1"><font size=2>Client Certificate : <br></td>
	<td width="65%" align="center"><font size=2>&nbsp;<input type="button" value="Add" name="cltload" onClick="showMacClick('/cltCert.asp')"></td>
  </tr>
</table>

<table width="520" border="1" cellspacing="0" cellpadding="0" align="center">
<tr><td colspan="2"><font size=2 class="textcolor"><b>
   <input type="checkbox" name="enSerCer" value="ON" <% if (getIndex("staEnSerCer")==1) write("checked"); %>  onClick="displayObj(1);">&nbsp;&nbsp;Enable Server Certificate</b>
     </td></tr>
</table>

<!--<table width="520" border="1" cellspacing="0" cellpadding="0" align="center">
	<tr class="table2"><td width="35%"><font size="2">Private Key Password :&nbsp;</font></td>
	<td width="65%" align="center"><font size="2">&nbsp;<input type="text" name="serPass" size="15"maxlength="32" value=<% getInfo("serPass"); %>></font></td></tr>
</table>
-->
<table width="520" border="1" cellspacing="0" cellpadding="0" align="center">
	<tr><td width="35%" align=right class="table1"><font size=2>Server Certificate : <br></td>
	<td width="65%" align="center"><font size=2>&nbsp;<input type="button" value="Add" name="serload" onClick="showMacClick('/serCert.asp')"></td>
  </tr>
</table>
</span>

<table width="520" border="0" cellspacing="0" cellpadding="0" align="center">
	<tr><td><div align="right">
	<input type="image" src="file/apply1.gif" onClick="return saveChanges()"  width="105" height="30" border="0">
	<input type="hidden" value="/wlstasec.asp" name="submit-url">
	<a href="javascript:window.location.reload()"><img src="file/cancel.gif" alt="" border="0" width="105" height="30"></a>
	</div></td></tr>
</table>

<script>
<% write("enCltCerVal = "+getIndex("enCltCer")+";");%>
<% write("enSerCerVal = "+getIndex("enSerCer")+";");%>
if (enCltCerVal==1)
	document.wlEncrypt.cltload.value="Edit";
if (enSerCerVal==1)
	document.wlEncrypt.serload.value="Edit";
updateFormat();
displayObj(0);
</script>
</form>
</blockquote>
</body>
</html>
