<html>
<head>
<link rel="stylesheet" href="set.css">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Wireless Advanced Setting</title>

<!-----------  This Is Added For Multi-language Webs   ------------>
<script language ='javascript' src ='javascript.js'></script>
<script language ='javascript' src ='file/fwwl-n.var'></script>
<script language="JavaScript" src="file/function.js"></script>

<SCRIPT>
function saveChanges() {

	if (!portRule(document.advanceSetup.fragThreshold, showText(wladvanceStrFrag), 0,"", 256, 2346, 1))
		return false;

	if (!portRule(document.advanceSetup.rtsThreshold, showText(wladvanceStrRts), 0,"", 0, 2347, 1))
		return false;

	if ( wlDev == 1 || wlDev == 2 ) {
		if (!portRule(document.advanceSetup.beaconInterval, showText(wladvanceStrInterval), 0,"", 20, 1024, 1))
			return false;
	}
	else {
		if (!portRule(document.advanceSetup.beaconInterval, showText(wladvanceStrInterval), 0,"", 20, 1000, 1))
			return false;

		if (!portRule(document.advanceSetup.dtimPeriod, showText(wladvanceStrDtim), 0,"", 1, 10, 1))
			return false;
	}
	return true;
}
</SCRIPT>
</head>
<body class="background">
<blockquote>
<div align="center">
<table border="0" width="520" cellspacing="0" cellpadding="0">
	<tr>
		<td>
  <p><b><font class="titlecolor" size="4"><script>dw(wlAdvSettings)</script></font></b></p>
  <p><font class="textcolor" size="2"><script>dw(wlAdInfo)</script></font></p><br>
		
		</td>
	</tr>
</table>
  </div>
  <form action=/goform/formAdvanceSetup method=POST name="advanceSetup">
    <div align="center">
    <table border=1 width="520" cellspacing=0 cellpadding="0">
      <tr>
        <td width="35%" class="table2"><font size=2><script>dw(wlFragThreshold)</script>:&nbsp;</font></td>
        <td width="65%" class="table2">
		<p style="text-align: left"><font size=2>&nbsp;
          <input type="text" name="fragThreshold" size="10" maxlength="4" value=<% getInfo("fragThreshold"); %>>&nbsp;(256-2346)
        </font></td>
      </tr>
    </table>

    </div>
	<div align="center">

    <table border=1 width="520" cellspacing=0 cellpadding="0">
      <tr>
        <td width="35%" class="table2"><font size=2><script>dw(wlRtsThreshold)</script>:&nbsp;</font></td>
        <td width="65%" class="table2">
		<p style="text-align: left"><font size=2>&nbsp;
          <input type="text" name="rtsThreshold" size="10" maxlength="4" value=<% getInfo("rtsThreshold"); %>>&nbsp;(0-2347)
        </font></td>
      </tr>
    </table>
    </div>
	<div align="center">
    <table border=1 width="520" cellspacing=0 cellpadding="0">
      <tr>
        <td width="35%" class="table2"><font size=2><script>dw(wlAdIntvl)</script>:&nbsp;</font></td>
	 <td width="65%" class="table2">
		<p style="text-align: left"><font size=2>&nbsp;
         <input type="text" name="beaconInterval" size="10" maxlength="4" value=
           <% getInfo("beaconInterval"); %>>&nbsp;(20-
           <% if (getIndex("wlDev")==3) write("1000"); else write("1024"); %> ms)
        </font></td>
      </tr>
    </table>

    	</div>

    <span id="dtimId" style="display:none">
      	<div align="center">
      <table border=1 width="520" cellspacing=0 cellpadding="0">
        <tr>
          <td width="35%" class="table2"><font size=2><script>dw(wlDtimPeriod)</script>:&nbsp;</font></td>
          <td width="65%" class="table2">
			<p style="text-align: left"><font size=2>&nbsp;
            <input type="text" name="dtimPeriod" size="10" maxlength="2" value=
              <% getInfo("dtimPeriod"); %>>&nbsp;(1-10)
          </font></td>
        </tr>
      </table>
    </div>
    </span>

    <span id="rtlRateId" style="display:none">
      <div align="center">
      <table border=1 width="520" cellspacing=0 cellpadding="0">
        <tr>
          <td width="35%" class="table2"><font size=2><script>dw(wlDataRate)</script>:&nbsp;</font></td>
          <td width="65%" class="table2">
			<p style="text-align: left">&nbsp;
            <select size="1" name="txRate">
<script>
<%  write("band = "+getIndex("band")+";");%>
<%  write("auto = "+getIndex("rateAdaptiveEnabled")+";");%>
<%  write("txrate = "+getIndex("fixTxRate")+";");%>
<%	write("wlDev = "+getIndex("wlDev")+";");%>

    rate_mask = [7,1,1,1,1,2,2,2,2,2,2,2,2];
    rate_name =["Auto","1M","2M","5.5M","11M","6M","9M","12M","18M","24M","36M","48M","54M"];
	band2mask = [0, 1, 2, 3, 4, 7];
    mask=0;
    
    mask = band2mask[band];
    
	defidx=0;
    for (idx=0, i=0; i<=28; i++) {
        if (rate_mask[i] & mask) {
            if (i == 0)
                rate = 0;
            else
				if(wlDev!=4)
                	rate = (1 << (i-1));
				else
					rate = i;
            if (txrate == rate)
                defidx = idx;
            document.write('<option value="' + i + '">' + rate_name[i] + '\n');
            idx++;
        }
    }
    document.advanceSetup.txRate.selectedIndex=defidx;

</script>
            </select>
          </td>
        </tr>
      </table>
    </div>
    </span>

<span id="11NRateId" style="display:none">
      <div align="center">
      <table border=1 width="520" cellspacing=0 cellpadding="0">
        <tr>
          <td width="35%" class="table2"><font size=2>N&nbsp;<script>dw(wlDataRate)</script>:&nbsp;</font></td>
          <td width="65%" class="table2">
			<p style="text-align: left">&nbsp;
            <select size="1" name="NtxRate">
<script>
<%  write("band = "+getIndex("band")+";");%>
<%  write("auto = "+getIndex("rateAdaptiveEnabled")+";");%>
<%  write("txrate = "+getIndex("NfixTxRate")+";");%>
<%	write("wlDev = "+getIndex("wlDev")+";");%>

    rate_mask = [7,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4];
    rate_name =["Auto", "MCS 0", "MCS 1", "MCS 2", "MCS 3", "MCS 4", "MCS 5", "MCS 6", "MCS 7", "MCS 8", "MCS 9", "MCS 10", "MCS 11", "MCS 12", "MCS 13", "MCS 14", "MCS 15"];
	band2mask = [0, 1, 2, 3, 4, 7];
    mask=0;
    
    mask = band2mask[band];
    
	defidx=0;
    for (idx=0, i=0; i<=16; i++) {
        if (rate_mask[i] & mask) {
            if (i == 0)
                rate = 0;
            else
				if(wlDev!=4)
                	rate = (1 << (i-1));
				else
					rate = i;
            if (txrate == rate)
                defidx = idx;
            document.write('<option value="' + i + '">' + rate_name[i] + '\n');
            idx++;
        }
    }
    document.advanceSetup.NtxRate.selectedIndex=defidx;

</script>
</select>
</td>
</span>

    <input type="hidden" name="getRate" value="<% getInfo("wlanTranRate"); %>">
    <span id="ipnRateId" style="display:none">
      </div>
	<div align="center">
      <table border=1 width="520" cellspacing=0 cellpadding="0">
        <tr>
          <td width="35%" class="table2"><font size=2><script>dw(wlTransmitRate)</script>:&nbsp;</font></td>
          <td width="65%" class="table2">
			<p style="text-align: left">&nbsp;
            <select size="1" name="wlanTranRate">
<script>
<%	write("wlDev = "+getIndex("wlDev")+";");%>
var rateTbl=new Array("auto","1M","2M","5.5M","6M","9M","11M","12M","18M","24M","36M","48M","54M");
var rValTbl=new Array("auto","10","20","55","60","90","110","120","180","240","360","480","540");
if (wlDev==1 || wlDev==3) {
	for (i=0; i<=12; i++) {
		if (document.advanceSetup.getRate.value == rValTbl[i])
			document.write('<option selected value="'+rValTbl[i]+'">'+rateTbl[i]+'</option>');
		else
			document.write('<option value="'+rValTbl[i]+'">'+rateTbl[i]+'</option>');
	}
}

</script>
            </select>
          </td>
        </tr>
      </table>
    </div>
    </span>

   <span id="NChanWidthId" style="display:none">
      <div align="center">
      <table border=1 width="520" cellspacing=0 cellpadding="0">
        <tr>
          <td width="35%" class="table2"><font size=2><script>dw(wlChanWidth)</script>:&nbsp;</font></td>
          <td width="65%" class="table2">
			<p style="text-align: left"><font size=2>&nbsp;
            <input type="radio" value="0" name="wlanNChanWidth"
              <% if (getIndex("NChanWidth")==0) write("checked"); %>>
Auto 20/40 MHZ&nbsp;&nbsp;
            <input type="radio" name="wlanNChanWidth" value="1"
              <% if (getIndex("NChanWidth")==1) write("checked"); %>>
20 MHZ</font>
          </td>
        </tr>
      </table>
    </div>
    </span>

    <span id="rtlPrmbId" style="display:none">
      <div align="center">
      <table border=1 width="520" cellspacing=0 cellpadding="0" height="26">
        <tr>
          <td width="35%" class="table2" height="24"><font size=2><script>dw(wlPreambleType)</script>:&nbsp;</font></td>
          <td width="65%" class="table2" height="24">
			<p style="text-align: left"><font size=2>&nbsp;
            <input type="radio" value="long" name="preamble"
              <% if (getIndex("preamble")==0) write("checked"); %>>
<script>dw(wlPreambleShort)</script>&nbsp;&nbsp;
            <input type="radio" name="preamble" value="short"
              <% if (getIndex("preamble")==1) write("checked"); %>>
<script>dw(wlPreambleLong)</script></font>
          </td>
        </tr>
      </table>
    </div>
    </span>
    <span id="ipnPrmbId" style="display:none">
      <div align="center">
      <table border=1 width="520" cellspacing=0 cellpadding="0">
        <tr>
          <td width="35%" class="table2"><font size=2><script>dw(wlPreambleShort)</script>:&nbsp;</font></td>
          <td width="65%" class="table2">
			<p style="text-align: left"><font size=2>&nbsp;
          <input type="radio" value="0" name="ipnPrmb"
            <% if (getIndex("preamble")==0) write("checked"); %>>Auto&nbsp;&nbsp;
          <input type="radio" name="ipnPrmb" value="1"
            <% if (getIndex("preamble")==1) write("checked"); %>>
<script>dw(wlPreambleLong)</script>&nbsp;&nbsp;
          <input type="radio" name="ipnPrmb" value="2"
            <% if (getIndex("preamble")==2) write("checked"); %>>
<script>dw(wlPreambleShort)</script></font>
          </td>
        </tr>
      </table>
    </div>
    </span>

    <span id="bcId" style="display:none">
      <div align="center">
      <table border=1 width="520" cellspacing=0 cellpadding="0">
        <tr>
          <td width="35%" class="table2"><font size=2><script>dw(wlBroadcastEssid)</script>:&nbsp;</font></td>
          <td width="65%" class="table2">
			<p style="text-align: left"><font size=2>&nbsp;
            <input type="radio" name="hiddenSSID" value="no"
              <% if (getIndex("hiddenSSID")==0) write("checked"); %>>
<script>dw(enable)</script>&nbsp;&nbsp;
            <input type="radio" name="hiddenSSID" value="yes"
              <% if (getIndex("hiddenSSID")==1) write("checked"); %>>
<script>dw(disable)</script></font>
          </td>
        </tr>
      </table>
    </div>
    </span>

    <span id="rateModeId" style="display:none">
      <div align="center">
      <table border=1 width="520" cellspacing=0 cellpadding="0">
        <tr>
          <td width="35%" class="table2"><font size=2><script>dw(wlAdOp)</script>:&nbsp;</font>
          </td>
          <td width="65%" class="table2">
			<p style="text-align: left"><font size=2>&nbsp;
            <input type="radio" value="mixed" name="wlanRateMode"
             <% if (getIndex("wlanRateMode")==0) write("checked"); %>>
<script>dw(wlMixedMode)</script>&nbsp;&nbsp;
            <input type="radio" name="wlanRateMode" value="g_only"
             <% if (getIndex("wlanRateMode")==1) write("checked"); %>>802.11g only&nbsp;&nbsp;
            <input type="radio" name="wlanRateMode" value="b_only"
             <% if (getIndex("wlanRateMode")==2) write("checked"); %>>802.11b only
          </font></td>
        </tr>
      </table>
    </div>
    </span>

    <span id="ctsId" style="display:none">
      <div align="center">
      <table border=1 width="520" cellspacing=0 cellpadding="0">
        <tr>
          <td width="35%" class="table2"><font size=2><script>dw(wlCtsProtect)</script>:&nbsp;</font></td>
          <td width="65%" class="table2">
			<p style="text-align: left"><font size=2>&nbsp;
            <input type="radio" value="auto" name="wlanCts"
             <% if (getIndex("wlanCts")==0) write("checked"); %>>
<script>dw(autos)</script>&nbsp;&nbsp;
            <input type="radio" name="wlanCts" value="always"
             <% if (getIndex("wlanCts")==1) write("checked"); %>>
<script>dw(always)</script>&nbsp;&nbsp;
            <input type="radio" name="wlanCts" value="none"
             <% if (getIndex("wlanCts")==2) write("checked"); %>>
<script>dw(none)</script></font>
          </td>
        </tr>
      </table>
    </div>
    </span>

    <span id="burstId" style="display:none">
      <div align="center">
      <table border=1 width="520" cellspacing=0 cellpadding="0">
        <tr>
          <td width="35%" class="table2"><font size=2><script>dw(wlAdBurst)</script>:&nbsp;</font></td>
          <td width="65%" class="table2">
			<p style="text-align: left"><font size=2>&nbsp;
            <input type="radio" value="yes" name="wlanBurst"
             <% if (getIndex("wlanBurst")==1) write("checked"); %>>
<script>dw(enable)</script>&nbsp;&nbsp;
            <input type="radio" name="wlanBurst" value="no"
             <% if (getIndex("wlanBurst")==0) write("checked"); %>>
<script>dw(disable)</script></font>
          </td>
        </tr>
      </table>
    </div>
    </span>
    <span id="iappId" style="display:none">
      <div align="center">
      <table border=1 width="520" cellspacing=0 cellpadding="0">
        <tr>
          <td width="35%" class="table2"><font size=2><script>dw(IAPP)</script>:&nbsp;</font></td>
          <td width="65%" class="table2">
			<p style="text-align: left"><font size=2>&nbsp;
            <input type="radio" name="iapp" value="yes"
             <% if (getIndex("iappDisabled")==0) write("checked"); %>>
<script>dw(enable)</script>&nbsp;&nbsp;
            <input type="radio" name="iapp" value="no"
             <% if (getIndex("iappDisabled")==1) write("checked"); %>>
<script>dw(disable)</script></font>
          </td>
        </tr>
      </table>
    </div>
    </span>

    <span id="protectId">
      <div align="center">
      <table border=1 width="520" cellspacing=0 cellpadding="0">
        <tr>
          <td width="35%" class="table2"><font size=2>802.11g <script>dw(protect)</script>:&nbsp;</font></td>
          <td width="65%" class="table2">
			<p style="text-align: left"><font size=2>&nbsp;
            <input type="radio" name="disProtection" value="yes"
             <% if (getIndex("disProtection")==0) write("checked"); %>>
<script>dw(enable)</script>&nbsp;&nbsp;
            <input type="radio" name="disProtection" value="no"
             <% if (getIndex("disProtection")==1) write("checked"); %>>
<script>dw(disable)</script></font>
          </td>
        </tr>
      </table>
    </div>
    </span>

    <input type="hidden" name="getTxPower" value="<% getInfo("wlanTxPower"); %>">
    <span id="txPowerId" style="display:none">
      <div align="center">
      <table border=1 width="520" cellspacing=0 cellpadding="0">
        <tr>
          <td width="35%" class="table2"><font size=2><script>dw(wlAdTxp)</script>:&nbsp;</font></td>
          <td width="65%" class="table2">
			<p style="text-align: left">&nbsp;
            <select size="1" name="wlanTxPower">
<script>
<%  write("wlDev = "+getIndex("wlDev")+";");%>
var rateTbl=new Array("100 %"," 90 %"," 75 %"," 50 %"," 25 %"," 10 %");
var rValTbl=new Array("0","89","59","29","14","9");
    for (i=0; i<6; i++) {
        if (document.advanceSetup.getTxPower.value == rValTbl[i])
            document.write('<option selected value="'+rValTbl[i]+'">'+rateTbl[i]+'</option>');
        else
            document.write('<option value="'+rValTbl[i]+'">'+rateTbl[i]+'</option>');
    }

</script>
            </select>
          </td>
        </tr>
      </table>
    </div>
    </span>
<!--
    <span id="turboId" style="display:none">
      <div align="center">
      <table border=1 width="520" cellspacing=0 cellpadding="0">
        <tr>
          <td width="35%" class="table2"><font size=2><script>dw(wlTurboMode)</script>:&nbsp;
</font></td>
          <td width="65%" class="table2">
			<p style="text-align: left"><font size=2>&nbsp;
            <input type="radio" name="wlanTurbo" value="no"
              <% if (getIndex("wlanTurbo")==0) write("checked"); %>>
<script>dw(enable)</script>&nbsp;&nbsp;
            <input type="radio" name="wlanTurbo" value="yes"
              <% if (getIndex("wlanTurbo")==1) write("checked"); %>>
<script>dw(disable)</script></font>
          </td>
        </tr>
      </table>
    </div>
    </span>
-->
    <span id="wmmId" style="display:none">
      <div align="center">
      <table border=1 width="520" cellspacing=0 cellpadding="0">
        <tr>
          <td width="35%" class="table2"><font size=2><script>dw(wlWMM)</script>:&nbsp;</font></td>
          <td width="65%" class="table2">
			<p style="text-align: left"><font size=2>&nbsp;
            <input type="radio" name="wlanWmm" value="no"
             <% if (getIndex("wlanWmm")==1) write("checked"); %>>
<script>dw(enable)</script>&nbsp;&nbsp;
            <input type="radio" name="wlanWmm" value="yes"
             <% if (getIndex("wlanWmm")==0) write("checked"); %>>
<script>dw(disable)</script></font>
          </td>
        </tr>
      </table>
    </div>
    </span><br>

<script>



modelName = "<%getInfo("modulename");%>";



	

<%	write("wlDev = "+getIndex("wlDev")+";");%>
var showDtim = new Array("none","none","block","block");
var showRtlRate = new Array("block","none","none","block");
var show11NRate = new Array("none","none","none","block");
var showIpnRate = new Array("none","none","block","none");
var showChanWidth = new Array("none","none","none","block");
var showRtlPrmb = new Array("block","block","none","block");
var showIpnPrmb = new Array("none","none","block","none");
var showBcs = new Array("block","none","block","block");
var showRateMod = new Array("none","none","block","none");
var showCts = new Array("none","none","block","block");
var showBurst = new Array("none","none","block","none");
var showIapp = new Array("block","none","block","none");
var showProtect = new Array("none","block","none","none");
var showTxPower = new Array("none","none","none","block");
//var showTurbo = new Array("none","none","none","block");
var showWmm = new Array("none","none","none","block");
for (i=1; i<=4; i++) {
    if ( wlDev == i ) {
   	    document.getElementById('dtimId').style.display = showDtim[i-1];
   	    document.getElementById('rtlRateId').style.display = showRtlRate[i-1];
   	    document.getElementById('11NRateId').style.display = show11NRate[i-1];
   	    document.getElementById('ipnRateId').style.display = showIpnRate[i-1];
   	    if (modelName == "Edimax20bw"){
   	    		document.getElementById('NChanWidthId').style.display = "none";
   	    
   	    }else{
   	    				document.getElementById('NChanWidthId').style.display = showChanWidth[i-1];
   	    				}
   	    document.getElementById('rtlPrmbId').style.display = showRtlPrmb[i-1];
   	    document.getElementById('ipnPrmbId').style.display = showIpnPrmb[i-1];
   	    document.getElementById('bcId').style.display = showBcs[i-1];
   	    document.getElementById('rateModeId').style.display = showRateMod[i-1];
   	    document.getElementById('ctsId').style.display = showCts[i-1];
   	    document.getElementById('burstId').style.display = showBurst[i-1];
   	    document.getElementById('iappId').style.display = showIapp[i-1];
   	    document.getElementById('protectId').style.display = showProtect[i-1];
   	    document.getElementById('txPowerId').style.display = showTxPower[i-1];
   	    //document.getElementById('turboId').style.display = showTxPower[i-1];
   	    document.getElementById('wmmId').style.display = showWmm[i-1];
    }
}
</script>

<table width="520" border="0" cellspacing="0" cellpadding="0" align="center">
<tr><td align="right">
	<script>buffer='<input type=submit value="'+showText(apply1)+'" name="B1" onclick="return saveChanges()" style ="width:100px">';document.write(buffer);</script>
	<input type="hidden" value="/wladvance.asp" name="submit-url">
	<script>buffer='<input type=button value="'+showText(cancel1)+'" style ="width:100px" onClick="document.advanceSetup.reset();">';document.write(buffer);</script>
</td>
</tr></tbody>
</table>
  </form>
</blockquote>
</body>
</html>
