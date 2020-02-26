<link rel="stylesheet" href="assets/css/highlight.9.18.1.default.min.css">
<script src="assets/js/highlight.9.18.1.min.js"></script>
<script src="https://cdn.staticfile.org/showdown/1.9.1/showdown.min.js"></script>
<script src="assets/js/showdown-full-extensions.js"></script>
<script src="assets/js/showdown-youtube.js"></script>
<script type="text/javascript" src="https://cdn.staticfile.org/mathjax/2.7.7/MathJax.js?config=TeX-MML-AM_CHTML" ></script>

<script type="text/x-mathjax-config">
  MathJax.Hub.Config({
    tex2jax: {
      inlineMath: [ ['$','$'], ["\\(","\\)"] ],
      processEscapes: true
    }
  });
</script>
<script type="text/x-mathjax-config">
    MathJax.Hub.Config({
      tex2jax: {
        skipTags: ['script', 'noscript', 'style', 'textarea', 'pre', 'code']
      }
    });
</script>
<script type="text/x-mathjax-config">
    MathJax.Hub.Queue(function() {
        var all = MathJax.Hub.getAllJax(), i;
        for(i=0; i < all.length; i += 1) {
            all[i].SourceElement().parentNode.className += ' has-jax';
        }
    });
</script>
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
</script>