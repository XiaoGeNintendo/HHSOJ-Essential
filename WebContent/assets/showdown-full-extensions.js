/**
 * showdown extension by excing
 * 
 * slightly modified by Zzzyt to fix mathjax dollar sign issue
 * 
 * see [GitHub](https://github.com/excing/showdown-extensions)
 */
(function (extension) {
  'use strict';

  if (typeof showdown !== 'undefined') {
    // global (browser or nodejs global)
    extension(showdown);
  } else if (typeof define === 'function' && define.amd) {
    // AMD
    define(['showdown'], extension);
  } else if (typeof exports === 'object') {
    // Node, CommonJS-like
    module.exports = extension(require('showdown'));
  } else {
    // showdown was not found so we throw
    throw Error('Could not find showdown library');
  }

}(function (showdown) {
  'use strict';

  var latexCodeBlocks = [];

  /** 
   * Support editing of mathematical formulas, syntax reference LaTeX.
   */
  showdown.extension('mathjax', function () {
    return [
      {
        type:    'lang',
        regex:   '(?:^|\\n)\u00a8D\u00a8D(.*)\\n([\\s\\S]*?)\\n\u00a8D\u00a8D',
        replace: function (match, leadingSlash, codeblock) {
          // Check if we matched the leading \ and return nothing changed if so
          if (leadingSlash === '\\') {
            return match;
          } else {
            return '\n\n~Z' + (latexCodeBlocks.push({text: match.substring(1), codeblock: codeblock}) - 1) + 'Z\n\n';
          }
        }
      },

      {
        type:    'lang',
        regex:   '\u00a8D([^`\\f\\n\\r]+?)\u00a8D',
        replace: function (match, leadingSlash, codeblock) {
          // Check if we matched the leading \ and return nothing changed if so
          if (leadingSlash === '\\') {
            return match;
          } else {
            return '~Z' + (latexCodeBlocks.push({text: match, codeblock: codeblock}) - 1) + 'Z';
          }
        }
      },

      {
        type:    'output',
        regex:   '~(Z)(\\d+)\\1',
        replace: function (match, leadingSlash, index) {
          // Check if we matched the leading \ and return nothing changed if so
          if (leadingSlash === '\\') {
            return match;
          } else {
            index = Number(index);
            var code = latexCodeBlocks[index].text;
            return code.replace(/\u00a8D/g, '$$');
          }
        }
      },

      // clear cache
      {
        type: 'output',
        filter: function (text, globals_converter, options) {
          latexCodeBlocks = [];

          return text;
        }
      },

    ];
  });

  /**
   * Support for the syntax of video display, syntax: ![](https://video.mp4)
   */
  showdown.extension('video', function () {
    return [

      {
        type:    'output',
        regex:   '<p><img src="(.+(mp4|ogg|webm).*?)"(.+?)\\/>',
        replace: function (match, url, format, other) {
          // Check if we matched the leading \ and return nothing changed if so
          if (url === ('.' + format)) {
            return match;
          } else {
            // src="https://image.png" alt="image alt text" title="image title" width="100" height="auto"
            // var regex = /([a-z]+)="(.*?)"/g;

            // return `<video src="${url}" ${other} controls>I am sorry; your browser does not support HTML5 video in WebM with VP8/VP9 or MP4 with H.264.</video>`;
            return `<video ${other} controls><source src="${url}" type="video/${format}">I am sorry, Your browser does not support the <code>video</code> element.</video>`;
          }
        }
      },
    ];
  });

  /**
   * Support for the syntax of video display, syntax: ![](https://video.mp4)
   */
  showdown.extension('audio', function () {
    return [

      {
        type:    'output',
        regex:   '<p><img src="(.+(mp3|ogg|wav).*?)"(.+?)\\/>',
        replace: function (match, url, format, other) {
          // Check if we matched the leading \ and return nothing changed if so
          if (url === ('.' + format)) {
            return match;
          } else {
            // src="https://image.png" alt="image alt text" title="image title" width="100" height="auto"
            // var regex = /([a-z]+)="(.*?)"/g;

            if ('mp3' === format) format = 'mpeg';

            // return `<video src="${url}" ${other} controls>I am sorry; your browser does not support HTML5 video in WebM with VP8/VP9 or MP4 with H.264.</video>`;
            return `<audio ${other} controls><source src="${url}" type="audio/${format}">I am sorry, Your browser does not support the <code>audio</code> element.</audio>`;
          }
        }
      },
    ];
    
  });

  var needCat = false;
  var catalogues = [];

  /**
   * Support <h1> to <h6> catalog display
   */
  showdown.extension('catalog', function () {
    return [

      {
        type:    'lang',
        regex:   '\\n(\\[TOC\\])\\n',
        replace: function (match) {
          needCat = true;

          return '[[[TOC]]]]]';
        }
      },

      {
        type:    'output',
        regex:   '<h\\d id="(.+?)">(.*?)<\\/h(\\d)>',
        replace: function (match, id, title, level) {
          if (needCat) {
            var title_ahref_reg = /(.*?)<a .*>(.*?)<\/a>(.*)/g;
            var title_ahref_reg_match = title_ahref_reg.exec(title);
            if (null !== title_ahref_reg_match) {
              title = title_ahref_reg_match[1] + ' ' + title_ahref_reg_match[2] + ' ' + title_ahref_reg_match[3];
            }
            catalogues.push({'id': id, 'title': title, 'level': level});
          }

          return match;
        }
      },

      {
        type: 'output',
        filter: function (text, globals_converter, options) {
          if (catalogues.length <= 0) return text;

          var catDiv = '<div class="cat" id="toc_catalog">';
          var lastLevel = 0;
          var levelCount = 0;

          for (var i = 0; i < catalogues.length; i++) {
            var cat = catalogues[i];

            if (cat.level < lastLevel) {
              var count = lastLevel - cat.level;
              if (levelCount <= count) {
                count = levelCount - 1;
              }
              for (var l = 0; l < count; l++) {
                catDiv += ('</ul>');
              }
              levelCount -= count;
            } else if (lastLevel < cat.level) {
              catDiv += ('<ul>');
              levelCount ++;
            }
            catDiv += ('<li><a href="#' + cat.id + '">' + cat.title + '</a></li>');

            lastLevel = cat.level;
          }

          catDiv += '</ul></div>';

          needCat = false;
          catalogues = [];

          return text.replace(/\[\[\[TOC\]\]\]\]\]/g, catDiv);
        }
      },
    ];
    
  });

  /**
   * Support for anchor buttons for <h1> to <h6> titles
   */
  showdown.extension('anchor', function () {
    return [

      {
        type:    'output',
        regex:   '<h\\d id="(.+?)">(.*?)<\\/h(\\d)>',
        replace: function (match, id, title, level) {

          // github anchor style
          var octicon_html = `<a class="anchor" aria-hidden="true" href="#${id}"><svg class="octicon" viewBox="0 0 16 16" version="1.1" width="16" height="16" aria-hidden="true"><path fill-rule="evenodd" d="M4 9h1v1H4c-1.5 0-3-1.69-3-3.5S2.55 3 4 3h4c1.45 0 3 1.69 3 3.5 0 1.41-.91 2.72-2 3.25V8.59c.58-.45 1-1.27 1-2.09C10 5.22 8.98 4 8 4H4c-.98 0-2 1.22-2 2.5S3 9 4 9zm9-3h-1v1h1c1 0 2 1.22 2 2.5S13.98 12 13 12H9c-.98 0-2-1.22-2-2.5 0-.83.42-1.64 1-2.09V6.25c-1.09.53-2 1.84-2 3.25C6 11.31 7.55 13 9 13h4c1.45 0 3-1.69 3-3.5S14.5 6 13 6z"></path></svg></a>`;

          return `<h${level} id="${id}">${octicon_html}${title}</h${level}>`;
        }
      },

    ];
    
  });

}));