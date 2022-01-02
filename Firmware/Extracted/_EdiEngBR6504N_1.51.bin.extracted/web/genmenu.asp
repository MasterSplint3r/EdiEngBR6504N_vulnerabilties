<html><head><title></title>               
<link rel="stylesheet" href="set.css">
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
    <script type="text/javascript" src="file/netsys-n.var"></script>

  <script language="JavaScript">
    var feature_func = 1;
    var operation_func = 1;

    function MM_swapImgRestore() { 
	var i,x,a=document.MM_sr; 
      for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++)
        x.src=x.oSrc;
     }

    function MM_preloadImages() { 
      var d=document; 
      if(d.images){ 
        if(!d.MM_p) d.MM_p=new Array();
        var i,j=d.MM_p.length,a=MM_preloadImages.arguments;
        for(i=0; i<a.length; i++)
          if (a[i].indexOf("#")!=0){ 
             d.MM_p[j]=new Image; 
             d.MM_p[j++].src=a[i];
            }
        }
    }

   function MM_findObj(n, d) { 
     var p,i,x;  
     if(!d) d=document; 
     if((p=n.indexOf("?"))>0&&parent.frames.length) {
       d=parent.frames[n.substring(p+1)].document; 
       n=n.substring(0,p);
       }
     if(!(x=d[n])&&d.all) 
       x=d.all[n]; 
     for (i=0;!x&&i<d.forms.length;i++) 
       x=d.forms[i][n];
     for(i=0;!x&&d.layers&&i<d.layers.length;i++) 
       x=MM_findObj(n,d.layers[i].document);
     if(!x && document.getElementById) 
       x=document.getElementById(n); 
     return x;
   }

   function MM_swapImage() { 
     var i,j=0,x,a=MM_swapImage.arguments; 
     document.MM_sr=new Array; 
     for(i=0;i<(a.length-2);i+=3)
       if ((x=MM_findObj(a[i]))!=null){
         document.MM_sr[j++]=x; 
         if(!x.oSrc) x.oSrc=x.src; 
         x.src=a[i+2];
       }
   }
   <%  write("genEnabled = "+getIndex("genEnabled")+";");%>
   <%  write("wlanDisabled = "+getIndex("wlanDisabled")+";");%>
   <%  write("FirewallEnable = "+getIndex("FirewallEnable")+";");%>
   <%  write("natEnable = "+getIndex("natEnable")+";");%>
   <%  write("WIspEnable = "+getIndex("opMode")+";");%>

   function showMenu(val, enable) {
     var pageTbl = new Array("sysmain.asp","wanmain.asp","wanqos.asp","lan.asp","wlmain.asp","natmain.asp","fwmain.asp","nono.asp");
     var showEnSys = new Array("block","none","none","none","none","none","none","none");
     var showEnWan = new Array("none","block","none","none","none","none","none","none");
     var showEnQos = new Array("none","none","block","none","none","none","none","none");
     var showEnLan = new Array("none","none","none","block","none","none","none","none");
     var showEnWl =  new Array("none","none","none","none","block","none","none","none");
     var showEnNat = new Array("none","none","none","none","none","block","none","none");
     var showEnFw =  new Array("none","none","none","none","none","none","block","none");
     var showEnPs =  new Array("none","none","none","none","none","none","none","block");
     var showEnWps =  new Array("none","none","none","none","none","none","none","none");

     var showDisSys = new Array("none","block","block","block","block","block","block","block");
     var showDisWan = new Array("block","none","block","block","block","block","block","block");
     var showDisQos = new Array("block","block","none","block","block","block","block","block");
     var showDisLan = new Array("block","block","block","none","block","block","block","block");
     var showDisWl  = new Array("block","block","block","block","none","block","block","block");
     var showDisNat = new Array("block","block","block","block","block","none","block","block");
     var showDisFw  = new Array("block","block","block","block","block","block","none","block");
     var showDisPs  = new Array("block","block","block","block","block","block","block","none");
     var showDisWps = new Array("block","block","block","block","block","block","block","block");
     if (enable=="disWl")	 wlanDisabled=1;
	 else if (enable=="enWl")	 wlanDisabled=0;
     if (enable=="enNat")	 natEnable=1;
	 else if (enable=="disNat") natEnable=0;
     if (enable=="enFw") 	 FirewallEnable=1;
	 else if (enable=="disFw")  FirewallEnable=0;
     if (enable=="enWIsp") WIspEnable=1;
	 else if (enable=="disWIsp") WIspEnable=0; 

	
     for (i=0; i<=8; i++) {
	 if (val==i) {
	   document.getElementById('sysActId').style.display = showEnSys[i];
	   //document.getElementById('wanActId').style.display = showEnWan[i];
	   document.getElementById('qosActId').style.display = showEnQos[i];
	   document.getElementById('lanActId').style.display = showEnLan[i];

	   if (WIspEnable==1) {
	     document.getElementById('wanActEnId').style.display = showEnWan[i];
	     document.getElementById('wanActDisId').style.display = "none";
	   }
	   else {
	     document.getElementById('wanActDisId').style.display = showEnWan[i];
	     document.getElementById('wanActEnId').style.display = "none";
	   }
			
	   if (wlanDisabled==1) {
	     document.getElementById('wlActDisId').style.display = showEnWl[i];
	     document.getElementById('wlActEnId').style.display = "none";
	    }
	   else {
	     document.getElementById('wlActDisId').style.display = "none";
	     document.getElementById('wlActEnId').style.display = showEnWl[i];
	   }

	   if (natEnable==1) {
	     document.getElementById('natActEnId').style.display = showEnNat[i];
	     document.getElementById('natActDisId').style.display = "none";
	   }
	  else {
	    document.getElementById('natActDisId').style.display = showEnNat[i];
	    document.getElementById('natActEnId').style.display = "none";
	   }

	  if (FirewallEnable==1) {
	    document.getElementById('fwActEnId').style.display = showEnFw[i];
	    document.getElementById('fwActDisId').style.display = "none";
	   }
	  else {
	    document.getElementById('fwActDisId').style.display = showEnFw[i];
	    document.getElementById('fwActEnId').style.display = "none";
	   }
		

		
		
	   //document.getElementById('psActId').style.display = showEnPs[i];
	   document.getElementById('psActId').style.display = "none";

	   document.getElementById('sysDisId').style.display = showDisSys[i];
	   document.getElementById('wanDisId').style.display = showDisWan[i];
	   document.getElementById('lanDisId').style.display = showDisLan[i];
	   document.getElementById('qosDisId').style.display = showDisQos[i];
	   document.getElementById('wlDisId').style.display = showDisWl[i];
	   document.getElementById('natDisId').style.display = showDisNat[i];
	   document.getElementById('fwDisId').style.display = showDisFw[i];
	   //document.getElementById('psDisId').style.display = showDisPs[i];
	   document.getElementById('psDisId').style.display = "none";

	   }
         }
     if (enable=="")
	parent.main.location.replace(pageTbl[val]);
	
	modeSelect(0)
   }

	function modeSelect(onLoad){
		 
			<%  write(" apMode = "+getIndex("apRouterSwitch")+";");%>

		if(apMode == 0 ){
			//gwMode
			if(onLoad==1){
			document.getElementById('wanDisId').style.display="block";

			document.getElementById('natDisId').style.display="block";

			document.getElementById('fwDisId').style.display="block";
			
			document.getElementById('qosDisId').style.display="block";
			
			}
	
		}
		else{
			//apMode
			document.getElementById('wanDisId').style.display="none";
			document.getElementById('wanActDisId').style.display="none";
			document.getElementById('wanActEnId').style.display ="none";
			
			
			document.getElementById('natDisId').style.display="none";
			document.getElementById('natActDisId').style.display="none";
			document.getElementById('natActEnId').style.display ="none";	
			
			document.getElementById('fwDisId').style.display="none";
			document.getElementById('fwActEnId').style.display="none";
			document.getElementById('fwActEnId').style.display ="none";	
			
			document.getElementById('qosDisId').style.display="none";
		
		
		}
		

		
	}
 </script></head>
 <body class="subbg2" onLoad="modeSelect(1)" background="file/back-b2.gif"><br>
   <form action="/goform/formSYSSetup" method="POST" name="systemMode"><br>
     <table width="150" border="0" cellspacing="0" cellpadding="0" height="80%">
       <tr>
         <td valign="top">
         
         <span id="sysActId" style="display:none">
            <table><tr>
             <td>
	        <a href='javascript:showMenu(0,"");'>
                <img src="file/r_2.gif" width="18" height="14" border="0" name="Image1">
                <font size="4" class="menut"><script>dw(system)</script></font>
              </a>
	        <table width="140" border="0">
              <tr>
	          <td nowrap="nowrap" width="10"></td>
                <td nowrap="nowrap" width="140">
	           <img src='file/p6.gif' width='10' height='10' align='middle'>
	             <a href='systimezone.asp' target='main'><font size='2' class='fontCr'>
                     <script>dw(timeZone)</script>
                   </a><br>
	           
                 <img src='file/p6.gif' width='10' height='10' align='middle'>
	             <a href='syspasswd.asp' target='main'><font size='2' class='fontCr'>
                      <script>dw(passSet)</script>
                    </a><br>                        
	           <img src='file/p6.gif' width='10' height='10' align='middle'>
	              <a href='sysrm.asp' target='main'><font size='2' class='fontCr'>
                    <script>dw(RemoteM)</script>
                    </a>
	           </td></tr></table>
         </td></tr></table></span>
         <span id="sysDisId">
           <table><tr><td>
	       <a href='javascript:showMenu(0,"");' onmouseout="MM_swapImgRestore()" onmouseover='MM_swapImage("Image11","","file/r_1.gif",1)'>
               <img src="file/r.gif" width="18" height="14" border="0" name="Image11">
               <font face="Arial" size="4" class='menut'>
               <script>dw(system)</script>
              </font></a>
         </td></tr></table></span>

         <span id="wanActEnId" style='display:none'>
           <table><tr><td>
	       <a href='javascript:showMenu(1,"");'>
               <img src="file/r_2.gif" width="18" height="14" border="0" name="Image2">
               <font size="4"class="menut">
               <script>dw(wan)</script>
              <br></font></a>
	        <table width="140" border="0"><tr>
	           <td nowrap="nowrap" width="10"></td>
                 <td nowrap="nowrap" width="136">
	             <img src='file/p6.gif' width='10' height='10' align='middle'>
	             <a href='wandip.asp' target='main'><font size='2' class='fontCr'>
		         <script>dw(DynamicIP)</script>
                    </a><br>
	              <img src='file/p6.gif' width='10' height='10' align='middle'>
	              <a href='wansip.asp' target='main'><font size='2' class='fontCr'>
		          <script>dw(StaticIP)</script>
	              </a><br>
	              <img src='file/p6.gif' width='10' height='10' align='middle'>
	              <a href='wanpppoe.asp' target='main'><font size='2' class='fontCr'>
                       <script>dw(PPPoE)</script>
                    </a><br>
	              <img src='file/p6.gif' width='10' height='10' align='middle'>
	              <a href='wanpptp.asp' target='main'><font size='2' class='fontCr'>
                     <script>dw(PPTP)</script></a><br>
	              <img src='file/p6.gif' width='10' height='10' align='middle'>
	              <a href='wanl2tp.asp' target='main'><font size='2' class='fontCr'>
                     <script>dw(L2TP)</script></a><br>
	              <img src='file/p6.gif' width='10' height='10' align='middle'>
	              <a href='wantelstra.asp' target='main'><font size='2' class='fontCr'>
                    <script>dw(TelBP)</script></a><br>
	              <img src='file/p6.gif' width='10' height='10' align='middle'>
	              <a href='wandns.asp' target='main'><font size='2' class='fontCr'>
                     <script>dw(DNS)</script></a><br>
	              <img src='file/p6.gif' width='10' height='10' align='middle'>
	              <a href='wanddns.asp' target='main'><font size='2' class='fontCr'>
                     <script>dw(DDNS)</script></a>
	           </td></tr></table>
         </td></tr></table></span>

         <span id="wanActDisId" style='display:none'>
         <table><tr>
           <td>
	      <a href='javascript:showMenu(1,"");'>
            <img src="file/r_2.gif" width="18" height="14" border="0" name="Image2">
              <font size="4"class="menut">
              <script>dw(wan)</script>
            </font></a>
	      <table width="140" border="0"><tr>
	        <td nowrap="nowrap" width="10"></td>
              <td nowrap="nowrap" width="136">
	          <img src='file/p6.gif' width='10' height='10' align='middle'>
	          <a href='wandip.asp' target='main'><font size='2' class='fontCr'>
		      <script>dw(DynamicIP)</script>
	          </a><br>
	          <img src='file/p6.gif' width='10' height='10' align='middle'>
	          <a href='wansip.asp' target='main'><font size='2' class='fontCr'>
		      <script>dw(StaticIP)</script>
	          </a><br>
	          <img src='file/p6.gif' width='10' height='10' align='middle'>
	          <a href='wanpppoe.asp' target='main'><font size='2' class='fontCr'>
		      <script>dw(PPPoE)</script>
	          </a><br>
	          <img src='file/p6.gif' width='10' height='10' align='middle'>
	          <a href='wanpptp.asp' target='main'><font size='2' class='fontCr'>
    	            <script>dw(PPTP)</script>
	          </a><br>
	          <img src='file/p6.gif' width='10' height='10' align='middle'>
	          <a href='wanl2tp.asp' target='main'><font size='2' class='fontCr'>
		      <script>dw(L2TP)</script>
	          </a><br>
	          <img src='file/p6.gif' width='10' height='10' align='middle'>
	          <a href='wantelstra.asp' target='main'><font size='2' class='fontCr'>
		      <script>dw(TelBP)</script></a><br>
	          <img src='file/p6.gif' width='10' height='10' align='middle'>
	          <a href='wandns.asp' target='main'><font size='2' class='fontCr'>
		      <script>dw(DNS)</script>
	          </a><br>
	          <img src='file/p6.gif' width='10' height='10' align='middle'>
	          <a href='wanddns.asp' target='main'><font size='2' class='fontCr'>
		      <script>dw(DDNS)</script>
	          </a>
	       </td></tr></table>
         </td></tr></table></span>

         <span id="wanDisId" style='display:none'>
         <table><tr><td>
	     <a href='javascript:showMenu(1,"");' onmouseout='MM_swapImgRestore()' onmouseover="MM_swapImage('Image22','','file/r_1.gif',1)">
           <img src='file/r.gif' width='18' height='14' border='0' name='Image22'>
           <font face='Arial' size='4' class='menut'>
             <script>dw(wan)</script>
           </font></a>
         </td></tr></table></span>

         <span id="lanActId" style='display:none'>
         <table><tr><td>
	     <a href='javascript:showMenu(3,"");'>
           <img src="file/r_2.gif" width="18" height="14" border="0" name="Image3">
           <font size="4"class="menut">
             <script>dw(lan)</script>
           </font></a>
         </td></tr></table></span>


         <span id="lanDisId">
         <table><tr><td>
	     <a href='javascript:showMenu(3,"");' onmouseout='MM_swapImgRestore()' onmouseover="MM_swapImage('Image33','','file/r_1.gif',1)">
           <img src='file/r.gif' width='18' height='14' border='0' name='Image33'>
           <font face='Arial' size='4' class='menut'>
             <script>dw(lan)</script>
           </font></a>
         </td></tr></table></span>

         <span id="wlActEnId" style='display:none'>
         <table><tr><td>
	     <a href='javascript:showMenu(4,"");'>
           <img src="file/r_2.gif" width="18" height="14" border="0" name="Image4">
           <font size="4"class="menut">
             <script>dw(wireless)</script>
           <br></font></a>
	     <table width="140" border="0"><tr>
	       <td nowrap="nowrap" width="10"></td><td nowrap="nowrap" width="136">
	         <img src='file/p6.gif' width='10' height='10' align='middle'>
	         <a href='wlbasic.asp' target='main'><font size='2' class='fontCr'>
	           <script>dw(basicSet)</script>
	         </a><br>
	         <img src='file/p6.gif' width='10' height='10' align='middle'>
	         <a href='wladvance.asp' target='main'><font size='2' class='fontCr'>
	           <script>dw(advanceSet)</script>
	         </a><br>
	         
	         <img src='file/p6.gif' width='10' height='10' align='middle'>
	         <a href='wlencrypt.asp' target='main'><font size='2' class='fontCr'>
	           <script>dw(securitySet)</script>
	         </a><br>
	         
	         <img src="file/p6.gif" width="10" height="10" align="middle">
	         <a href="wlcontrol.asp" target="main"><font size='2' class='fontCr'>
                 <script>dw(accessControl)</script>
	         </a><br>
	         <img src="file/p6.gif" width="10" height="10" align="middle">
	         <a href="wpsconfig.asp" target="main"><font size='2' class='fontCr'>
                 <script>dw(wpsmenu);</script>
	         </a> 
             </td></tr></table>
         </td></tr></table></span>

         <span id="wlActDisId" style='display:none'>
         <table><tr><td>
	    <a href='javascript:showMenu(4,"");'>
          <img src="file/r_2.gif" width="18" height="14" border="0" name="Image4">
          <font size="4"class="menut">
             <script>dw(wireless)</script>
          </font></a>
         </td></tr></table></span>


         <span id="wlDisId">
           <table><tr><td>
	     <a href='javascript:showMenu(4,"");' onmouseout='MM_swapImgRestore()' onmouseover="MM_swapImage('Image44','','file/r_1.gif',1)">
              <img src='file/r.gif' width='18' height='14' border='0' name='Image44'>
            <font face='Arial' size='4' class='menut'>
                <script>dw(wireless)</script>
            </font></a>
         </td></tr></table></span>






         
    




         <span id="qosActId" style='display:none'>
           <table><tr><td>
	     <a href='javascript:showMenu(2,"");'>
           <img src="file/r_2.gif" width="18" height="14" border="0" name="Image8">
           <font size="4"class="menut">
             <script>dw(qos)</script>
           </font></a>
         </td></tr></table></span>


         <span id="qosDisId" style='display:none'>
           <table><tr><td>
	     <a href='javascript:showMenu(2,"");' onmouseout='MM_swapImgRestore()' onmouseover="MM_swapImage('Image88','','file/r_1.gif',1)">
           <img src='file/r.gif' width='18' height='14' border='0' name='Image88'>
           <font face='Arial' size='4' class='menut'>
             <script>dw(qos)</script>
           </font></a>
         </td></tr></table></span>

         <span id="natActEnId" style='display:none'>
           <table><tr><td>
	      <a href='javascript:showMenu(5,"");'>
            <img src="file/r_2.gif" width="18" height="14" border="0" name="Image5">
            <font size="4"class="menut">
              <script>dw(nat)</script>
            </font></a>
	      <table width="140" border="0"><tr>
	         <td nowrap="nowrap" width="10"></td>
               <td nowrap="nowrap" width="136">
	           <img src='file/p6.gif' width='10' height='10' align='middle'>
	           <a href='natpfw.asp' target='main'>
                 <font size='2' class='fontCr'>
	             <script>dw(portForwarding)</script>
	           </font></a><br>
	           <img src='file/p6.gif' width='10' height='10' align='middle'>
	           <a href='natvser.asp' target='main'><font size='2' class='fontCr'>
	             <script>dw(virtualServer)</script>
	          </font></a><br>
	           <img src='file/p6.gif' width='10' height='10' align='middle'>
	           <a href='natsapp.asp' target='main'><font size='2' class='fontCr'>
	             <script>dw(specialApp)</script>
	           </font></a><br>

	           <img src="file/p6.gif" width="10" height="10" align="middle">
	           <a href="natupnp.asp" target="main"><font size='2' class='fontCr'>
	             <script>dw(upnp)</script>
	           </font></a><br>

	           <img src='file/p6.gif' width='10' height='10' align='middle'>
	           <a href='natalg.asp' target='main'><font size='2' class='fontCr'>
	             <script>dw(alg)</script>
	           </font></a><br>
	           <img src='file/p6.gif' width='10' height='10' align='middle'>
	           <a href='natsrout.asp' target='main'><font size='2' class='fontCr'>
                   <script>dw(staticRoute)</script>
              </font></a>
               </td></tr></table>
         </td></tr></table></span>

         <span id="natActDisId" style='display:none'>
         <table><tr><td>
	     <a href='javascript:showMenu(5,"");'>
            <img src="file/r_2.gif" width="18" height="14" border="0" name="Image5">
            <font size="4"class="menut">
              <script>dw(nat)</script>
            <br></font></a>
	     <table width="140" border="0"><tr>
	       <td nowrap="nowrap" width="10"></td>
             <td nowrap="nowrap" width="136">
	       <img src='file/p6.gif' width='10' height='10' align='middle'>
	       <a href='natsrout.asp' target='main'><font size='2' class='fontCr'>
                   <script>dw(staticRoute)</script>
              </font></a>
           </td></tr></table>
         </td></tr></table></span>


         <span id="natDisId" style='display:none'>
         <table><tr><td>
	     <a href='javascript:showMenu(5,"");' onmouseout='MM_swapImgRestore()' onmouseover="MM_swapImage('Image55','','file/r_1.gif',1)">
           <img src='file/r.gif' width='18' height='14' border='0' name='Image55'>
           <font face='Arial' size='4' class='menut'>
             <script>dw(nat)</script>
           </font></a>
         </td></tr></table></span>

         <span id="fwActEnId" style='display:none'>
           <table><tr><td>
	       <a href='javascript:showMenu(6,"");'>
             <img src="file/r_2.gif" width="18" height="14" border="0" name="Image6">
             <font size="4"class="menut">
               <script>dw(firewall)</script>
             <br></font></a>
	      <table width="140" border="0"><tr>
	        <td nowrap="nowrap" width="10"></td>
              <td nowrap="nowrap" width="136">
	        <img src='file/p6.gif' width='10' height='10' align='middle'>
	        <a href='fwcontrol.asp' target='main'><font size='2' class='fontCr'>
	          <script>dw(accessControl)</script>
	       </font></a><br>
	       <img src='file/p6.gif' width='10' height='10' align='middle'>
	       <a href='fwurlb.asp' target='main'><font size='2' class='fontCr'>
	         <script>dw(urlBlock)</script>
	       </font></a><br>
	       <img src='file/p6.gif' width='10' height='10' align='middle'>
	       <a href='fwdos.asp' target='main'><font size='2' class='fontCr'>
	         <script>dw(DoS)</script>
	       </a><br>
	       <img src='file/p6.gif' width='10' height='10' align='middle'>
	       <a href='fwdmz.asp' target='main'><font size='2' class='fontCr'>
	          <script>dw(dmz)</script>
	       </a>
           </td></tr></table>
         </td></tr></table></span>

         <span id="fwActDisId" style='display:none'>
         <table><tr><td>
	     <a href='javascript:showMenu(6,"");'>
           <img src="file/r_2.gif" width="18" height="14" border="0" name="Image6">
           <font size="4"class="menut">
             <script>dw(firewall)</script>
           </font></a>
         </td></tr></table></span>


         <span id="fwDisId" style='display:none'>
         <table><tr><td>
	     <a href='javascript:showMenu(6,"");' onmouseout='MM_swapImgRestore()' onmouseover="MM_swapImage('Image66','','file/r_1.gif',1)">
           <img src='file/r.gif' width='18' height='14' border='0' name='Image66'> 
           <font face='Arial' size='4' class='menut'>
             <script>dw(firewall)</script>
           </font></a>
         </td></tr></table></span>

         <span id="psActId" style='display:none'>
         <table><tr><td>
	     <a href='javascript:showMenu(7,"");'>
           <img src="file/r_2.gif" width="18" height="14" border="0" name="Image7">
           <font size="4"class="menut">
               <script>dw(printServer)</script>
           </font></a>
         </td></tr></table></span>


         <span id="psDisId" style='display:none'>
         <table><tr><td>
	     <a href='javascript:showMenu(7,"");' onmouseout='MM_swapImgRestore()' onmouseover="MM_swapImage('Image77','','file/r_1.gif',1)">
            <img src='file/r.gif' width='18' height='14' border='0' name='Image77'>
            <font face='Arial' size='4' class='menut'>
               <script>dw(printServer)</script>
           </font></a>
         </td></tr></table></span>

        </td>
       </tr>
      </table>
   </form>
  </body>
</html>