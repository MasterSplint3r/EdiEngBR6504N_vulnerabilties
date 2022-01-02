<html><head><title></title>
<link rel="stylesheet" href="set.css">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<script type="text/javascript" src="javascript.js"></script>
<script type="text/javascript" src="file/netsys-n.var"></script>
<script language="JavaScript">
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
function Replace(page)  {
	var pageTbl = new Array("/wandip.asp", "/wansip.asp", "/wanpppoe.asp", "/wanpptp.asp", "/wanl2tp.asp", "/wantelstra.asp");
	parent.lFrame.stepDisplay(3);
	document.tF.setPage.value=pageTbl[page];
	document.tF.submit();
}

function goToTimeZone()  {
	parent.lFrame.stepDisplay(1);
	document.tF.setPage.value="/systimezone.asp";
	document.tF.submit();
}
</script></head>
<body class="background"  onload="MM_preloadImages('file/r_1.gif')">
<table width="520" border="0" cellspacing="0" cellpadding="0" align="center" height="95%">
  <tbody><tr>
    <td height="226" valign="top">
<p align="center"><font class="titlecolor" size="4"><script>dw(broadbandType2)</script></font></p>
<font class="textcolor" size="2"><script>dw(settypeContent)</script></font><br>
<form action=/goform/formWizSetup method=POST name="tF">
<input type="hidden" value="" name="setPage">
<input type="hidden" value="1" name="wizEnabled">

<font class="titlecolor"><a href="javascript:Replace(0);" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('Image1','','file/r_1.gif',1)"><img src="file/r.gif" width="19" height="14" border="0" name="Image1"><font face="Times New Roman" color="#000080"><span style="text-decoration: none"><script>dw(cableModem)</script></span></font></a><br></font>
<font class="textcolor" size="2"><script>dw(settypeContent2)</script></font><br>
        
<p><font class="titlecolor"><a href="javascript:Replace(1);" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('Image11','','file/r_1.gif',1)"><img src="file/r.gif" width="19" height="14" border="0" name="Image11"><font face="Times New Roman" color="#000080"><span style="text-decoration: none"><script>dw(fixedIPDSL)</script></span></font></a><br></font>
<font class="textcolor" size="2"><script>dw(settypeContent3)</script></font><br></p>
	
<p><font class="titlecolor"><a href="javascript:Replace(2);" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('Image12','','file/r_1.gif',1)"><img src="file/r.gif" width="19" height="14" border="0" name="Image12"><font face="Times New Roman" color="#000080"><span style="text-decoration: none"><script>dw(PPPoEDSL)</script></span></font></a><br></font>
<font class="textcolor" size="2"><script>dw(settypeContent4)</script></font><br></p>

<p><font class="titlecolor"><a href="javascript:Replace(3);" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('Image13','','file/r_1.gif',1)"><img src="file/r.gif" width="19" height="14" border="0" name="Image13"><font face="Times New Roman" color="#000080"><span style="text-decoration: none"><script>dw(PPTPDSL)</script></span></font></a><br></font>
<font class="textcolor" size="2"><script>dw(settypeContent5)</script></font></p>

<p><font class="titlecolor"><a href="javascript:Replace(4);" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('Image14','','file/r_1.gif',1)"><img src="file/r.gif" width="19" height="14" border="0" name="Image14"><font face="Times New Roman" color="#000080"><span style="text-decoration: none"><script>dw(L2TPDSL)</script></span></font></a><br></font>
<font class="textcolor" size="2"><script>dw(settypeContent6)</script></font></p>

<p><font class="titlecolor"><a href="javascript:Replace(5);" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('Image15','','file/r_1.gif',1)"><img src="file/r.gif" width="19" height="14" border="0" name="Image15"><font face="Times New Roman" color="#000080"><span style="text-decoration: none"><script>dw(TelBP)</script></span></font></a><br></font>
<font class="textcolor" size="2"><script>dw(wantelstraPageContent)</script></font></p>
</form></td>
  </tr>
  <tr>
    <td height="5" valign="bottom" align="right">
 		<script>buffer='<input type=button value="'+showText(back1)+'" style ="width:100px" onClick="goToTimeZone();">';document.write(buffer);</script>
    </td>
  </tr>
</tbody></table>
</body></html>
