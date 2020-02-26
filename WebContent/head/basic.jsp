<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="apple-mobile-web-app-title" content="HellOJ">
<meta name="application-name" content="HellOJ">
<meta name="theme-color" content="#f8f8f8">
<meta name="description" content="HellOJ - Free OJ by Hell Hole Studios">
<meta name="keywords" content="OJ HellOJ HHSOJ Online Judge">

<link rel="icon" type="image/png" href="assets/img/hhsoj16x.png" sizes="16x16">
<link rel="icon" type="image/png" href="assets/img/hhsoj32x.png" sizes="32x32">
<link rel="icon" type="image/png" href="assets/img/hhsoj128x.png" sizes="128x128">

<script src="https://cdn.staticfile.org/jquery/3.4.1/jquery.min.js"></script>
<script src="https://cdn.staticfile.org/popper.js/1.12.5/umd/popper.min.js"></script>

<script src="https://cdn.staticfile.org/twitter-bootstrap/4.1.0/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/4.1.0/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdn.staticfile.org/font-awesome/4.7.0/css/font-awesome.min.css">

<script src="assets/js/clipboard.2.0.4.min.js"></script>

<!-- basic.css, get over everything!!!-->
<link href="assets/css/basic.css" rel="stylesheet" type="text/css">
<link href="assets/css/theme.css" rel="stylesheet" type="text/css">

<script>
var postload=[];

function addTask(a,f){
	postload.push({p:a,f:f});
}

function reloadCopyButton(){
	$('.copy-btn-wrapper').remove();
	
	var a=$('pre');
	var cnt=0;
	for(var i=0;i<a.length;i++){
		if(a[i].textContent=='')continue;
		if(a[i].id==''){
			while($('#copycode'+cnt).length!=0){
				cnt++;
			}
			a[i].id="copycode"+cnt;
		}
	}
	for(var i=0;i<a.length;i++){
		if(a[i].textContent=='')continue;
		var str='<div class="copy-btn-wrapper">'
		str+='<button type="button" class="copy-btn" data-clipboard-target="#'+a[i].id+'">Copy</button>';
		str+='</div>'
		$(a[i]).before(str);
	}
	
	var clipboard=new ClipboardJS('.copy-btn');
	clipboard.on('success', function(e) {
	    e.clearSelection();
	});
	clipboard.on('error', function(e) {
	    alert("Copy failed :(");
	});
}

addTask(100000,reloadCopyButton);

document.addEventListener('DOMContentLoaded', (event) => {
	postload.sort(function(a,b){
		return a.p-b.p;
	});
	postload.forEach(task=>{task.f()});
});
</script>