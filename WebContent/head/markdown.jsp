<script src="https://cdn.staticfile.org/showdown/1.6.1/showdown.min.js"></script>
<script src="https://cdn.staticfile.org/showdown/1.6.1/showdown.min.js.map"></script>
<script src="https://cdn.jsdelivr.net/gh/excing/showdown-extensions@v1.2.2/showdown-full-extensions.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/9.18.1/styles/default.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/9.18.1/highlight.min.js"></script>
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