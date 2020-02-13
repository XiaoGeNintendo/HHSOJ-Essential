<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/9.18.1/styles/default.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/9.18.1/highlight.min.js"></script>
<script src="https://cdn.staticfile.org/showdown/1.9.1/showdown.min.js"></script>
<script src="assets/showdown-full-extensions.js"></script>
<script src="assets/showdown-youtube.js"></script>

<script>
var converter = new showdown.Converter({
    'disableForced4SpacesIndentedSublists': 'true', 
    'tasklists': 'true', 
    'tables': 'true', 
    'strikethrough':'true',
    'extensions': ['mathjax', 'video', 'audio', 'catalog', 'anchor', 'youtube']
});

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
<style>
/* Anchor style*/
/* from excing, slightly modified by Zzzyt */
h1:hover .octicon, h2:hover .octicon, h3:hover .octicon, h4:hover .octicon, h5:hover .octicon, h6:hover .octicon {
    visibility: visible;
}
.anchor {
    line-height: 1;
    margin-left: -20px;
    padding-right: 4px;
}
.anchor:focus .octicon {
    visibility: visible;
}
.octicon {
    display: inline-block;
    fill: currentColor;
    color: #1b1f23;
    vertical-align: middle;
    visibility: hidden;
}
/* Catalog style */
/* from excing, slightly modified by Zzzyt */
.cat ul {
    -webkit-margin-before: 0em;
    -webkit-margin-after: 0em;
    -webkit-margin-start: 0px;
    -webkit-margin-end: 0px;
    -webkit-padding-start: 0px;
}

.cat ul ul {
    -webkit-margin-before: 0em;
    -webkit-margin-after: 0em;
    -webkit-margin-start: 0px;
    -webkit-margin-end: 0px;
    -webkit-padding-start: 40px;
}

.cat li, li {
    padding-top: 0em;
    padding-bottom: 0em;
    margin-top: 0;
    margin-bottom: 0;
}
</style>