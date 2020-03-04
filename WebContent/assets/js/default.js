var postload=[];

var converter = new showdown.Converter({
    'disableForced4SpacesIndentedSublists': 'true', 
    'tasklists': 'true', 
    'tables': 'true', 
    'strikethrough':'true',
    'extensions': ['mathjax', 'video', 'audio', 'catalog', 'anchor', 'youtube']
});

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

function reloadHighlight(){
	document.querySelectorAll('pre code').forEach((block) => {
		hljs.highlightBlock(block);
	});
}

function reloadTableStyle(){
	document.querySelectorAll('table').forEach((table) => {
		if(table.className.indexOf('table-bordered'==-1)){
			table.className+=' table-bordered table-sm';
		}
	});
}

function reloadMathJax(){
	MathJax.Hub.Queue(["Typeset",MathJax.Hub]);
}

addTask(10,reloadHighlight);
addTask(20,reloadTableStyle);
addTask(30,reloadMathJax);
addTask(100000,reloadCopyButton);

document.addEventListener('DOMContentLoaded', (event) => {
	postload.sort(function(a,b){
		return a.p-b.p;
	});
	postload.forEach(task=>{task.f()});
});