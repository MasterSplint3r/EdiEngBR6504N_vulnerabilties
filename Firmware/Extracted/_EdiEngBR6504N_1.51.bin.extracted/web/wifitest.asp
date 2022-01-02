<html><head>
<meta http-equiv="Content-Language" content="zh-tw">
<title></title>
<link rel="stylesheet" href="set.css">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

<!-----------  This Is Added For Multi-language Webs   ------------>
<script language ='javascript' src ='javascript.js'></script>
</head>
<body class="background">
<blockquote>
  <form action=/goform/formWifiEnable method=POST name="WifiSetting">

	<div align="center">
		<table border="0" width="520" id="table1" cellspacing="3">
			<tr>
			<td width="93"  class="table1" ><font size="2">WiFi Test : </font> </td>
			<td  class="table2" ><font size="2">&nbsp;<input type="radio" value="YES" name="wifitest"  <% if (getIndex("wifitest")==1) write("checked"); %>>Enable 
			<input type="radio" value="NO"  name="wifitest" <% if (getIndex("wifitest")==0) write("checked"); %>> Disable</font></td>
			</tr>
		</table>
				<input type="hidden" value="/wifitest.asp" name="submit-url">
		<p><input type="submit" value="Apply" name="Apply"></div>

  </form>
</blockquote>

</body></html>