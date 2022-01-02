<html><head><title></title>
<link rel="stylesheet" href="set.css">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

<!-----------  This Is Added For Multi-language Webs   ------------>
<script language ='javascript' src ='javascript.js'></script>
<script language ='javascript' src ='file/fwwl-n.var'></script>

<script language="JavaScript">
function evaltF()
{
	if (document.wirelessseting.wlanDisabled[0].checked==true){
		parent.lFrame.showMenu(4,"enWl");
	}
	else {
		parent.lFrame.showMenu(4,"disWl");
	}
	return true;
}
</script>
</head>
<body class="background">
<blockquote>
  <form action=/goform/formWlEnable method=POST name="wirelessseting">
    <table width="90%" border="0" cellspacing="0" cellpadding="10" height="300" class="table4">
      <tbody>
        <tr> 
          <td valign="top"> 
            <p align="center"><font size="4" class="titlecolor"><script>dw(wlSettings)</script></font></p>
            <table width="520" border="0" cellspacing="0" cellpadding="0" align="center">
				<tr>
					<td><font class="textcolor" size="2"></font>	
					<font class="textcolor" size="2"><script>dw(wlInfo)</script>:&nbsp;&nbsp; </font>
              <input type="radio" name="wlanDisabled" value="yes"
                <% if (getIndex("wlanDisabled")==0) write("checked"); %> checked>
                <font class="textcolor" size="2"><script>dw(enable)</script></font>
              <input type="radio" name="wlanDisabled" value="no"
                <% if (getIndex("wlanDisabled")==1) write("checked"); %>>
                <font class="textcolor" size="2"><script>dw(disable)</script></font>
            		</td>
				</tr>
			</table>
            <p>
            </p>
          </td>
        </tr>
      </tbody>
    </table><br>
    <table width="520" border="0" cellspacing="0" cellpadding="0"  align="center">
      <tbody>
        <tr>
          <td align="right"> 
			<input type=hidden value="/wlmain.asp" name="wlan-url">
			<script>buffer='<input type="submit" value="'+showText(apply1)+'" onclick="return evaltF();" style ="width:100px">';document.write(buffer);</script>
          </td>
        </tr>
	</tbody>
    </table>
  </form>
</blockquote>
</body></html>
