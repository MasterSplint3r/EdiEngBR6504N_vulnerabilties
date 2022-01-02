<html>
<head>
<link rel="stylesheet" href="set.css">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>WAN Quality of Service</title>
<script type="text/javascript" src="javascript.js"></script>
<script type="text/javascript" src="file/qosnat-n.var"></script>
<script language="JavaScript" src="file/function.js"></script>
<script>
function macRange(macAddr) {
	str = macAddr.value;
	for (var i=0; i<str.length; i++) {
		if ( (str.charAt(i) >= '0' && str.charAt(i) <= '9') || (str.charAt(i) >= 'A' && str.charAt(i) <= 'F') || (str.charAt(i) >= 'a' && str.charAt(i) <= 'f') || (str.charAt(i) == ','))
			continue;
		alert(showText(wanqosaddAlertMac));
		macAddr.focus();
		return 0;
	}
	return 1;
}

function portRange(port) {
	str = port.value;
	for (var i=0; i<str.length; i++) {
		if ((str.charAt(i) >= '0' && str.charAt(i) <= '9') || (str.charAt(i) == ',') || (str.charAt(i) == '-'))
			continue;
		alert(showText(wanqosaddAlertPort));
		port.focus();
		return 0;
	}
	return 1;
}

function addClick() {
        strBwVal = document.formQos.bwidthVal;
        strDownVal = document.formQos.bwidthVal;
        strScStIp = document.formQos.sourStIp;
        strScEdIp = document.formQos.sourEdIp;
        strDtStIp = document.formQos.destStIp;
        strDtEdIp = document.formQos.destEdIp;
        strScMac = document.formQos.sourMac;
        strScPort = document.formQos.sourPort;
        strDtPort = document.formQos.destPort;
    //}
    /* else {
        strBwVal = document.formQos.bwidthVal;
        strDownVal = document.formQos.bwidthVal;
        strDownVal = document.formQos.bwidthVal;
        strScStIp = document.formQos.sourStIp;
        strScEdIp = document.formQos.sourEdIp;
        strDtStIp = document.formQos.destStIp;
        strDtEdIp = document.formQos.destEdIp;
        strScMac = document.formQos.sourMac;
        strScPort = document.formQos.sourPort;
        strDtPort = document.formQos.destPort;
    } */
    
    //strScStIp = document.formQos.sourStIp;
    //strScEdIp = document.formQos.sourEdIp;
    //strDtStIp = document.formQos.destStIp;
    //strDtEdIp = document.formQos.destEdIp;
    //strScMac = document.formQos.sourMac;
    //strScPort = document.formQos.sourPort;
    //strDtPort = document.formQos.destPort;

    if (qosShow[3] != 2) {
        if ((strDownVal.value=="" && strBwVal.value=="") || (strScStIp.value=="" && strScEdIp.value=="" && strDtStIp.value=="" && strDtEdIp.value=="" && strScMac.value=="" && strScPort.value=="" && strDtPort.value=="" && document.formQos.trafType.value==0)) {
            alert(showText(wanqosaddAlertAdd));
            return false;
        }
    }

    if (document.formQos.sourType.value == 0 ) {
        if ( !ipRule(strScStIp, showText(wanqosaddStartIp), "gw", 0))
            return false;

        if ( !ipRule(strScEdIp, showText(wanqosaddEndIp), "gw", 0))
            return false;
    }
    else
        if (strScMac.value != "" )
            if ( !macRange(strScMac))
                return false;

    if ( !ipRule(strDtStIp, showText(wanqosaddStartIpDest), "gw", 0))
        return false;

    if ( !ipRule(strDtEdIp, showText(wanqosaddStartIpDest), "gw", 0))
        return false;

    if (strScPort.value != "" )
        if ( !portRange(strScPort))
            return false;

    if (strDtPort.value != "" )
        if ( !portRange(strDtPort))
            return false;
    
    var longVal=0x001;
    document.formQos.configWan.value=longVal;
    document.formQos.configNum.value=qosShow[14];

    if (qosShow[14]) {
        document.formQos.addQos.disabled = true;
        document.formQos.editQos.disabled = false;
    }
    else {
        document.formQos.addQos.disabled = false;
        document.formQos.editQos.disabled = true;
    }
    return true;
}

function displayObj() {
	if (document.formQos.sourType.value == 0) {
		document.getElementById('ipId').style.display = "block";
		document.getElementById('macId').style.display = "none";
	}
	else {
		document.getElementById('ipId').style.display = "none";
		document.getElementById('macId').style.display = "block";
	}
}

function disWan() {
	if (qosShow[13] == "")
//		document.getElementById('wanId').style.display = "block";
		document.getElementById('wanId').style.display = "none";
	else
		document.getElementById('wanId').style.display = "none";
}
</script>
</head>

<body class="background">
<blockquote>
<span id="bgId" style="display:none">
<table width="520" border="0" cellspacing="0" cellpadding="0" align="center">
<tr><td background="file/blue_stripes.gif"><img src="file/blue_stripes_middle.jpg" width="357" height="37"></td>
</tr></table>
</span>

<p align="center"><font class="titlecolor" size="4"><script>dw(qos)</script></font></p>
<p align="center"><font class="textcolor"  size="2"><script>dw(qosAddInfo)</script><br></font></p>
<form action=/goform/formQoS method=POST name="formQos">
<table width="520" border="1" cellspacing="0" cellpadding="0" align="center">
<script><% QosShow(); %></script>
<tr class="table2">
	<td width="40%" align="right"><font size=2><b><script>dw(qosName);</script> :</b>&nbsp;</td>
	<td width="60%" align="left">&nbsp;<input type="text" name="ruleName" size="15" maxlength="15"></td></tr>
</table>

<span id="wanId" style='display:none'>
<table width="520" border="1" cellspacing="0" cellpadding="0" align="center">
<tr class="table2">
	<td width="40%" align="right"><font size=2><b><script>dw(wanqosaddWanPort)</script> :</b>&nbsp;</td>
	<td width="60%" align="left">&nbsp;
	<script>
		multiWan = 1;
		var wanIfTbl = new Array("WAN1","WAN2","WAN3","WAN4");
		for(i=0; i<multiWan; i++){
			if (i == (qosShow[13]-1)) 
				document.write("<input type='checkbox' name='Index"+i+"' checked>");
			else
				document.write("<input type='checkbox' name='Index"+i+"'>");
			document.write("<font size=2>" + wanIfTbl[i] + "</font>&nbsp;");
		}
	</script>
	</td>
</tr>
</table>
</span>

<table width="520" border="1" cellspacing="0" cellpadding="0" align="center">
<tr class="table2">
	<td width="40%" align="right"><font size=2><b><script>dw(qosBandwidth);</script> :</b>&nbsp;</td>
	<td width="60%" align="left">&nbsp;<select name="downUpType">
	<script>
		var downUpTbl = new Array("Upload","Download","Both");
		if (qosShow[1] != 0) {
			document.write("<option value=0 selected>"+ downUpTbl[0] +"</option>");
			document.write("<option value=1>"+ downUpTbl[1] +"</option>");
		}
		else {
			document.write("<option value=0>"+ downUpTbl[0] +"</option>");
			document.write("<option value=1 selected>"+ downUpTbl[1] +"</option>");
		}
		//document.write("<option value=2>"+ downUpTbl[2] +"</option>");
	</script>
	</select>
	
	<input type="text" name="bwidthVal" size="6" maxlength="6"><font size="2">&nbsp;Kbps</font>
	&nbsp;<select name="bwidthType">
	<script>
		var bwTypeTbl = new Array(showText(guaranteeolitec),"Max");
		if (qosShow[1] != 0) {
			for(i=0; i<2; i++) {
				if (i == qosShow[2])
					document.write('<option value="'+ i +'" selected>'+ bwTypeTbl[i] +'</option>');
				else
					document.write('<option value="'+ i +'">'+ bwTypeTbl[i] +'</option>');
			}
		}
		else {
			for(i=0; i<2; i++) {
				if (i == qosShow[16])
					document.write('<option value="'+ i +'" selected>'+ bwTypeTbl[i] +'</option>');
				else
					document.write('<option value="'+ i +'">'+ bwTypeTbl[i] +'</option>');
			}
		}
	</script>
	</select>
	</td>
</tr>
</table>

<input type="hidden" name="sourType" value=0>
<!--<table border=0 width="520" cellspacing=3 cellpadding=0>
<tr class="table2">
	<td width="40%" align="right"><font size=2><script>qosAddTxt("scAddr");</script></td>
	<td width="60%" align="left">&nbsp;<select name="sourType" onClick="displayObj();">
	<script>
		var addrTbl = new Array("IP Address","MAC Address");
		for(i=0; i<2; i++) {
			if (i == qosShow[3])
				document.write('<option value="'+ i +'" selected>'+ addrTbl[i] +'</option>');
			else
				document.write('<option value="'+ i +'">'+ addrTbl[i] +'</option>');
		}
	</script>
	</select></td></tr>
</table> -->

<span id="ipId">
<table width="520" border="1" cellspacing="0" cellpadding="0" align="center">
<tr class="table2">
	<td width="40%" align="right"><font size=2><b><script>dw(qosLocalIP);</script> :</b>&nbsp;</td>
	<td width="60%" align="left">&nbsp;<input type="text" name="sourStIp" size="15" maxlength="15"><font size="2"> - </font><input type="text" name="sourEdIp" size="15" maxlength="15"></td></tr>
</table>
</span>

<span id="macId">
<table width="520" border="1" cellspacing="0" cellpadding="0" align="center">
<tr class="table2">
	<td width="40%" align="right"><font size=2><b><script>dw(wanqosaddMacAddr)</script> :</b>&nbsp;</td>
	<td width="60%" align="left">&nbsp;<input type="text" name="sourMac" size="40" maxlength="108"></td></tr>
</table>
</span>

<table width="520" border="1" cellspacing="0" cellpadding="0" align="center">
<tr class="table2">
	<td width="40%" align="right"><font size=2><b><script>dw(qosLocalPort);</script> :</b>&nbsp;</td>
	<td width="60%" align="left">&nbsp;<input type="text" name="sourPort" size="35" maxlength="55"></td>
</tr>
</table>

<table width="520" border="1" cellspacing="0" cellpadding="0" align="center">
<tr class="table2">
	<td width="40%" align="right"><font size=2><b><script>dw(qosRemoteIP);</script> :</b>&nbsp;</td>
	<td width="60%" align="left">&nbsp;<input type="text" name="destStIp" size="15" maxlength="15"><font size="2"> - </font><input type="text" name="destEdIp" size="15" maxlength="15"></td></tr>
</table>

<table width="520" border="1" cellspacing="0" cellpadding="0" align="center">
<tr class="table2">
	<td width="40%" align="right"><font size=2><b><script>dw(qosRemotePort);</script> :</b>&nbsp;</td>
	<td width="60%" align="left">&nbsp;<input type="text" name="destPort" size="35" maxlength="55"></td>
</tr>
</table>

<table width="520" border="1" cellspacing="0" cellpadding="0" align="center">
<tr class="table2">
	<td width="40%" align="right"><font size=2><b><script>dw(qosTraffic);</script> :</b>&nbsp;</td>
	<td width="60%" align="left">&nbsp;<select name="trafType"><script>
		var trafTbl = new Array(showText(noneolitec),"SMTP","HTTP","POP3","FTP");
		for(i=0; i<5; i++) {
			if (i == qosShow[9])
				document.write('<option value="'+ i +'" selected>'+ trafTbl[i] +'</option>');
			else
				document.write('<option value="'+ i +'">'+ trafTbl[i] +'</option>');
		}
</script></td></tr></table>

<table width="520" border="1" cellspacing="0" cellpadding="0" align="center">
<tr class="table2">
	<td width="40%" align="right"><font size=2><b><script>dw(protocal);</script> :</b>&nbsp;</td>
	<td width="60%" align="left">&nbsp;<select name="protocol">
	<script>
		var ptlTbl = new Array("TCP","UDP");
		for(i=0; i<2; i++) {
			if (i == qosShow[10])
				document.write('<option value="'+ i +'" selected>'+ ptlTbl[i] +'</option>');
			else
				document.write('<option value="'+ i +'">'+ ptlTbl[i] +'</option>');
		}
	</script>
	</select></td></tr></table>

<script>

with(document.formQos) {
    ruleName.value = qosShow[0];
    if( qosShow[1] != 0 ) { // Upload
    //if ( document.formQos.downUpType == 0 ) {
        bwidthVal.value = qosShow[1];
        sourStIp.value = qosShow[4];
        sourEdIp.value = qosShow[5];
        sourPort.value = qosShow[11];
        
        destStIp.value = qosShow[7];
        destEdIp.value = qosShow[8];
        destPort.value = qosShow[12];
    }
    else {  // Download
        bwidthVal.value = qosShow[15];
        sourStIp.value = qosShow[7];
        sourEdIp.value = qosShow[8];
        sourPort.value = qosShow[12];
        
        destStIp.value = qosShow[4];
        destEdIp.value = qosShow[5];
        destPort.value = qosShow[11];
    }
    
    sourMac.value = qosShow[6];
    
    //sourStIp.value = qosShow[7];
    //sourEdIp.value = qosShow[8];
    //sourPort.value = qosShow[12];
        
    //destStIp.value = qosShow[4];
    //destEdIp.value = qosShow[5];
    //destPort.value = qosShow[11];
}
displayObj();


</script>

<table width="520" border="0" cellspacing="0" cellpadding="0" align="center">
<tr>
<td colspan=4>
<p align="right">
<script>document.write('<input type="submit" value="'+showText(save)+'" class="btnsize" name="apply" onClick="return addClick()">');</script>&nbsp;&nbsp;
<script>document.write('<input type="reset" value="'+showText(reset)+'" class="btnsize" name="reset">');</script></p>
<input type="hidden" value="/wanqos.asp" name="submitUrl">
<input type="hidden" value="" name="configWan">
<input type="hidden" value="" name="configNum">
<input type="hidden" value="Add" name="addQos">
<input type="hidden" value="Edit" name="editQos">
<!-- <input type="hidden" value=<% if (getIndex("wan1QosEnabled")) write("ON");%> name="enabled1"> -->
</td></tr>
</table>
</form>
</blockquote>
</body>
</html>

