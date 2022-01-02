<html><head><title></title>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<style>test10 {
	FONT-SIZE: 10pt; TEXT-DECORATION: none
}
A:link {
	COLOR: #ff0000; FONT-FAMILY: Arial; FONT-SIZE: 9pt; TEXT-DECORATION: none
}
A:visited {
	COLOR: #ffff00; FONT-FAMILY: Arial; FONT-SIZE: 9pt; TEXT-DECORATION: none
}
A:active {
	COLOR: #ffffff; FONT-SIZE: 9pt; TEXT-DECORATION: none
}
A:hover {
	COLOR: #FFFFFF; FONT-SIZE: 9pt; TEXT-DECORATION: none 
}
</style>
<script language="JavaScript">
function goWiz() {
	document.systemMode.submit();
	parent.lFrame.location.replace("../setmenu.html");
	parent.main.location.replace("../systimezone.asp");
}		
function goSet()  {
	parent.lFrame.location.replace("../genmenu.asp");
	parent.main.location.replace("../setup_main.asp");
}

function goSta()  {
	parent.lFrame.location.replace("../stamenu.asp");
	parent.main.location.replace("../stainfo.asp");
}

function goTool()  {
	parent.lFrame.location.replace("../tlmenu.asp");
	parent.main.location.replace("../tlmain.asp");
}
function FP_swapImg() {//v1.0
 var doc=document,args=arguments,elm,n; doc.$imgSwaps=new Array(); for(n=2; n<args.length;
 n+=2) { elm=FP_getObjectByID(args[n]); if(elm) { doc.$imgSwaps[doc.$imgSwaps.length]=elm;
 elm.$src=elm.src; elm.src=args[n+1]; } }
}

function FP_preloadImgs() {//v1.0
 var d=document,a=arguments; if(!d.FP_imgs) d.FP_imgs=new Array();
 for(var i=0; i<a.length; i++) { d.FP_imgs[i]=new Image; d.FP_imgs[i].src=a[i]; }
}

function FP_getObjectByID(id,o) {//v1.0
 var c,el,els,f,m,n; if(!o)o=document; if(o.getElementById) el=o.getElementById(id);
 else if(o.layers) c=o.layers; else if(o.all) el=o.all[id]; if(el) return el;
 if(o.id==id || o.name==id) return o; if(o.childNodes) c=o.childNodes; if(c)
 for(n=0; n<c.length; n++) { el=FP_getObjectByID(id,c[n]); if(el) return el; }
 f=o.forms; if(f) for(n=0; n<f.length; n++) { els=f[n].elements;
 for(m=0; m<els.length; m++){ el=FP_getObjectByID(id,els[n]); if(el) return el; } }
 return null;
}
</script>
<base target="_self">
</head>
<body bgcolor="#000000" text="#ffffff" leftmargin="0" topmargin="10" marginwidth="0" marginheight="0" background="back-c.gif" style="text-align: right" onload="FP_preloadImgs(/*url*/'button12.jpg', /*url*/'button22.jpg', /*url*/'button32.jpg', /*url*/'button42.jpg')">
<form action=/goform/formWizSetup method=POST name="systemMode">
<input type="hidden" value="/setmenu.html" name="setPage">
<input type="hidden" value="1" name="wizEnabled">
<table border="0" width="100%" height="54" cellpadding="0" cellspacing="0">
	<tr>
		<td>
			<div align="right">
			<a href="javascript:goWiz();"><img border="0" id="img1" src="button1.jpg" height="54" width="139" alt="Quick Setup" fp-style="fp-btn: Border Bottom 1; fp-img-press: 0; fp-bgcolor: #000000; fp-proportional: 0" fp-title="1" onmouseover="FP_swapImg(1,0,/*id*/'img1',/*url*/'button12.jpg')" onmouseout="FP_swapImg(0,0,/*id*/'img1',/*url*/'button1.jpg')"></a>
			<a href="javascript:goSet();"><img border="0" id="img2" src="button2.jpg" height="54" width="152" alt="General Setup" fp-style="fp-btn: Border Bottom 1; fp-img-press: 0; fp-bgcolor: #000000; fp-proportional: 0" fp-title="2" onmouseover="FP_swapImg(1,0,/*id*/'img2',/*url*/'button22.jpg')" onmouseout="FP_swapImg(0,0,/*id*/'img2',/*url*/'button2.jpg')"></a> 
			<a href="javascript:goSta();"><img border="0" id="img3" src="button3.jpg" height="54" width="130" alt="Sysyem Status" fp-style="fp-btn: Border Bottom 1; fp-img-press: 0; fp-bgcolor: #000000; fp-proportional: 0" fp-title="3" onmouseover="FP_swapImg(1,0,/*id*/'img3',/*url*/'button32.jpg')" onmouseout="FP_swapImg(0,0,/*id*/'img3',/*url*/'button3.jpg')"></a>
			<a href="javascript:goTool();"><img border="0" id="img4" src="button4.jpg" height="54" width="151" alt="System Tools" fp-style="fp-btn: Border Bottom 1; fp-img-press: 0; fp-bgcolor: #000000; fp-proportional: 0" fp-title="4" onmouseover="FP_swapImg(1,0,/*id*/'img4',/*url*/'button42.jpg')" onmouseout="FP_swapImg(0,0,/*id*/'img4',/*url*/'button4.jpg')"></a></div>
		</td>
	</tr>	
</table>
</form>
</body></html>
