<html>
<head>
<title>Statisitcs</title>
<link rel="stylesheet" href="set.css">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

<!--  Call the multiple languages text and the JavaScript document.  -->
    <script type="text/javascript" src="javascript.js"></script>
    <script type="text/javascript" src="file/statustool-n.var"></script>
    <script language="javascript" src="file/function.js"></script>
</head>

<body class="background">
<blockquote>

  
  
  <table border="0" width="520"  align="center">
	<tr>
		<td>
  <p align="center"><b><font class="titlecolor" size="4">
<script>dw(statStatistics)</script>
  </font></b></p>
		  <p><font class="textcolor" size="2"><script>dw(statStatisticsDoc)</script></font></p>
		</td>
	</tr>
	</table>
  
  


  <form action=/goform/formStats method=POST name="formStats">
    <table border="1" width="520" cellspacing="0" cellpadding="0" align="center">
<script>
<%	write("wlDev = "+getIndex("wlDev")+";");%>
if (wlDev!=0) {
document.write('<tr><td width="30%" class="stable" rowspan="2"><font size=2>' + showText(wirelessLAN) + '</font></td>');
document.write('<td width="30%" class="table2"><font size=2><i>' + showText(sentPackets) + '</i></font></td>');
document.write('<td width="20%" class="table2"><font size=2><% getInfo("wlanTxPacketNum"); %></font></td></tr>');

document.write('<tr><td class="table2"><font size=2><i>' + showText(receivedPackets) + '</i></font></td>');
document.write('<td class="table2"><font size=2><% getInfo("wlanRxPacketNum"); %></font></td></tr>');
}
</script>
      <tr>
        <td class="stable" rowspan="2"><font size=2><script>dw(ethernetLAN)</script></font></td>
        <td class="table2"><font size=2><i><script>dw(sentPackets)</script></i></font></td>
        <td class="table2"><font size=2><% getInfo("lanTxPacketNum"); %></font></td>
      </tr>
      <tr>
        <td class="table2"><font size=2><i><script>dw(receivedPackets)</script></i></font></td>
        <td class="table2"><font size=2><% getInfo("lanRxPacketNum"); %></font></td>
      </tr>
      
<script>

	<%  write(" apMode = "+getIndex("apRouterSwitch")+";");%>
	if( apMode !=1){
      
       document.write('<tr><td class="stable" rowspan="2"><font size=2>'+showText(ethernetWAN)+'</font></td>');
       document.write('<td class="table2"><font size=2><i>'+showText(sentPackets)+'</i></font></td>');
       document.write('<td class="table2"><font size=2><% getInfo("wanTxPacketNum"); %></font></td></tr>');
       document.write('<tr><td class="table2"><font size=2><i>'+showText(receivedPackets)+'</i></font></td>');
       document.write('<td class="table2"><font size=2><% getInfo("wanRxPacketNum"); %></font></td></tr>');
      
      }
</script>
      
    </table><br>
    <script>buffer='<input type ="submit" name ="refresh" style ="width:80px" value ="'+showText(refresh)+'">';document.write(buffer);</script>&nbsp;&nbsp;&nbsp;
    <input type="hidden" value="/stats.asp" name="submit-url">
  </form>
</body>
</html>