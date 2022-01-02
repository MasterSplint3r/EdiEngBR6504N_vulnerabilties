<html>
<head>
<link rel="stylesheet" href="set.css">
<meta http-equiv="Content-Type" content="text/html;charset=utf-8">
<title>Wireless Site Survey</title>
<script language ="javascript" src ="javascript.js"></script>
<script language ="javascript" src ="file/wireless-n.var"></script>
<script>
var connectEnabled=0;
function verifyBrowser() {
  var ms = navigator.appVersion.indexOf("MSIE");
  ie4 = (ms>0) && (parseInt(navigator.appVersion.substring(ms+5, ms+6)) >= 4);
  var ns = navigator.appName.indexOf("Netscape");
  ns= (ns>=0) && (parseInt(navigator.appVersion.substring(0,1))>=4);
  if (ie4)
	return "ie4";
  else
	if(ns)
		return "ns";
	else
		return false;
}

function disableButton (button) {
  if (verifyBrowser() == "ns")
  	return;
  if (document.all || document.getElementById)
    button.disabled = true;
  else if (button) {
    button.oldOnClick = button.onclick;
    button.onclick = null;
    button.oldValue = button.value;
    button.value = 'DISABLED';
  }
}

function enableButton (button) {
  if (verifyBrowser() == "ns")
  	return;
  if (document.all || document.getElementById)
    button.disabled = false;
  else if (button) {
    button.onclick = button.oldOnClick;
    button.value = button.oldValue;
  }
}

function enableConnect()
{
  enableButton(document.formWlSiteSurvey.done);
  connectEnabled=1;
}

function connectClick()
{
  if (connectEnabled==1)
	return true;
  else
  	return false;
}

function loadonstart() {
    <%  write("sitesurveyed = "+getIndex("sitesurveyed"));%>
    if (sitesurveyed == 0) {
        disableButton(document.formWlSiteSurvey.refresh);
        document.searching.submit();
    }

    window.opener.reloadPage();
}

</script>
</head>
<body class="background" onLoad="window.opener.loadonstart();">
<blockquote>
<b><font class="titlecolor" size="4"><center><script>dw(wlss)</script></center></font></b><br>
<table width="520" border="0" cellspacing="0" cellpadding="0" align="center"><tr><td>
<p align="left"><font class="textcolor" size="2"><script>dw(wlss1)</script>
		    </font></p></td></tr></table><br>
			
<form action=/goform/formWlSiteSurvey method=POST name="searching">
    <input type="hidden" value="Refresh" name="refresh">
    <input type="hidden" value="/wlsurvey.asp" name="submit-url">
</form>

<form action=/goform/formWlSiteSurvey method=POST name="formWlSiteSurvey">
  <table width="520" border="1" cellspacing="0" cellpadding="0" align="center">
  <tr>
	<td align="center" width="30%" class="stable"><font size="2"><b><script>dw(SSID)</script></b></font></td>
	<td align="center" width="20%" class="stable"><font size="2"><b><script>dw(BSSID)</script></b></font></td>
	<td align="center" width="10%" class="stable"><font size="2"><b><script>dw(channel)</script></b></font></td>
	<td align="center" width="10%" class="stable"><font size="2"><b><script>dw(type)</script></b></font></td>
	<td align="center" width="10%" class="stable"><font size="2"><b><script>dw(encrypt)</script></b></font></td>
	<td align="center" width="10%" class="stable"><font size="2"><b><script>dw(signal)</script></b></font></td>
	<td align="center" width="10%" class="stable"><font size="2"><b><script>dw(select)</script></b></font></td>
  </tr>
  <% wlSiteSurveyTbl(); %>
  </table>
  <br><center>
<script>buffer='<input type="submit" value="'+showText(refresh)+'" name="refresh" class="btnsize">';document.write(buffer);</script>
<script>buffer='<input type="submit" value="'+showText(done)+'" name="done" onClick="return connectClick()" class="btnsize">';document.write(buffer);</script>
<script>buffer='<input type="button" value="'+showText(close)+'" onClick="window.close();" class="btnsize">';document.write(buffer);</script>
  <input type="hidden" value="/wlsurvey2.asp" name="submit-url">
 <script>
   	<% if (getIndex("wlanDisabled"))
     	  	write( "disableButton(document.formWlSiteSurvey.refresh);" );
 	 %>
	disableButton(document.formWlSiteSurvey.done);
 </script>
</form>

</blockquote>
</body>
</html>
