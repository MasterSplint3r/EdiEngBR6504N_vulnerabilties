<html>
<head>
<link rel="stylesheet" href="set.css">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Trigger Port</title>

<!--  Call the multiple languages text and the JavaScript document.  -->
    <script type="text/javascript" src="javascript.js"></script>
    <script type="text/javascript" src="file/qosnat-n.var"></script>

<script language="JavaScript" src="file/function.js"></script>






<script>

function checkValue(str) {
   for (var i=0; i<str.length; i++) {
    if ( (str.charAt(i) >= '0' && str.charAt(i) <= '9') ||
    		(str.charAt(i) == ',' ) || (str.charAt(i) == '-' ))
			continue;
	return 0;
  }
  return 1;
}


function addClick()
{

 	  if (triggerPortAdd.ip.value=="") {
		alert("IP address cannot be empty!");
		triggerPortAdd.ip.focus();
		return false;
	  }
	  if ( validateKey( triggerPortAdd.ip.value ) == 0 ) {
		alert("Invalid IP address value. It should be the decimal number (0-9).");
		triggerPortAdd.ip.focus();
		return false;
	  }
	  if ( !checkDigitRange(triggerPortAdd.ip.value,1,0,255) ) {
	      	alert('Invalid IP address range in 1st digit.');
		triggerPortAdd.ip.focus();
		return false;
	  }
	  if ( !checkDigitRange(triggerPortAdd.ip.value,2,0,255) ) {
	      	alert('Invalid IP address range in 2nd digit.');
		triggerPortAdd.ip.focus();
		return false;
	  }
	  if ( !checkDigitRange(triggerPortAdd.ip.value,3,0,255) ) {
	      	alert('Invalid IP address range in 3rd digit.');
		triggerPortAdd.ip.focus();
		return false;
	  }
	  if ( !checkDigitRange(triggerPortAdd.ip.value,4,1,254) ) {
	      	alert('Invalid IP address range in 4th digit.');
		triggerPortAdd.ip.focus();
		return false;
	  }


		
	if (document.triggerPortAdd.tcpopen.value=="" && document.triggerPortAdd.udpopen.value=="") {
		alert(showText(natsappAlertNoSet));
		document.triggerPortAdd.tcpopen.focus();
		return false;
	}
	
	if ( document.triggerPortAdd.tcpopen.value!="" && checkValue( document.triggerPortAdd.tcpopen.value ) == 0 ) {
		alert(showText(natsappAlertInvForm));
		document.triggerPortAdd.tcpopen.focus();
		return false;
	}
	
	if ( document.triggerPortAdd.udpopen.value!="" && checkValue(document.triggerPortAdd.tcpopen.value ) == 0 ) {
		alert(showText(natsappAlertInvForm));
		document.triggerPortAdd.tcpopen.focus();
		return false;
	}
	return true;
}

function disableDelButton() {
	document.triggerPortDel.deleteSelPort.disabled = true;
	document.triggerPortDel.deleteAllPort.disabled = true;
}
	function formLoad()
	{
		document.triggerPortAdd.gamelist.options[0] = new Option ("Select Game", -1);
		document.triggerPortAdd.gamelist.options[1] = new Option ("Age of Empires", 0);
		document.triggerPortAdd.gamelist.options[2] = new Option ("Aliens vs. Predator", 2);
		document.triggerPortAdd.gamelist.options[3] = new Option ("America's Army", 1);
		document.triggerPortAdd.gamelist.options[4] = new Option ("Asheron's Call", 3);
		document.triggerPortAdd.gamelist.options[5] = new Option ("Battlefield 1942", 4);
		document.triggerPortAdd.gamelist.options[6] = new Option ("Battlefield: Vietnam", 5);		
		document.triggerPortAdd.gamelist.options[7] = new Option ("BitTorrent", 63);
		document.triggerPortAdd.gamelist.options[8] = new Option ("Black and White", 6);	
		document.triggerPortAdd.gamelist.options[9] = new Option ("Call of Duty", 7);		
		document.triggerPortAdd.gamelist.options[10] = new Option ("Command and Conquer Generals", 8);
		document.triggerPortAdd.gamelist.options[11] = new Option ("Command and Conquer Zero Hour", 9);		
		document.triggerPortAdd.gamelist.options[12] = new Option ("Counter Strike", 10);
		document.triggerPortAdd.gamelist.options[13] = new Option ("Crimson Skies", 11);		
		document.triggerPortAdd.gamelist.options[14] = new Option ("Dark Reign 2", 12);
		document.triggerPortAdd.gamelist.options[15] = new Option ("Delta Force", 13);
		document.triggerPortAdd.gamelist.options[16] = new Option ("Diablo I and II", 14);
		document.triggerPortAdd.gamelist.options[17] = new Option ("Doom 3", 15);
		document.triggerPortAdd.gamelist.options[18] = new Option ("Dungeon Siege", 16);
		document.triggerPortAdd.gamelist.options[19] = new Option ("eDonkey", 65);
		document.triggerPortAdd.gamelist.options[20] = new Option ("eMule", 67);
		document.triggerPortAdd.gamelist.options[21] = new Option ("Everquest", 17);
		document.triggerPortAdd.gamelist.options[22] = new Option ("Far Cry", 18);
		document.triggerPortAdd.gamelist.options[23] = new Option ("Final Fantasy XI (PC)", 20);
		document.triggerPortAdd.gamelist.options[24] = new Option ("Final Fantasy XI (PS2)", 21);
		document.triggerPortAdd.gamelist.options[25] = new Option ("Gamespy Arcade", 76);
		document.triggerPortAdd.gamelist.options[26] = new Option ("Gamespy Tunnel", 77);
		document.triggerPortAdd.gamelist.options[27] = new Option ("Ghost Recon", 19);
		document.triggerPortAdd.gamelist.options[28] = new Option ("Gnutella", 64);
		document.triggerPortAdd.gamelist.options[29] = new Option ("Half Life", 22);
		document.triggerPortAdd.gamelist.options[30] = new Option ("Halo: Combat Evolved ", 23);
		document.triggerPortAdd.gamelist.options[31] = new Option ("Heretic II", 24);
		document.triggerPortAdd.gamelist.options[32] = new Option ("Hexen II", 25);
		document.triggerPortAdd.gamelist.options[33] = new Option ("Jedi Knight II: Jedi Outcast ", 26);
		document.triggerPortAdd.gamelist.options[34] = new Option ("Jedi Knight III: Jedi Academy ", 27);
		document.triggerPortAdd.gamelist.options[35] = new Option ("KALI", 75);
		document.triggerPortAdd.gamelist.options[36] = new Option ("Links", 28);
		document.triggerPortAdd.gamelist.options[37] = new Option ("Medal of Honor: Games", 29);
		document.triggerPortAdd.gamelist.options[38] = new Option ("MSN Game Zone", 73);
		document.triggerPortAdd.gamelist.options[39] = new Option ("MSN Game Zone (DX)", 74);
		document.triggerPortAdd.gamelist.options[40] = new Option ("Myth", 30);
		document.triggerPortAdd.gamelist.options[41] = new Option ("Need for Speed", 31);
		document.triggerPortAdd.gamelist.options[42] = new Option ("Need for Speed 3", 33);
		document.triggerPortAdd.gamelist.options[43] = new Option ("Need for Speed: Hot Pursuit 2", 32);
		document.triggerPortAdd.gamelist.options[44] = new Option ("Neverwinter Nights", 34);
		document.triggerPortAdd.gamelist.options[45] = new Option ("PainKiller ", 35);
		document.triggerPortAdd.gamelist.options[46] = new Option ("Postal 2: Share the Pain ", 36);
		document.triggerPortAdd.gamelist.options[47] = new Option ("Quake 2", 37);
		document.triggerPortAdd.gamelist.options[48] = new Option ("Quake 3", 38);
		document.triggerPortAdd.gamelist.options[49] = new Option ("Rainbow Six", 39);
		document.triggerPortAdd.gamelist.options[50] = new Option ("Rainbow Six: Raven Shield ", 40);
		document.triggerPortAdd.gamelist.options[51] = new Option ("Return to Castle Wolfenstein ", 41);
		document.triggerPortAdd.gamelist.options[52] = new Option ("Rise of Nations", 42);
		document.triggerPortAdd.gamelist.options[53] = new Option ("Roger Wilco", 78);
		document.triggerPortAdd.gamelist.options[54] = new Option ("Rogue Spear", 43);
		document.triggerPortAdd.gamelist.options[55] = new Option ("Serious Sam II", 44);
		document.triggerPortAdd.gamelist.options[56] = new Option ("Shareaza", 66);
		document.triggerPortAdd.gamelist.options[57] = new Option ("Silent Hunter II", 46);
		document.triggerPortAdd.gamelist.options[58] = new Option ("Soldier of Fortune", 47);
		document.triggerPortAdd.gamelist.options[59] = new Option ("Soldier of Fortune II: Double Helix", 48);
		document.triggerPortAdd.gamelist.options[60] = new Option ("Splinter Cell: Pandora Tomorrow",45);
		document.triggerPortAdd.gamelist.options[61] = new Option ("Star Trek: Elite Force II", 51);
		document.triggerPortAdd.gamelist.options[62] = new Option ("Starcraft", 49);
		document.triggerPortAdd.gamelist.options[63] = new Option ("Starsiege Tribes", 50);	
		document.triggerPortAdd.gamelist.options[64] = new Option ("Steam", 72);
		document.triggerPortAdd.gamelist.options[65] = new Option ("TeamSpeak", 79);
		document.triggerPortAdd.gamelist.options[66] = new Option ("Tiberian Sun", 52);
		document.triggerPortAdd.gamelist.options[67] = new Option ("Tiger Woods 2K4", 53);
		document.triggerPortAdd.gamelist.options[68] = new Option ("Ubi.com", 71);
		document.triggerPortAdd.gamelist.options[69] = new Option ("Ultima", 54);
		document.triggerPortAdd.gamelist.options[70] = new Option ("Unreal", 55);
		document.triggerPortAdd.gamelist.options[71] = new Option ("Unreal Tournament", 56);
		document.triggerPortAdd.gamelist.options[72] = new Option ("Unreal Tournament 2004", 57);
		document.triggerPortAdd.gamelist.options[73] = new Option ("Vietcong ", 58);
		document.triggerPortAdd.gamelist.options[74] = new Option ("Warcraft II", 59);
		document.triggerPortAdd.gamelist.options[75] = new Option ("Warcraft III", 60);
		document.triggerPortAdd.gamelist.options[76] = new Option ("WinMX", 68);
		document.triggerPortAdd.gamelist.options[77] = new Option ("Wolfenstein: Enemy Territory ", 61);
		document.triggerPortAdd.gamelist.options[78] = new Option ("WON Servers", 69);
		document.triggerPortAdd.gamelist.options[79] = new Option ("World of Warcraft", 62);	
		document.triggerPortAdd.gamelist.options[80] = new Option ("Xbox Live", 70);
	}


	function appSet()
	{
		games = new Array();
		
		games[0] = new Object;
		games[0].tcpport = "2302-2400,6073"							
		games[0].udpport = "2302-2400,6073"
		
		games[1] = new Object;
		games[1].tcpport = "20045"
		games[1].udpport = "1716-1718,8777,27900"
		
		games[2] = new Object;
		games[2].tcpport = "80,2300-2400,8000-8999"
		games[2].udpport = "80,2300-2400,8000-8999"
		
		games[3] = new Object;
		games[3].tcpport = "9000-9013"
		games[3].udpport = "2001,9000-9013"
			
		games[4] = new Object;
		games[4].tcpport = ""
		games[4].udpport = "14567,22000,23000-23009,27900,28900"
		
		games[5] = new Object;
		games[5].tcpport = ""
		games[5].udpport = "4755,23000,22000,27243-27245"
		
		games[6] = new Object;
		games[6].tcpport = "2611-2612,6500,6667,27900"
		games[6].udpport = "2611-2612,6500,6667,27900"
		
		games[7] = new Object;
		games[7].tcpport = "28960"
		games[7].udpport = "28960"
		
		games[8] = new Object;
		games[8].tcpport = "80,6667,28910,29900,29920"
		games[8].udpport = "4321,27900"
		
		games[9] = new Object;
		games[9].tcpport = "80,6667,28910,29900,29920"
		games[9].udpport = "4321,27900"
		
		games[10] = new Object;
		games[10].tcpport = "27030-27039"
		games[10].udpport = "1200,27000-27015"
		
		games[11] = new Object;
		games[11].tcpport = "1121,3040,28801,28805"
		games[11].udpport = ""
		
		games[12] = new Object;
		games[12].tcpport = "26214"	
		games[12].udpport = "26214"
		
		games[13] = new Object;
		games[13].tcpport = "3100-3999"
		games[13].udpport = "3568"

		games[14] = new Object;
		games[14].tcpport = "6112-6119,4000"
		games[14].udpport = "6112-6119"

		games[15] = new Object;
		games[15].tcpport = ""
		games[15].udpport = "27666"

		games[16] = new Object;
		games[16].tcpport = ""
		games[16].udpport = "6073,2302-2400"

		games[17] = new Object;
		games[17].tcpport = "1024-6000,7000"
		games[17].udpport = "1024-6000,7000"

		games[18] = new Object;
		games[18].tcpport = ""
		games[18].udpport = "49001,49002"

		games[19] = new Object;
		games[19].tcpport = "2346-2348"
		games[19].udpport = "2346-2348"

		games[20] = new Object;
		games[20].tcpport = "25,80,110,443,50000-65535"
		games[20].udpport = "50000-65535"

		games[21] = new Object;
		games[21].tcpport = "1024-65535"
		games[21].udpport = "50000-65535"

		games[22] = new Object;
		games[22].tcpport = "6003,7002"
		games[22].udpport = "27005,27010,27011,27015"

		games[23] = new Object;
		games[23].tcpport = ""
		games[23].udpport = "2302,2303"

		games[24] = new Object;
		games[24].tcpport = "28910"
		games[24].udpport = "28910"

		games[25] = new Object;
		games[25].tcpport = "26900"
		games[25].udpport = "26900"

		games[26] = new Object;	
		games[26].tcpport = ""
		games[26].udpport = "28060,28061,28062,28070-28081"

		games[27] = new Object;	
		games[27].tcpport = ""
		games[27].udpport = "28060,28061,28062,28070-28081"

		games[28] = new Object;	
		games[28].tcpport = "2300-2400,47624"
		games[28].udpport = "2300-2400,6073"

		games[29] = new Object;	
		games[29].tcpport = "12203-12204"
		games[29].udpport = ""

		games[30] = new Object;	
		games[30].tcpport = "3453"
		games[30].udpport = "3453"
		
		games[31] = new Object;
		games[31].tcpport = "9442"
		games[31].udpport = "9442"

		games[32] = new Object;
		games[32].tcpport = "8511,28900"	
		games[32].udpport = "1230,8512,27900,61200-61230"

		games[33] = new Object;
		games[33].tcpport = "1030"	
		games[33].udpport = "1030"

		games[34] = new Object;
		games[34].tcpport = ""	
		games[34].udpport = "5120-5300,6500,27900,28900"

		games[35] = new Object;
		games[35].tcpport = ""	
		games[35].udpport = "3455"

		games[36] = new Object;
		games[36].tcpport = "80"	
		games[36].udpport = "7777-7779,27900,28900"

		games[37] = new Object;
		games[37].tcpport = "27910"	
		games[37].udpport = "27910"

		games[38] = new Object;
		games[38].tcpport = "27660"	
		games[38].udpport = "27660"

		games[39] = new Object;
		games[39].tcpport = "2346"	
		games[39].udpport = "2346"

		games[40] = new Object;
		games[40].tcpport = ""	
		games[40].udpport = "7777-7787,8777-8787"

		games[41] = new Object;
		games[41].tcpport = ""	
		games[41].udpport = "27950,27960,27965,27952"

		games[42] = new Object;
		games[42].tcpport = ""	
		games[42].udpport = "34987"

		games[43] = new Object;
		games[43].tcpport = "2346"	
		games[43].udpport = "2346"

		games[44] = new Object;
		games[44].tcpport = "25600-25605"
		games[44].udpport = "25600-25605"

		games[45] = new Object;
		games[45].tcpport = "40000-43000"	
		games[45].udpport = "44000-45001,7776,8888"

		games[46] = new Object;
		games[46].tcpport = "3000"	
		games[46].udpport = "3000"

		games[47] = new Object;
		games[47].tcpport = ""	
		games[47].udpport = "28901,28910,38900-38910,22100-23000"

		games[48] = new Object;
		games[48].tcpport = ""	
		games[48].udpport = "20100-20112"

		games[49] = new Object;
		games[49].tcpport = "6112-6119,4000"	
		games[49].udpport = "6112-6119"

		games[50] = new Object;
		games[50].tcpport = ""	
		games[50].udpport = "27999,28000"

		games[51] = new Object;
		games[51].tcpport = ""	
		games[51].udpport = "29250,29256"

		games[52] = new Object;
		games[52].tcpport = "1140-1234,4000"	
		games[52].udpport = "1140-1234,4000"

		games[53] = new Object;
		games[53].tcpport = "80,443,1791-1792,13500,20801-20900,32768-65535"	
		games[53].udpport = "80,443,1791-1792,13500,20801-20900,32768-65535"

		games[54] = new Object;
		games[54].tcpport = "5001-5010,7775-7777,7875,8800-8900,9999"	
		games[54].udpport = "5001-5010,7775-7777,7875,8800-8900,9999"

		games[55] = new Object;
		games[55].tcpport = "7777,8888,27900"	
		games[55].udpport = "7777-7781"

		games[56] = new Object;
		games[56].tcpport = "7777-7783,8080,27900"	
		games[56].udpport = "7777-7783,8080,27900"

		games[57] = new Object;
		games[57].tcpport = "28902"	
		games[57].udpport = "7777-7778,7787-7788"

		games[58] = new Object;
		games[58].tcpport = ""	
		games[58].udpport = "5425,15425,28900"

		games[59] = new Object;
		games[59].tcpport = "6112-6119,4000"	
		games[59].udpport = "6112-6119"

		games[60] = new Object;
		games[60].tcpport = "6112-6119,4000"	
		games[60].udpport = "6112-6119"

		games[61] = new Object;
		games[61].tcpport = ""	
		games[61].udpport = "27950,27960,27965,27952"

		games[62] = new Object;
		games[62].tcpport = "3724,8086,8087,9081,9090,9091,9100"
		games[62].udpport = ""

		games[63] = new Object;
		games[63].tcpport = "6881-6889"	
		games[63].udpport = ""

		games[64] = new Object;
		games[64].tcpport = "6346"	
		games[64].udpport = "6346"

		games[65] = new Object;
		games[65].tcpport = "4661-4662"	
		games[65].udpport = "4665"

		games[66] = new Object;
		games[66].tcpport = "6349"	
		games[66].udpport = "6349"

		games[67] = new Object;
		games[67].tcpport = "4661-4662,4711"	
		games[67].udpport = "4672,4665"

		games[68] = new Object;
		games[68].tcpport = "6699"	
		games[68].udpport = "6257"

		games[69] = new Object;
		games[69].tcpport = "27000-27999"	
		games[69].udpport = "15001,15101,15200,15400"

		games[70] = new Object;
		games[70].tcpport = "3074"	
		games[70].udpport = "88,3074"

		games[71] = new Object;
		games[71].tcpport = "40000-42999"	
		games[71].udpport = "41005"

		games[72] = new Object;
		games[72].tcpport = "27030-27039"	
		games[72].udpport = "1200,27000-27015"

		games[73] = new Object;
		games[73].tcpport = "6667"	
		games[73].udpport = "28800-29000"

		games[74] = new Object;
		games[74].tcpport = "2300-2400,47624"	
		games[74].udpport = "2300-2400"

		games[75] = new Object;
		games[75].tcpport = ""
		games[75].udpport = "2213,6666"

		games[76] = new Object;
		games[76].tcpport = ""	
		games[76].udpport = "6500"

		games[77] = new Object;
		games[77].tcpport = ""	
		games[77].udpport = "6700"

		games[78] = new Object;
		games[78].tcpport = "3782"	
		games[78].udpport = "27900,28900,3782-3783"

		games[79] = new Object;
		games[79].tcpport = ""	
		games[79].udpport = "8767"

		var index = document.triggerPortAdd.gamelist.options[document.triggerPortAdd.gamelist.selectedIndex].value;
		if(index>=0)
		{		
			document.triggerPortAdd.comment.value=document.triggerPortAdd.gamelist.options[document.triggerPortAdd.gamelist.selectedIndex].text;
			document.triggerPortAdd.tcpopen.value=games[index].tcpport;
			document.triggerPortAdd.udpopen.value=games[index].udpport;
		}

	}

function goToWeb() {
	document.triggerPortAdd.submit();
}

function goToApply() {
	document.triggerPortApply.submit();
}
</script>
</head>

<body class="background" onLoad="formLoad()">
<blockquote>
  <table border="0" width="520" id="table1" cellspacing="0" cellpadding="0" align="center">
	<tr>
		<td>
		  <p align="center"><b><font class="titlecolor" size="4">
<script>dw(natSapp)</script>
  </font></b></p>
  <p align="left"><font class="textcolor"  size="2">
<script>dw(natSappInfo)</script>
  </font></p><br>
		</td>
	</tr>
	</table>
  <form action=/goform/formTriggerPort method=POST name="triggerPortAdd">
    <table border=0 width="520" cellspacing=4 cellpadding=0 align="center">
      <tr>
        <td><font size=2 class="textcolor"><b>
        <input type="checkbox" name="enabled" value="ON"
          <% if (getIndex("triggerPortEnabled")) write("checked");%> onClick="goToWeb();">
&nbsp;&nbsp;
<script>dw(enNatTrigPort)</script>
        </b></td>
      </tr>
      </table>
	<div align="center">
      <table border=1 width="520"  cellspacing=0 cellpadding=0>
        <tr class="stable" align="center">
          <td width="34%"><font size=2><b>
<script>dw(enNatTrigIp)</script>
          </b>
			</td>
          <td width="38%"><font size=2><b>
<script>dw(natTcpPort)</script>
          </b></td>
          <td width="8%"><font size=2><b>
			<script>dw(natUdpPort)</script></b></td>
          <td width="17%"><font size=2><b>
<script>dw(comment)</script></b>
		</td>
        </tr>
        <tr class="table2" align="center">
          <td>
            <font size=2><input type=text name="ip" size=12  maxlength=15 value="0.0.0.0"></font>
          </td>
          <td><font size=2>
			<input type=text name="tcpopen" size=18  maxlength=100 value=""></td>
          <td><font size=2>
			<input type=text name="udpopen" size=13  maxlength=100 value=""></td>
          <td><input type="text" name="comment" size="11" maxlength="16"></td>
        </tr>
        <tr class="table2">
          <td><font size=2><b>
<script>dw(natPopApp)</script>
          </b></td>
          <td align="center">
            <font size=2>
          &nbsp;<select name="gamelist">
          <option value=""><script>dw(selectoneolitec)</script></option>
          </select>
          </td>
        <td colspan="2">&nbsp;
         <input type="button" value="" name="copyTo" onClick="appSet();" class="btnsize">

        </td>
      </tr>
      <tr><td COLSPAN=4><BR>
         <input type="submit" value="" name="addPort" onClick="return addClick()" class="btnsize">&nbsp;&nbsp;
         <input type="reset" value="" name="reset" class="btnsize">
         <input type="hidden" value="/natsapp.asp" name="submit-url">
<script language ="javascript">
document.triggerPortAdd.copyTo.value =showText(add);
document.triggerPortAdd.addPort.value =showText(add);
document.triggerPortAdd.reset.value =showText(reset);
</script>
      </td></tr>
    </table>
  	</div>
  </form><br>

  <form action=/goform/formTriggerPort method=POST name="triggerPortDel">
    <input type="hidden" name="enabled" value="<% if (getIndex("triggerPortEnabled")) write("ON");%>">
		<div align="center">
		<table border="0" width="520" id="table2" cellspacing="0" cellpadding="0">
			<tr>
				<td> 
				   <font size=2 class="textcolor"><b>
					<script>dw(natTrigTable)</script>
        </b></td>
			</tr>
		</table>
		</div>
    <div align="center">
    <table border="1" width=520 cellspacing="0" cellpadding="0">

        </b></font></tr>
          <tr class="stable">
            <td width="5%"><font size=2><b>NO.</b></td>
            <td width="18%"><font size=2><b>
<script>dw(enNatTrigIp)</script>
</td>
            <td width="31%"><font size=2><b>
<script>dw(natTcpPort)</script>
            </b></td>
            <td width="24%"><font size=2><b>
<script>dw(natUdpPort)</script>
            </b></td>
            <td width="15%"><font size=2><b>
<script>dw(comment)</script>
            </b></td>
            <td width="5%"><font size=2><b>
<script>dw(select)</script>
            </b></td>
          </tr>
  <% triggerPortList(); %>
  </table>

  	</div>

  <input type="hidden" value="/natsapp.asp" name="submit-url">
  	<table border="0" width="520"   align="center">
		<tr>
			<td>
			  <br>
  <script>buffer='<input type="submit" value="'+showText(deleteSelected)+'" name="deleteSelPort" onClick="return deleteClick()" class="btnsize">';document.write(buffer);</script>&nbsp;&nbsp;
  <script>buffer='<input type="submit" value="'+showText(deleteAll)+'" name="deleteAllPort" onClick="return deleteAllClick()" class="btnsize">';document.write(buffer);</script>&nbsp;&nbsp;
  <script>buffer='<input type="reset" value="'+showText(reset)+'" name="reset" class="btnsize">';document.write(buffer);</script>
			</td>
		</tr>
	</table>
  </form>

<form action=/goform/formTriggerPort method=POST name="triggerPortApply">
  <table width="520" border="0" cellspacing="0" cellpadding="0" align="center">
    <tr>
      <td align="right">
		<script>buffer='<input type=submit value="'+showText(apply1)+'" style ="width:100px" onclick="goToApply();">';document.write(buffer);</script>
        <input type="hidden" value="/natsapp.asp" name="submit-url">
		<script>buffer='<input type=button value="'+showText(cancel1)+'" style ="width:100px" onClick="window.location.reload();">';document.write(buffer);</script>
        <input type="hidden" value="1" name="isApply">
</td></tr>
</table>
</form>

</blockquote>
</body>
</html>
