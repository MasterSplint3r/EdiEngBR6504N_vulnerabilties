<html>
<head>
<link rel="stylesheet" href="set.css">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>WAN QoS Settings</title>
<script type="text/javascript" src="javascript.js"></script>
<script type="text/javascript" src="file/qosnat-n.var"></script>
<script language="JavaScript" src="file/function.js"></script>
<script>

<% write("entryNum = "+getIndex("wan1QosNum")+";"); %>

function check_enable()
{
if( document.formWan1Qos.enabled2.checked==true )
	document.qosApply.enabled1.value = "ON";
}

function editClick(form)
{
	form.submitUrl.value = "/wanqosadd.asp";
	if (!checkNum(form))
		return false;
	return true;
}

function disableDelButton(form)
{
	form.delSelQos.disabled = true;
	form.delAllQos.disabled = true;
}


function replWeb() {
	if (entryNum < 16) {
		document.location.replace("wanqosadd.asp");
	}
	else {
		alert(showText(wanqosAlertRepWeb));
		return false;
	}
}


function checkNum(form) {
	//check_enable();
	var checkFlag = 0;
	for (var i=1; i<form.elements.length; i++) {
		if (form.elements[i].type == 'checkbox' ) {
			if (form.elements[i].checked == true)
				checkFlag++;
		}
		if (checkFlag >= 2) {
			alert(showText(wanqosAlertChkNum));
			return false;
		}
	}
	return true;
}
function clickapply()
{
	//check_enable();
	//document.qosApply.ApplyQos.value = "Apply";
	document.qosApply.maxdown.value = document.formWan1Qos.maxdown.value;
	document.qosApply.maxup.value = document.formWan1Qos.maxup.value;
	document.qosApply.submit();
}

function Clickdelete()
{
	//check_enable();
	return deleteClick();
}

function ClickdeleteAll()
{
	//check_enable();
	return deleteAllClick();
}

function test()
{
<% write("NewPage = "+getIndex("newpage"));%>
<% write("Changed = "+getIndex("Changed"));%>
	
	if ( Changed == "1" ) {
		//document.location.reload();
		alert(showText(wanqosAlertTestCha));
	}

//	if ( applyandreboot == 0 )
//		parent.lFrame.document.apply_reboot.config.disabled = true;
//	else
//		parent.lFrame.document.apply_reboot.config.disabled = false;
	
//	if( NewPage == "1" )
//		alert(" new page ");
}

function goToWeb() {
	if (document.formWan1Qos.enabled2.checked==true)
		document.formQoSEnabled.enabled1.value="ON";
	document.formQoSEnabled.submit();
}

</script>
</head>

<!-- <body class="background" onload="test()"> -->
<body class="background">
<blockquote>
  
              
<table border="0" width="520"  align="center">
	<tr>
		<td>
<p align="center"><b><font class="titlecolor" size="4"><script>dw(qos)</script> </font></b></p>
<p align="left"><font class="textcolor" size="2"><script>dw(qosInfo)</script><br>
</font></p>
		
		</td>
	</tr>
</table>
              
<div align="center">
              
<table border="1" width=520 cellspacing="0" cellpadding="0">

<form action=/goform/formQoS method=POST name="formQoSEnabled">
	<input type="hidden" value="ON" name="isEnabled">
	<input type="hidden" value="" name="enabled1">
	<input type="hidden" value="/wanqos.asp" name="submitUrl">
</form>

<form action=/goform/formQoS method=POST name="formWan1Qos">
<tr>
	<td colspan="5">
	<font size=2 class="textcolor">
		<input type="checkbox" name="enabled2" value="ON" <% if (getIndex("wan1QosEnabled")) write("checked");%> onClick="goToWeb();"><script>dw(qosEnable);</script><br>
	</td>

</tr>

<tr>
<td colspan="2" class="table2" ><font size=2><script>dw(qosdoband);</script>:&nbsp;</td>
<td colspan="3" class="table2" >&nbsp;<input type="text" name="maxdown" size="8" maxlength="8" value="<% getInfo("maxdownbandwidth"); %>">&nbsp;kbits
</td>
</tr>

<tr>
<td colspan="2" class="table2" ><font size=2><script>dw(qosupband);</script>:&nbsp;</td>
<td colspan="3" class="table2" >&nbsp;<input type="text" name="maxup" size="8" maxlength="8" value="<% getInfo("maxupbandwidth"); %>">&nbsp;kbits
</td>
</tr>

<tr>

<td colspan="2"><font size=2><script>dw(qosTable);</script>
</font>
</td>
<td colspan="3"> &nbsp;
</td>
</tr>

<tr class="stable">
	<td width="10%"><font size=2><script>dw(qosPrior);</script></td>
	<td width="30%"><font size=2><script>dw(qosName);</script></td>
	<td width="25%"><font size=2><script>dw(qosUpload);</script></td>
	<td width="25%"><font size=2><script>dw(qosDnload);</script></td>
	<td width="10%"><font size=2><script>dw(qosSelect);</script></td>
</tr>
<% Wan1QosList(); %>
</table>
</div>
<br>



<table border="0" width="520" align="center">
	<tr>
		<td>
		<script>buffer='<input type="button" name="addQos" value="'+showText(add)+'" onClick="replWeb();"  class="btnsize">';document.write(buffer);</script>&nbsp;
<script>buffer='<input type="submit" name="showQos" value="'+showText(edit)+'" onClick="return editClick(document.formWan1Qos);"  class="btnsize">&';document.write(buffer);</script>nbsp;
<script>buffer='<input type="submit" name="delSelQos" value="'+showText(deleteSelected)+'" onClick="return Clickdelete()"  class="btnsize">';document.write(buffer);</script>&nbsp;
<script>buffer='<input type="submit" name="delAllQos" value="'+showText(deleteAll)+'" onClick="return ClickdeleteAll()"  class="btnsize">';document.write(buffer);</script>&nbsp;
<script>buffer='<input type="submit" name="moveUpQos" value="'+showText(moveUp)+'" onClick="return checkNum(document.formWan1Qos);"  class="btnsize">';document.write(buffer);</script>&nbsp;
<script>buffer='<input type="submit" name="moveDownQos" value="'+showText(moveDown)+'" onClick="return checkNum(document.formWan1Qos);"  class="btnsize">';document.write(buffer);</script>&nbsp;
<script>buffer='<input type="reset" name="reset" value="'+showText(reset)+'"  class="btnsize">';document.write(buffer);</script>
<input type="hidden" value="/wanqos.asp" name="submitUrl">
<input type="hidden" value="1" name="configWan">
<!--<input type="hidden" value=<% if (getIndex("wan1QosEnabled")) write("ON");%> name="enabled1">-->
<script>
//qosBtnTxt(document.formWan1Qos);
<% entryNum = getIndex("wan1QosNum");
	if ( entryNum == 0 ) {
		write( "disableDelButton(formWan1Qos);" );
} %>
</script>

		
		
		</td>
	</tr>
</table>
</form>

<br>
<form action=/goform/formQoS method=POST name="qosApply">                 
<table width="520" border="0" cellspacing="0" cellpadding="0" align="center">
<tr>
	<td align="right">
		<script>buffer='<input type=submit value="'+showText(apply1)+'" onclick="clickapply()" style ="width:100px">';document.write(buffer);</script>
		<input type="hidden" value="/wanqos.asp" name="submitUrl">
		<script>buffer='<input type=button value="'+showText(cancel1)+'" style ="width:100px" onClick="window.location.reload()">';document.write(buffer);</script>
		<input type="hidden" value="1" name="isApply">
		<input type="hidden" name="maxup">
		<input type="hidden" name="maxdown">
		<!--<input type="hidden" value=<% if (getIndex("wan1QosEnabled")) write("ON");%> name="enabled1">-->
	</td>
</tr>
</table>
</form>

</blockquote>
</body>
</html>