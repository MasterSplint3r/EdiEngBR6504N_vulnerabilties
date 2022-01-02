<html><head>
<meta http-equiv="Content-Language" content="zh-tw">
<title>Wps Device Configure</title>
<link rel="stylesheet" href="set.css">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

<!-----------  This Is Added For Multi-language Webs   ------------>
<script language ='javascript' src ='javascript.js'></script>
<script language ='javascript' src ='file/fwwl-n.var'></script>
<script language ='javascript'>
function goToWeb(){


		document.Wpsseting.submit();

}
function configChange(index){
if ( index == 0 ) {

	document.WpsDevice.pinCode.disabled = false;

  }
  else {
  
	document.WpsDevice.pinCode.disabled = true;
  }

}

function checkValue(str) {
   for (var i=0; i<str.length; i++) {
    if ( (str.charAt(i) >= '0' && str.charAt(i) <= '9'))
			continue;
	alert(showText(wpsAlertInvPin));
	return 0;
  }
  return 1;
}
function checkPin(){

	
if(document.WpsDevice.configOption.value == "pin"){

 if (document.WpsDevice.pinCode.value.length ==0){
 	alert("Pin Code Value should be set at least 8 characters");
  	
  	return 0;
	}
  if ( document.WpsDevice.pinCode.value.length != 8) {
			alert("Pin Code Value should be set at least 8 characters");
			
			return 0;
  		}

	}
	return 1;
}
function saveChanges(mode){
	configMode=document.WpsDevice.confMode.selectedIndex;
	
	if(configMode!=1){
		if(mode == 1){
		//PIN
			if( checkPin() ==0){
				document.WpsDevice.pinCode.focus();
				return false;	
			}
			if( checkValue(document.WpsDevice.pinCode.value) == 0){
				document.WpsDevice.pinCode.focus();
				return false
			}
			document.WpsDevice.configOption.value="pin";
		}
		else if(mode == 2){//PBC
			document.WpsDevice.configOption.value="pbc";
			alert("You must go to station side to push it button within two minute.");
		
		}
	}else{
		alert("You can configure AP using external registrar .");
	}
	document.WpsDevice.startPin.disabled = true;    
	document.WpsDevice.startPbc.disabled = true;
	countDown(mode);
	document.WpsDevice.submit();
	return true;
	
}
function changeMode(){
	mode=document.WpsDevice.confMode.selectedIndex;
	if(mode==0){
		document.WpsDevice.pinCode.disabled=false;
	}
	else if(mode==1){
		document.WpsDevice.pinCode.value="";
		document.WpsDevice.pinCode.disabled=true;

		
	}

}


var secs = 120; var wait = secs * 1000; 

function countDown(mode){
	for(i = 1; i <= secs; i++) { 
		setTimeout("update(" + i + ","+mode+")", i * 1000); 
	} 
}

function update(num,mode) { 
	document.WpsDevice.startPin.disabled = true;    
	document.WpsDevice.startPbc.disabled = true;
	if(mode == 1){
	//PIN
		if (num == (wait/1000)) { 
		document.WpsDevice.startPin.value = showText(wpsStartpin); 
		} else { printnr = (wait / 1000)-num; 
		document.WpsDevice.startPin.value =   printnr + " sec."; 
		}
	}
	else{
	//PBC
		if (num == (wait/1000)) { 
		document.WpsDevice.startPbc.value = showText(wpsStartPbc); 
		} else { printnr = (wait / 1000)-num; 
		document.WpsDevice.startPbc.value =  printnr + " sec."; 
		}
	}

} 


</script>
</head>
<body class="background">
<blockquote>
<div align="center">
	<table border="0" width="520" id="table1" cellspacing="0" cellpadding="0">
		<tr>
			<td>
<p align="center"><font size="4" class="titlecolor"> <script>dw(wpsSetting)</script></font></p>
   <p align="left"><font class="textcolor"  size="2">
<script>dw(wpsInfo)</script>
  </font></p>

			
			
			</td>
		</tr>
	</table>
</div>
  <form action=/goform/formWpsEnable method=POST name="Wpsseting">
    <div align="center">
    <table width="520" border="0" cellspacing="1" cellpadding="0">
      <tbody>
        <tr> 
          <td valign="top">           

              <input type="checkbox" name="wpsEnable"  value="ON" onClick="goToWeb();" <% if (getIndex("wpsEnable")==1)  write("checked ");%> >
              <b><font size="2"> <script>dw(enable) </script> WPS</font></b><font size="2">
				</font>
          	<input type=hidden value="/wpsconfig.asp" name="wlan-url">
          </td>
        </tr>
      </tbody>
    </table>
   	</div>
   </form>
    
   <form name="wpsConfig" method="post" action=/goform/formWpsConfig>

      <div align="center">
<table border="0" width="520" id="table2" cellspacing="0" cellpadding="0">
	<tr>
		<td>
		<B><font size="2"><li><script type="text/javascript">dw(wpsSetupInfo)</script></li>
		</td>
	</tr>
</table>
      <table border="1" cellspacing="0" width="520" cellpadding="0">


        <tr>
          <td width="35%" class="table2"><font size="2"><script type="text/javascript">dw(wspStatus)</script>&nbsp;</font></td>
          <td width="65%" class="table2" style="text-align: left"><font size="2">&nbsp;<% if (getIndex("wpsConfigType")==0) write("unConfigured"); else write("Configured");%></font></td>
        </tr>

        <tr>
          <td class="table2" height="23"><font size="2"><script type="text/javascript">dw(wpsPinCode)</script>
			&nbsp;</font></td>
          <td class="table2" height="23" style="text-align: left"><font size="2">&nbsp;<%getInfo("pinCode");%></font></td>
        </tr>
		<tr>
          <td width="35%" class="table2" height="27">
			<font size="2"><script type="text/javascript">dw(ssid)</script>&nbsp;</font></td>
          <td width="65%" class="table2" height="27" style="text-align: left"><font size="2">&nbsp;<script>document.write("<% getInfo("ssid"); %>");</script></font></td>
        </tr>
		<tr>
          <td width="35%" class="table2">
			<font size="2"><script type="text/javascript">dw(authMode)</script></font></td>
          <td width="65%" class="table2" style="text-align: left"><font size="2">
            &nbsp;<script>
              <% write("methodVal = "+getIndex("encrypt")+";");%>
              var modeTbl = new Array("Disable","WEP","WPA pre-shared key","WPA RADIUS");
              document.write(modeTbl[methodVal]);
            </script>
          </font>
          </td>
    
        	</tr>
        	</tr>
        <tr>
         <td width="35%" class="table2">
			<font size="2"><script type="text/javascript">dw(psKey)</script>&nbsp;</font></td>
          <td width="65%" class="table2" height="23"><font size="2">&nbsp;<% if (getIndex("wpsDisplayKey")==1)   getInfo("wpsPskValue"); else getInfo("pskValue");%>
         </font></td>
        </tr>


		<input type=hidden value="/wpsconfig.asp" name="wlan-url">
        </tr>
      </table>
    	</div>
    </form>

    <form action=/goform/formWpsStart method=POST name="WpsDevice">
      <div align="center">
      
      <table border="0" width="520" id="table3" cellspacing="0" cellpadding="0">
		<tr>
			<td>
			        <B><font size="2"><li><script type="text/javascript">dw(deviceConfigure)</script></li>
			</td>
		</tr>
		</table>
      <table border="1" cellspacing="0" width="520">
        <tr>
          <td width="41%" class="table2" height="23"><font size="2"><script>dw(configMode)</script>:</font></td>
            <td class="table2" height="23" style="text-align: left"> 
            
            
            <select size="1" name="confMode" onchange="changeMode()">
			<option value="0" <% choice = getIndex("wpsConfigMode"); if (choice == 0) write("selected"); %>>Registrar</option>
			<option value="1" <% choice = getIndex("wpsConfigMode"); if (choice == 1) write("selected"); %>>Enrollee</option>
			</select></td>
        </tr>
        <tr>
          <td width="41%" class="table2" height="23"><font size="2"><script>dw(wpsPubMode)</script>:</font></td>
            <td class="table2" height="23" style="text-align: left"> 
            
            
            <input type=hidden value="pin" name="configOption">
      		<script>buffer ='<input type="button" name="startPbc" value="'+showText(wpsStartPbc)+'" onclick="return saveChanges(2);"  style ="width:80px">'; document.write(buffer);</script>

			
			
			</td>
        </tr>
        <tr>
          <td width="41%" class="table2" height="27"><font size="2"><script type="text/javascript">dw(wpsPinMode) </script>:</font></td>
          <td width="56%" class="table2" height="27" style="text-align: left">
			
			<font size="2">
			
			<script></script></font><input type="text" name="pinCode" size="15" maxlength="8">
			
			<script>buffer ='<input type="button" name="startPin" value="'+showText(wpsStartpin)+'" onclick="return saveChanges(1);"  style ="width:80px">'; document.write(buffer);</script>

			</td>
        </tr>
                <tr>
         <td align="center" colspan="2" >
       	</td>
      	</td>
      	</tr>
      </table>

      </div>

      </table>

      <table width="300" border="0" cellspacing="0" cellpadding="0" align="right">
        <tr>

        </tr>
      </table>

   
    <table width="300" border="0" cellspacing="0" cellpadding="0" align="right">
      <tbody>
        <tr>
          <td align="right"> 
			<input type=hidden value="/wpsconfig.asp" name="wlan-url">
          </td>
        </tr>
	</tbody>
    </table>
  </form>
   </blockquote>
</body></html>