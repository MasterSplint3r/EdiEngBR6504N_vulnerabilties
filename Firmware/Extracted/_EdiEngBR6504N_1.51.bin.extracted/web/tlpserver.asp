<html><head><title>PrinterServer Setting</title>
<link rel="stylesheet" href="set.css">
<meta http-equiv="content-type" content="text/html; charset=iso-8859-1">
<script language="JavaScript">
function checkmode()
{
	var test = document.formWep.urllist.options[document.formWep.urllist.selectedIndex].value;
	document.location.replace(test);
}

function PSCheckEnable() {
    if (document.formPS.PSEnable[0].checked==false) {
        document.formPS.PS_IPPEnable[0].disabled = true;
        document.formPS.PS_IPPEnable[1].disabled = true;
        document.formPS.PS_LPREnable[0].disabled = true;
        document.formPS.PS_LPREnable[1].disabled = true;
        document.formPS.PSName.disabled = true;
        document.formPS.PS_Port1Name.disabled = true;
        document.formPS.PS_Port2Name.disabled = true;
    }
    else{
        document.formPS.PS_IPPEnable[0].disabled = false;
        document.formPS.PS_IPPEnable[1].disabled = false;
        document.formPS.PS_LPREnable[0].disabled = false;
        document.formPS.PS_LPREnable[1].disabled = false;
        document.formPS.PSName.disabled = false;
        document.formPS.PS_Port1Name.disabled = false;
        document.formPS.PS_Port2Name.disabled = false;
    }
}
</script></head>
<body class="background">
<blockquote>
<form action=/goform/formPSSetup method=POST name="formPS">
<p align="center"><b><font class="titlecolor" size="4">Print Server</font></b></p>
<div align="center">
	<table border="0" width="520" cellspacing="0" cellpadding="0" id="table1">
		<tr>
			<td><font class="textcolor" size="2">
The print server provides LPR and IPP printing methods.
You can enable/disable the print server function and change the print server name here.
Please assign printer queue name for each printer connected to the USB port.
</font></td>
		</tr>
	</table>
</div><br>
<table width="520" border="0" cellspacing="0" cellpadding="0" align="center">
  <tbody><tr>
    <td valign="top" height="235">
      <table width="520" border="1" cellspacing="0" cellpadding="5" align="center">
        <tbody>
	  <tr>
    	<td valign="top" class="table2" nowrap="nowrap">
	    <font size="2">PrintServer Feature :</font>
	  	</td>
	  	<td nowrap="nowrap" class="ltable">
          <input type=radio value="yes" name="PSEnable" onClick="PSCheckEnable();" <% if (getIndex("PSEnable")==1) write("checked"); %>><font size="2">ENABLE&nbsp;&nbsp;</font>
	  	  <input type=radio value="no" name="PSEnable" onClick="PSCheckEnable();" <% if (getIndex("PSEnable")==0) write("checked"); %>><font size="2">DISABLE</font>
	  	</td>
    </tr>
    <tr>
    	<td valign="top" class="table2" nowrap="nowrap">
	    <font size="2">IPP :</font>
	  	</td>
	  	<td nowrap="nowrap" class="ltable">
          <input type=radio  value="yes" name="PS_IPPEnable" <% if (getIndex("PS_IPPEnable")==1) write("checked"); %>><font size="2">ENABLE&nbsp;&nbsp;</font>
	  	  <input type=radio  value="no" name="PS_IPPEnable" <% if (getIndex("PS_IPPEnable")==0) write("checked"); %>><font size="2">DISABLE</font>
	  	</td>
    </tr>
    <tr>
    	<td valign="top" class="table2" nowrap="nowrap">
	    <font size="2">LPR :</font>
	  	</td>
	  	<td nowrap="nowrap" class="ltable">
          <input type=radio  value="yes" name="PS_LPREnable" <% if (getIndex("PS_LPREnable")==1) write("checked"); %>><font size="2">ENABLE&nbsp;&nbsp;</font>
	  	  <input type=radio  value="no" name="PS_LPREnable" <% if (getIndex("PS_LPREnable")==0) write("checked"); %>><font size="2">DISABLE</font>
	  	</td>
    </tr>
	<tr>
		<td valign="top" class="table2" nowrap="nowrap">
            <font size=2>PrinterServer Name :</font>
        </td>
		<td nowrap="nowrap" class="ltable">&nbsp;
          <input type="text" name="PSName" size="20" maxlength="47" value="<% getInfo("PSName"); %>">
        </td>
	</tr>
	<tr>
		<td valign="top" class="table2" nowrap="nowrap">
            <font size=2>Port Name 1 :</font>
        </td>
		<td nowrap="nowrap" class="ltable">&nbsp;
          <input type="text" name="PS_Port1Name" size="20" maxlength="47" value="<% getInfo("PS_Port1Name"); %>">
        </td>
	</tr>
	<tr>
		<td valign="top" class="table2" nowrap="nowrap">
            <font size=2>Port Name 2 :</font>
        </td>
		<td nowrap="nowrap" class="ltable">&nbsp;
          <input type="text" name="PS_Port2Name" size="20" maxlength="47" value="<% getInfo("PS_Port2Name"); %>">
        </td>
	</tr>
      </tbody></table>
    </td>
  </tr></tbody></table>
<script>
PSCheckEnable();
</script>
<table width="520" border="0" cellspacing="0" cellpadding="0" align="center">
<tr><td align="right">
       	    <input type="image" src="file/apply1.gif" onClick="return true" width="105" height="30" border="0">
	    <input type="hidden" value="/tlpserver.asp" name="submit-url">
            <a href="javascript:window.location.reload()"><img src="file/cancel.gif" alt="" border="0" width="105" height="30"></a>
</td></tr>
</table>
</form>
</blockquote>
</body></html>
