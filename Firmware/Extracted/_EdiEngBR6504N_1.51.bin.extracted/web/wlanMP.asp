<html>
<head>
<link rel="stylesheet" href="set.css">
<meta http-equiv="Content-Type" content="text/html">
<meta http-equiv="no-cache">
<title>WLAN Basic Settings</title>
<script>
function removeall(selObj2)
{
for(i=(selObj2.length-1);i>=0;i--)
  {
  j=0;
    selObj2.options[i]=null;
  }
}

function txRate(mode) {
	removeall(document.wlanMP.ateRate);
	switch(mode){
	case 0:
		
		document.wlanMP.ateRate.options[0]=new Option ("MCS0 1M", 0);
		document.wlanMP.ateRate.options[1]=new Option ("MCS1 2M", 1);
		document.wlanMP.ateRate.options[2]=new Option ("MCS2 5.5M", 2);
		document.wlanMP.ateRate.options[3]=new Option ("MCS3 11M", 3);
		document.wlanMP.ateRate.options[4]=new Option ("MCS8 1M", 8);
		document.wlanMP.ateRate.options[5]=new Option ("MCS9 2M", 9);
		document.wlanMP.ateRate.options[6]=new Option ("MCS10 5.5M", 10);
		document.wlanMP.ateRate.options[7]=new Option ("MCS11 11M", 11);
		document.wlanMP.ateRate.selectedIndex=3;
		break;
	case 1:
		document.wlanMP.ateRate.options[0]=new Option ("MCS0 6M", 0);
		document.wlanMP.ateRate.options[1]=new Option ("MCS1 9M", 1);
		document.wlanMP.ateRate.options[2]=new Option ("MCS2 12M", 2);
		document.wlanMP.ateRate.options[3]=new Option ("MCS3 18M", 3);
		document.wlanMP.ateRate.options[4]=new Option ("MCS4 24M", 4);
		document.wlanMP.ateRate.options[5]=new Option ("MCS5 36M", 5);
		document.wlanMP.ateRate.options[6]=new Option ("MCS6 48M", 6);
		document.wlanMP.ateRate.options[7]=new Option ("MCS7 54M", 7);
		document.wlanMP.ateRate.selectedIndex=7;
		break;
	case 2:
	case 3:
		document.wlanMP.ateRate.options[0]=new Option ("MCS0 6.5M", 0);
		document.wlanMP.ateRate.options[1]=new Option ("MCS1 13M", 1);
		document.wlanMP.ateRate.options[2]=new Option ("MCS2 19.5M", 2);
		document.wlanMP.ateRate.options[3]=new Option ("MCS3 26M", 3);
		document.wlanMP.ateRate.options[4]=new Option ("MCS4 39M", 4);
		document.wlanMP.ateRate.options[5]=new Option ("MCS5 52M", 5);
		document.wlanMP.ateRate.options[6]=new Option ("MCS6 58.5M", 6);
		document.wlanMP.ateRate.options[7]=new Option ("MCS7 65M", 7);
		document.wlanMP.ateRate.options[8]=new Option ("MCS8 13M", 8);
		document.wlanMP.ateRate.options[9]=new Option ("MCS9 26M", 9);
		document.wlanMP.ateRate.options[10]=new Option ("MCS10 39M", 10);
		document.wlanMP.ateRate.options[11]=new Option ("MCS11 52M", 11);
		document.wlanMP.ateRate.options[12]=new Option ("MCS12 78M", 12);
		document.wlanMP.ateRate.options[13]=new Option ("MCS13 104M", 13);
		document.wlanMP.ateRate.options[14]=new Option ("MCS14 117M", 14);
		document.wlanMP.ateRate.options[15]=new Option ("MCS15 130M", 15);
		document.wlanMP.ateRate.options[16]=new Option ("MCS32 duplicate 6M", 32);
		document.wlanMP.ateRate.selectedIndex=15;
		break;
	
	}

	
}


</script>
</head>
<body class="background">
<blockquote>
<p><b><font class="titlecolor" size="4">Wireless MP</font></b></p>

<p align="left"><font class="textcolor" size="2">
This page allows you to test RF function, such as contunue TX/packet TX. </font></p>

<form action=/goform/formWlanMP method=POST name="wlanMP" >

<input type="hidden" value="/wlanMP.asp" name="submit-url">
<ul>

<table border=0 width="650" cellspacing=3>
<tr>
	<td width="33%" class="table1"><font size=2>Test Function :&nbsp;</font></td>
	<td class="table2"><font size=2>&nbsp;<select name="ateFunc" size="1">
		<option value="TXCONT" selected>TXCONT</option>
		<option value="E2PTXFREQOFFSET">E2PTXFREQOFFSET</option>
		<option value="CARRIER">Check Carrier</option>
		<option value="MASK">Check specturm mask</option>
		<option value="OFFSET">Frequency offset tuning</option>
		<option value="RXFRAME">RXFRAME</option>
		<option value="TXPOWER">TXPOWER</option>
		<option value="ATESTOP">ATESTOP</option>
		<option value="E2PTXPOWER">E2PTXPOWER</option>
		<option value="DELTA">E2PTXPOWERDELTA</option>
		<option value="ATETXFREQOFFSET">ATETXFREQOFFSET</option>
		<option value="READE2P">READE2P</option>
	</select></font></td></tr>
</table>
<br>
<table border=0 width="687" cellspacing=3>
	<tr><td width="39%" class="table1"><font size=2>PA gain :&nbsp;</font></td>
	<td class="table2">&nbsp;<input type="text" name="ateGain" size="25" maxlength="32" value="10"></td></tr>
	<tr><td class="table1"><font size=2>Tx Count :&nbsp;</font></td>
	<td class="table2">&nbsp;<input type="text" name="ateTxCount" size="25" maxlength="32" value="200"></td></tr>
	<tr><td class="table1"><font size=2>Channel :&nbsp;</font></td>
	<td class="table2">&nbsp;<font size=2>
		<select size="1" name="ateChan">
		<option value="1" selected>1</option>
		<option value="2">2</option>
		<option value="3">3</option>
		<option value="4">4</option>
		<option value="5">5</option>
		<option value="6">6</option>
		<option value="7">7</option>
		<option value="8">8</option>
		<option value="9">9</option>
		<option value="10">10</option>
		<option value="11">11</option>
		<option value="12">12</option>
		<option value="13">13</option>
		<option value="14">14</option>
	</select></font></td></tr>
	<tr>
		<td class="table1"><font size="2">Antenna :</font></td>
	<td class="table2"><font size=2>&nbsp;
		<select size="1" name="ateAntenna">
        	<option value="0" >0</option>
						<option value="1" selected>1</option>
						<option value="2">2</option>
		</select></font></td>
		</tr>
		<tr>
			<td class="table1"><font size="2">TX Mode :&nbsp; </font></td>
	<td class="table2"><font size=2>&nbsp;
		<select size="1" name="ateMode" onChange="txRate(document.wlanMP.ateMode.selectedIndex)">
        	<option value="0" selected>CCK</option>
			<option value="1">OFDM</option>
			<option value="2">HT_MIX</option>
			<option value="3">Green Field</option>
		</select></font></td>
		</tr>
	<tr><td class="table1"><font size=2>TX Rate :&nbsp;</font></td>
	<td class="table2">&nbsp;<font size=2>
		<select size="1" name="ateRate">
		</select></font>
		<script>
			txRate(0);
		</script>
		</td></tr>
	
	<tr><td class="table1"><font size=2>OFFSET :&nbsp;</font></td>
	<td class="table2">&nbsp;<input type="text" name="ateTxFreqOffset" size="25" maxlength="4" value="FF">
		&nbsp;</td></tr>
	<tr><td class="table1" height="23"><font size="2">E2P TX freqoffset :&nbsp;</font></td>
		<td class="table2" height="23">&nbsp;<input type="text" name="e2pTxFreqOffset" size="4" maxlength="4" value="FF"></td></tr>
	<tr><td class="table1" height="27"><font size="2">TX BW :</font></td>
		<td class="table2" height="27"><font size=2>&nbsp;<select size="1" name="ateBW">
        	<option value="0">20MHZ</option>
			<option selected value="1">40MHZ</option>
		</select></font></td></tr>
	<tr><td class="table1"><font size=2>Set E2P TX1 power :&nbsp;</font></td>
		<td class="table2">&nbsp;
		2<input type="hidden" name="e2pChan1" value="46"><input type="text" name="e2pTxPower1" size="4" maxlength="4" value="0C0C">
		4<input type="hidden" name="e2pChan2" value="48"><input type="text" name="e2pTxPower2" size="4" maxlength="4" value="0C0C">
		6<input type="hidden" name="e2pChan3" value="4A"><input type="text" name="e2pTxPower3" size="4" maxlength="4" value="0C0C">
		8<input type="hidden" name="e2pChan4" value="4C"><input type="text" name="e2pTxPower4" size="4" maxlength="4" value="0C0C">
		10<input type="hidden" name="e2pChan5" value="4E"><input type="text" name="e2pTxPower5" size="4" maxlength="4" value="0C0C">
		12<input type="hidden" name="e2pChan6" value="50"><input type="text" name="e2pTxPower6" size="4" maxlength="4" value="0C0C">
		14<input type="hidden" name="e2pChan7" value="52"><input type="text" name="e2pTxPower7" size="4" maxlength="4" value="0C0C">
	</td></tr>
	<tr><td class="table1"><font size=2>Set E2P TX2 power :</font></td>
	<td class="table2">
	&nbsp; 2<input type="text" name="e2pTx2Power1" size="4" maxlength="4" value="0C0C">
		4<input type="text" name="e2pTx2Power2" size="4" maxlength="4" value="0C0C">
		6<input type="text" name="e2pTx2Power3" size="4" maxlength="4" value="0C0C">
		8<input type="text" name="e2pTx2Power4" size="4" maxlength="4" value="0C0C">
		10<input type="text" name="e2pTx2Power5" size="4" maxlength="4" value="0C0C">
		12<input type="text" name="e2pTx2Power6" size="4" maxlength="4" value="0C0C">
		14<input type="text" name="e2pTx2Power7" size="4" maxlength="4" value="0C0C">
	</td></tr>
	<tr><td class="table1"><font size="2">Tx power delta configuration b:</font></td>
	<td class="table2">
	<input type="text" name="e2pTxPwDeltaB" size="25" maxlength="4" value="FF"></td></tr>
	<tr><td class="table1"><font size="2">Tx power delta configuration g:</font></td>
	<td class="table2">
	<input type="text" name="e2pTxPwDeltaG" size="25" maxlength="4" value="FF"></td></tr>
	<tr><td class="table1"><font size="2">Tx power delta configuration n:</font></td>
	<td class="table2">
	<input type="text" name="e2pTxPwDeltaN" size="25" maxlength="4" value="FF"></td></tr>
	<tr><td class="table1"><font size="2">Tx power delta configuration 20/40:</font></td>
	<td class="table2">
	<input type="text" name="e2pTxPwDeltaMix" size="25" maxlength="4" value="FFFF"></td></tr>
	
	<tr><td class="table1">
		<font size="2">ReadE2P:</font><input type="text" name="readE2P" size="4" maxlength="4" value="0C">

</td>
	<td class="table2">
	<input type="text" name="e2pValue" size="25" maxlength="4" value="<% getInfo("readE2P"); %>"></td></tr>
</table>
</ul>
<br>

<table width="300" border="0" cellspacing="0" cellpadding="0" align="right">
<tr><td align="right">
	<input type="submit" value="Apply" style ="width:100px">
</td></tr>
</table>
</form>
</blockquote>
</body>
</html>
