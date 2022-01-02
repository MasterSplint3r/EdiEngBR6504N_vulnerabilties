function setlanguage()
{
  var vervaldatum = new Date()
      vervaldatum.setDate(vervaldatum.getDate()+365);
  var newValue = document.form.site.options[document.form.site.selectedIndex].value;
  	document.cookie="language="+newValue+"; expires="+vervaldatum+"; path=/";
      parent.window.location.href = "./index.asp";	//reload();	//
}

function getCookie(c_name)
{
  if (document.cookie.length>0)
  {
    c_start=document.cookie.indexOf(c_name + "=")
    if (c_start!=-1)
    {
      c_start=c_start + c_name.length+1;
      c_end=document.cookie.indexOf(";",c_start);
      if (c_end==-1) c_end=document.cookie.length;
      return unescape(document.cookie.substring(c_start,c_end));
    }
  }
  return 0;
}

// var stype = getCookie('language');
var stype = 0;


function showText(text)
{
  return text[stype];
}
//pippen 20060220
function dw(message)
{
	document.write(showText(message));	
}
