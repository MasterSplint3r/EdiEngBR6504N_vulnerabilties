<html><head>
<link rel="stylesheet" href="set.css">				
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<style>test10 {
	FONT-SIZE: 10pt; TEXT-DECORATION: none
}
A:link {
	COLOR: #ffff00; FONT-FAMILY: Arial; FONT-SIZE: 9pt; TEXT-DECORATION: none
}
A:visited {
	COLOR: #ffff00; FONT-FAMILY: Arial; FONT-SIZE: 9pt; TEXT-DECORATION: none
}
</style>
<script type="text/javascript" src="javascript.js"></script>
<script type="text/javascript" src="file/statustool-n.var"></script>
<script language="JavaScript">
<%	write("var curTime = new Date("+getIndex("systime")+");");%>
var feature_func = 1;
var operation_func = 1;

function funClock() {
if (!document.layers && !document.all) return;
var runTime = new Date();
var hours = document.tF0.hour.value;
var minutes = document.tF0.min.value;
var seconds = document.tF0.sec.value;
if (seconds == 0)
{
minutes++;
document.tF0.min.value++;
if(minutes ==60)
{
hours++;
document.tF0.hour.value++;
minutes = 0;
document.tF0.min.value = 0;
}
}
//if (hours == 0) hours = 12;
if (hours == 12 && minutes==0 && seconds == 0) setTimeout('document.location.href="tlmenu.asp";',0);
var temp_min=String(minutes);
if (minutes <= 9 && temp_min.length==1) minutes = "0" + minutes;
if (seconds <= 9) seconds = "0" + seconds;
movingtime = "<font class=menut size=2>"+ hours + ":" + minutes + ":" + seconds + "</font>";
if (document.layers) {
document.layers.clock.document.write(movingtime);
document.layers.clock.document.close();
}
else if (document.all) clock.innerHTML = movingtime;
document.tF0.sec.value++;
if(document.tF0.sec.value>59) document.tF0.sec.value = 0;
setTimeout("funClock()", 1000)
}
window.onload = funClock;

function MM_swapImgRestore() { //v3.0
  var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
}

function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}

function MM_findObj(n, d) { //v4.0
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
  if(!x && document.getElementById) x=document.getElementById(n); return x;
}

function MM_swapImage() { //v3.0
  var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3)
   if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}
}
</script></head>
<body class="subbg4" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="funClock();" background="file/back-b2.gif" link="#FFFFFF" vlink="#FFFFFF" style="background-color: #000000">
<form name="tF0" method="post" action=""> 
<input type="hidden" name="year" value="2000">
<input type="hidden" name="mon" value="0">
<input type="hidden" name="day" value="1">
<input type="hidden" name="hour" value="1">
<input type="hidden" name="min" value="1">
<input type="hidden" name="sec" value="1">
<script>
	document.tF0.year.value=curTime.getFullYear();
	document.tF0.mon.value=curTime.getMonth();
	document.tF0.day.value=curTime.getDate();
	document.tF0.hour.value=curTime.getHours();
	document.tF0.min.value=curTime.getMinutes();
	document.tF0.sec.value=curTime.getSeconds();
</script>
<table width="180" border="0" cellspacing="0" cellpadding="0" height="90%">
<tbody>
<tr>
	<td valign="top">
		<table width="180" border="0" cellspacing="0" cellpadding="0">
		<tbody><tr>
		   <td width="10" rowspan="2">&nbsp;</td>
		   <td>&nbsp;</td>
		</tr>
		<tr>
<td height="100" valign="top">
	<a href="tlmain.asp" target="main"><img src="file/r_2.gif" width="19" height="14" border="0" name="ImageR"><font face="Arial" size="4" class="menut"><script>dw(tools)</script><br></font></a>
<table width="180" border="0" cellspacing="0" cellpadding="2">
<tbody><tr>
<td nowrap="nowrap" width="15"><p>&nbsp;</p></td>
<td nowrap="nowrap" width="163">
<script>
<%  write("sDev = "+getIndex("sDev")+";");%>
if ( sDev == 1 ) {
document.write("<img src=\"file/p6.gif\" width=\"10\" height=\"10\" align=\"middle\">\n");
write("<a href=\"tlstorage.asp\" target=\"main\"><font size=\"2\" class=\"fontCr\">'+ showText(tlUsbStore) + '</a><br>\n");
}
</script>
<img src="file/p6.gif" width="10" height="10" align="middle">
	<a href="tlcon.asp" target="main"><font size="2" class="fontCr"><script>dw(cfgtools)</script></a><br>
<img src="file/p6.gif" width="10" height="10" align="middle">
<font size="2" face="Arial">
<a href="tlaccept.asp" target="main"><font size="2" class="fontCr"><script>dw(firewareUpgrade)</script></a><br>
<img src="file/p6.gif" width="10" height="10" align="middle">
<font size="2" face="Arial">
<a href="tlreset.asp" target="main"><font size="2" class="fontCr"><script>dw(reset)</script></a></font><br></font></font></td>
</tr>


<tr><table height="280" align="center" border="0" width="150"><tr><td align="center">
<a href="tlmenu.asp" target="lFrame"><b><font size="2" class="fontCr"><script>dw(currentTime)</script></b></a><br><font class="menut">
<script type="text/javascript">
	var d=new Date()
	
	var monthname=new Array("1","2","3","4","5","6","7","8","9","10","11","12");
	var dayname=new Array("1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31");
	
	document.write(monthname[document.tF0.mon.value] + "/")
	document.write(dayname[document.tF0.day.value-1] + "/")
	document.write(document.tF0.year.value)
</script>
                <span Id="clock" class="time"></span>
</font>
</font></td></tr></table></tr>

</tbody></table>
</td>
</tr>
</tbody></table>
</td>
</tr>
</tbody></table></form>
</body></html>
