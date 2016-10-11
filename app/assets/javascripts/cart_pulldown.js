function AllHide() {
   document.getElementById('payment01').style.display = 'none';
   document.getElementById('payment02').style.display = 'none';

}
function SetSubMenu( idname ) {
   AllHide();
   if( idname != "" ) {
      document.getElementById(idname).style.display = 'block';
   }
}
