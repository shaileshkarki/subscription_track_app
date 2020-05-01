var i=0,
  len = abbrs.length,
  abbrs = document.getElementsByClassName("deletion-for");

for( ; i < len ; i++){
    abbrs[i].addEventListener("submit", function(event){
        confirm("Press ok to delete!");
    });
}