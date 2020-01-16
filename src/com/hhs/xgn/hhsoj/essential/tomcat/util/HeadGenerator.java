package com.hhs.xgn.hhsoj.essential.tomcat.util;

public class HeadGenerator {
	public static String getBasic() {
		String ret="";
		
		ret+="<meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\n";
		ret+="<meta content=\"width=device-width, initial-scale=1.0\" name=\"viewport\">\n";
		ret+="<meta name=\"apple-mobile-web-app-title\" content=\"HellOJ\">";
		ret+="<meta name=\"application-name\" content=\"HellOJ\">";
		ret+="<meta name=\"theme-color\" content=\"#f0f0f0\">\n";
		ret+="<meta name=\"description\" content=\"HellOJ - Free OJ by Hell Hole Studios\">\n";
		ret+="<meta name=\"keywords\" content=\"OJ HellOJ HHSOJ Online Judge\">\n";
		ret+="\n";
		
		ret+="<link rel=\"icon\" type=\"image/png\" href=\"assets/hhsoj16x.png\" sizes=\"16x16\">\n";
		ret+="<link rel=\"icon\" type=\"image/png\" href=\"assets/hhsoj32x.png\" sizes=\"32x32\">\n";
		ret+="\n";
		
		ret+="<script src=\"https://cdn.staticfile.org/jquery/1.10.2/jquery.min.js\"></script>\n";
		
		ret+="<link rel=\"stylesheet\" href=\"https://cdn.staticfile.org/twitter-bootstrap/4.1.0/css/bootstrap.min.css\">\n";
		ret+="<script src=\"https://cdn.staticfile.org/jquery/3.2.1/jquery.min.js\"></script>\n";
		ret+="<script src=\"https://cdn.staticfile.org/popper.js/1.12.5/umd/popper.min.js\"></script>\n";
		ret+="<script src=\"https://cdn.staticfile.org/twitter-bootstrap/4.1.0/js/bootstrap.min.js\"></script>\n";
		ret+="\n";
		
		ret+="<!-- default.css, get over everything!!!-->\n";
		ret+="<link href=\"assets/default.css\" rel=\"stylesheet\" type=\"text/css\">\n";
		ret+="\n";
		
		return ret;
	}
	
	public static String getMarkdown() {
		String ret="";
		ret+="<script src=\"https://cdn.staticfile.org/showdown/1.9.1/showdown.min.js\"></script>\n";
		ret+="<script src=\"https://cdn.staticfile.org/showdown/1.9.1/showdown.min.js.map\"></script>\n";
		ret+="\n";
		return ret;
	}
	
	public static String getMathJax() {
		String ret="";
		ret+="<script type=\"text/x-mathjax-config\">\n"; 
		ret+="MathJax.Hub.Config({\n";
		ret+="  tex2jax: {inlineMath: [['$','$']], displayMath: [['$$$','$$$']]}\n"; 
		ret+="});\n"; 
		ret+="</script>\n"; 
		ret+="<script type=\"text/javascript\" async src=\"https://cdn.staticfile.org/mathjax/2.7.7/MathJax.js?config=TeX-MML-AM_CHTML\" ></script>\n";
		ret+="\n";
		return ret;
	}
}
