<script src="https://cdn.staticfile.org/showdown/1.9.1/showdown.min.js"></script>
<script src="https://cdn.staticfile.org/showdown/1.9.1/showdown.min.js.map"></script>
<link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/highlight.js/9.18.1/styles/default.min.css">
<script src="//cdnjs.cloudflare.com/ajax/libs/highlight.js/9.18.1/highlight.min.js"></script>
<script>
function reloadHighlight(){
	document.querySelectorAll('pre code').forEach((block) => {
		hljs.highlightBlock(block);
	});
}

function reloadTableStyle(){
	document.querySelectorAll('table').forEach((table) => {
		if(table.className.indexOf('table-bordered'==-1)){
			table.className+=' table-bordered table-sm'
		}
	});
}

document.addEventListener('DOMContentLoaded', (event) => {
	reloadHighlight();
	reloadTableStyle();
});
</script>