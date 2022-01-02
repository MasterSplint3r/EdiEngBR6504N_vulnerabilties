<html>
<head>
<script language="JavaScript" src="file/function.js"></script>
<link rel="stylesheet" href="set.css">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>System Time Zone</title>
<script type="text/javascript" src="javascript.js"></script>
<script type="text/javascript" src="file/netsys-n.var"></script>
<script>
var Month = new Array(showText(jan),showText(feb),showText(march),showText(april),showText(may),showText(june),showText(july),showText(august),showText(sep),showText(oct),showText(nov),showText(dec));
//var monthNum = new Array(1,0,1,2,1,2,1,1,2,1,2,1);
var monthNum = new Array(31,28,31,30,31,30,31,31,30,31,30,31);

var ntp_zone_array=new Array(
"(GMT-12:00)Eniwetok, Kwajalein",
"(GMT-11:00)Midway Island, Samoa",
"(GMT-10:00)Hawaii",
"(GMT-09:00)Alaska",
"(GMT-08:00)Pacific Time (US & Canada); Tijuana",
"(GMT-07:00)Arizona",
"(GMT-07:00)Mountain Time (US & Canada)",
"(GMT-06:00)Central Time (US & Canada)",
"(GMT-06:00)Mexico City, Tegucigalpa",
"(GMT-06:00)Saskatchewan",
"(GMT-05:00)Bogota, Lima, Quito",
"(GMT-05:00)Eastern Time (US & Canada)",
"(GMT-05:00)Indiana (East)",
"(GMT-04:00)Atlantic Time (Canada)",
"(GMT-04:00)Caracas, La Paz",
"(GMT-04:00)Santiago",
"(GMT-03:30)Newfoundland",
"(GMT-03:00)Brasilia",
"(GMT-03:00)Buenos Aires, Georgetown",
"(GMT-02:00)Mid-Atlantic",
"(GMT-01:00)Azores, Cape Verde Is.",
"(GMT)Casablanca, Monrovia",
"(GMT)Greenwich Mean Time: Dublin, Edinburgh, Lisbon, London",
"(GMT+01:00)Amsterdam, Berlin, Bern, Rome, Stockholm, Vienna",
"(GMT+01:00)Belgrade, Bratislava, Budapest, Ljubljana, Prague",
"(GMT+01:00)Barcelona, Madrid",
"(GMT+01:00)Brussels, Copenhagen, Madrid, Paris, Vilnius",
"(GMT+01:00)Paris",
"(GMT+01:00)Sarajevo, Skopje, Sofija, Warsaw, Zagreb",
"(GMT+02:00)Athens, Istanbul, Minsk",
"(GMT+02:00)Bucharest",
"(GMT+02:00)Cairo",
"(GMT+02:00)Harare, Pretoria",
"(GMT+02:00)Helsinki, Riga, Tallinn",
"(GMT+02:00)Jerusalem",
"(GMT+03:00)Baghdad, Kuwait, Riyadh",
"(GMT+03:00)Moscow, St. Petersburg, Volgograd",
"(GMT+03:00)Mairobi",
"(GMT+03:30)Tehran",
"(GMT+04:00)Abu Dhabi, Muscat",
"(GMT+04:00)Baku, Tbilisi",
"(GMT+04:30)Kabul",
"(GMT+05:00)Ekaterinburg",
"(GMT+05:00)Islamabad, Karachi, Tashkent",
"(GMT+05:30)Bombay, Calcutta, Madras, New Delhi",
"(GMT+06:00)Astana, Almaty, Dhaka",
"(GMT+06:00)Colombo",
"(GMT+07:00)Bangkok, Hanoi, Jakarta",
"(GMT+08:00)Beijing, Chongqing, Hong Kong, Urumqi",
"(GMT+08:00)Perth",
"(GMT+08:00)Singapore",
"(GMT+08:00)Taipei",
"(GMT+09:00)Osaka, Sapporo, Tokyo",
"(GMT+09:00)Seoul",
"(GMT+09:00)Yakutsk",
"(GMT+09:30)Adelaide",
"(GMT+09:30)Darwin",
"(GMT+10:00)Brisbane",
"(GMT+10:00)Canberra, Melbourne, Sydney",
"(GMT+10:00)Guam, Port Moresby",
"(GMT+10:00)Hobart",
"(GMT+10:00)Vladivostok",
"(GMT+11:00)Magadan, Solomon Is., New Caledonia",
"(GMT+12:00)Auckland, Wllington",
"(GMT+12:00)Fiji, Kamchatka, Marshall Is.");

function saveChanges()
{
	if ( !ipRule( document.timezone.TimeServerAddr, "IP address", "ip", 1))
		return false;

	if ( wizardEnabled == 1) {
		document.timezone.settimezoneEnable.value="ON";
		parent.lFrame.stepDisplay(2);
	}
	return true;
}
		 
function TimeEnable()
{
  if(document.timezone.DayLightEnable.checked==false){
	document.timezone.startMonth.disabled = true;
	document.timezone.startDay.disabled = true;
	document.timezone.endMonth.disabled = true;
	document.timezone.endDay.disabled = true;
 }
 else{
	document.timezone.startMonth.disabled = false;
	document.timezone.startDay.disabled = false;
	document.timezone.endMonth.disabled = false;
	document.timezone.endDay.disabled = false;
 }
}
/*function chDayNum(Month,Day){
	Day.options[29] = new Option(30,30);
	Day.options[30] = null;
	if (monthNum[Month.selectedIndex]==1)  
		Day.options[30] = new Option(31,31);
	if (monthNum[Month.selectedIndex]==0)
		Day.options[29] = null;
} */

function chDayNum(Month,Day){
    if (monthNum[Month.selectedIndex] == 28)
    { 
        Day.options[29] = null;
    }
    else if(monthNum[Month.selectedIndex] == 30)
    {
        if(Day.selectedIndex == 29)
            Day.options[29] = new Option(30,30, true);
        else
            Day.options[29] = new Option(30,30);

        Day.options[30] = null;
    }
    else if (monthNum[Month.selectedIndex] == 31)
    {
        if(Day.selectedIndex == 29)
            Day.options[29] = new Option(30,30, true);
        else
            Day.options[29] = new Option(30,30);

        if(Day.selectedIndex == 30)
            Day.options[30] = new Option(31,31, true);
        else
            Day.options[30] = new Option(31,31);
    }
}

</script>
</head>
<body class="background">
<blockquote>
<script>
<%  write("wizardEnabled = "+getIndex("wizardEnabled"));%>
if (wizardEnabled == 0)
	document.write('<span style="display:block">');
else
	document.write('<span style="display:none">');
</script>
<p align="center"><b><font class="titlecolor" size="4"><script>dw(timeZone)</script></font></b><br><br>
<table border=0 width="520" cellspacing=0 cellpadding=0 align=center><tr><td>
<p align="left"><font class="textcolor" size="2"><script>dw(timeZonePageContent)</script><br>
</font></p></td></tr></table><br>
</span>

<script>
if (wizardEnabled == 1)
	document.write('<span style="display:block">');
else
	document.write('<span style="display:none">');
</script>
<table border=0 width="520" cellspacing=0 cellpadding=0 align=center><tr><td>
<p align="center"><b><font class="titlecolor" size="4"><script>dw(timeZone1)</script></font></b><p>
<font class="textcolor" size="2"><script>dw(timeZonePageContent)</script><br>
</font></td></tr></table>
</span>
<form action=/goform/formTimeZoneSetup method=POST name="timezone">
<table border=1 width="520" cellspacing=0 cellpadding=0 align=center>
<input type=hidden value=<% getInfo("TimeZoneSel"); %> name="TimeZoneSelget">
<input type=hidden value=<% getInfo("startMonth"); %> name="startMonthget">
<input type=hidden value=<% getInfo("startDay"); %> name="startDayget">
<input type=hidden value=<% getInfo("endMonth"); %> name="endMonthget">
<input type=hidden value=<% getInfo("endDay"); %> name="endDayget">

<tr>
<td width="30%" class="table2"><font size=2><script>dw(setTimeZone)</script>:&nbsp;</td>
<td width="70%" class="ltable"><select name="TimeZoneSel">
<script language="javascript">
for(i=0;i<ntp_zone_array.length;i++) {
	if(i==document.timezone.TimeZoneSelget.value)
		document.write("<option value=\""+i+"\" selected>"+ntp_zone_array[i]+"</option>");
	else
	 	document.write("<option value=\""+i+"\">"+ntp_zone_array[i]+"</option>");
   }
</script>
</select></td></tr>
  
<tr>
<td class="table2" align=right><font size=2><script>dw(timeServerAddr)</script>:&nbsp;<br></td>
<td class="ltable" size=2>
<input type="text" name="TimeServerAddr" size="15" maxlength="15" value=<% getInfo("TimeServerAddr"); %>></td></tr>

<tr>
<td class="table2"><font size=2><script>dw(daylightSave)</script>:&nbsp;</td>
<td class="ltable">
<input type="checkbox" name="DayLightEnable" value="ON" <% if (getIndex("DayLightEnable")==1) write("checked"); %> onClick="TimeEnable()"><font size=2><script>dw(enableFunction)</script></font><br>

<font size=2><script>dw(timeFrom)</script></font>
<select name="startMonth" onChange="chDayNum(this,document.timezone.startDay);">
<script language="javascript">
for(i=1;i<13;i++){
	if(i==document.timezone.startMonthget.value)
		document.write("<option value=\""+i+"\" selected>"+Month[(i-1)]+"</option>");
	else
	 	document.write("<option value=\""+i+"\">"+Month[(i-1)]+"</option>");
   }
</script></select>
  
<font size=2><select name="startDay">
<script>
for(i=1;i<32;i++){
	if(i==document.timezone.startDayget.value)
	 	document.write("<option value=\""+i+"\" selected>"+i+"</option>");
 	else
 		document.write("<option value=\""+i+"\">"+i+"</option>");
   }
</script></select>
<font size=2>To</font> 
<select class=Wf name="endMonth" onChange="chDayNum(this,document.timezone.endDay);">
<script language="javascript">
for(i=1;i<13;i++){
	if(i==document.timezone.endMonthget.value)
		document.write("<option value=\""+i+"\" selected>"+Month[(i-1)]+"</option>");
	else
		document.write("<option value=\""+i+"\">"+Month[(i-1)]+"</option>");
   }
</script></select>

<font size=2><select name="endDay">
<script>
for(i=1;i<32;i++){
	if(i==document.timezone.endDayget.value)
  		document.write("<option value=\""+i+"\" selected>"+i+"</option>");
  else
  		document.write("<option value=\""+i+"\">"+i+"</option>");
  }
</script></select><td>		
</tr>

<script>
chDayNum(document.timezone.startMonth,document.timezone.startDay);
chDayNum(document.timezone.endMonth,document.timezone.endDay);
TimeEnable();
</script>
</table>
<br>

<script>
if (wizardEnabled == 0)
	document.write('<span style="display:block">');
else
	document.write('<span style="display:none">');
</script>
<table width="520" border="0" cellspacing="0" cellpadding="0" align="center">
<tr><td align="right">
	<script>buffer='<input type=submit value="'+showText(apply1)+'" name="B1" style ="width:100px" onClick="return saveChanges();">';document.write(buffer);</script>
	<input type=hidden value="/systimezone.asp" name="submit-url" id="submitUrl">
	<script>buffer='<input type=button value="'+showText(cancel1)+'" style ="width:100px" onClick="document.timezone.reset();">';document.write(buffer);</script>
</td> </tr>
</table>
</span>

<script>
if (wizardEnabled == 1)
	document.write('<span style="display:block">');
else
	document.write('<span style="display:none">');
</script>
<table width="520" border="0" cellspacing="0" cellpadding="0" align="center">
<tr>
<td align="right">
<script>buffer='<input type=submit value="'+showText(next1)+'" name="B1" style ="width:100px" onClick="return saveChanges();">';document.write(buffer);</script>
<input type=hidden value="" name="settimezoneEnable">
</td>
</tr>
</table>
</span>

<script>
if (wizardEnabled == 1)
    document.getElementById('submitUrl').value = "/settype.asp";
</script>
</form>
</blockquote>
</body>
</html>
