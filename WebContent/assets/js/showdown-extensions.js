/**
 * showdown extensions by excing
 * youtube extension by theshowdown team
 * slightly modified by Zzzyt
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
  
  var ytb_svg =
      '<div class="youtube-preview" style="width:%2; height:%3; background-color:#333; position:relative;">' +
      '<svg version="1.1" xmlns="http://www.w3.org/2000/svg" ' +
      '     width="100" height="70" viewBox="0 0 100 70"' +
      '     style="position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%);">' +
      '    <defs>' +
      '      <linearGradient id="grad1" x1="0%" x2="0%" y1="0%" y2="100%">' +
      '        <stop offset="0%" style="stop-color:rgb(229,45,49);stop-opacity:1" />' +
      '        <stop offset="100%" style="stop-color:rgb(191,23,29);stop-opacity:1" />' +
      '      </linearGradient>' +
      '    </defs>' +
      '    <rect width="100%" height="100%" rx="26" fill="url(#grad1)"/>' +
      '    <polygon points="35,20 70,35 35,50" fill="#fff"/>' +
      '    <polygon points="35,20 70,35 64,37 35,21" fill="#e8e0e0"/>' +
      '</svg>' +
      '<div style="text-align:center; padding-top:10px; color:#fff"><a href="%1">%1</a></div>' +
      '</div>',
    ytb_img = '<img src="data:image/gif;base64,R0lGODlhAQABAIAAAAUEBAAAACwAAAAAAQABAAACAkQBADs=" width="%2" height="%3">',
    ytb_iframe = '<iframe src="%1" width="%2" height="%3" frameborder="0" allowfullscreen></iframe>',
    ytb_imgRegex = /(?:<p>)?<img.*?src="(.+?)"(.*?)\/?>(?:<\/p>)?/gi,
    ytb_fullYoutubeRegex = /(?:(?:https?:)?(?:\/\/)?)(?:(?:www)?\.)?youtube\.(?:.+?)\/(?:(?:watch\?v=)|(?:embed\/))([a-zA-Z0-9_-]{11})/i,
    ytb_shortYoutubeRegex = /(?:(?:https?:)?(?:\/\/)?)?youtu\.be\/([a-zA-Z0-9_-]{11})/i,
    ytb_vimeoRegex = /(?:(?:https?:)?(?:\/\/)?)(?:(?:www)?\.)?vimeo.com\/(\d+)/;

  function parseDimensions(rest, options) {
    var width,
      height,
      d,
      defaultWidth,
      defaultHeight;

    defaultWidth = options.youtubeWidth ? options.youtubeWidth : 420;
    defaultHeight = options.youtubeHeight ? options.youtubeHeight : 315;

    if (rest) {
      width = (d = /width="(.+?)"/.exec(rest)) ? d[1] : defaultWidth;
      height = (d = /height="(.+?)"/.exec(rest)) ? d[1] : defaultHeight;
    }

    // add units so they can be used in css
    if (/^\d+$/gm.exec(width)) {
      width += 'px';
    }
    if (/^\d+$/gm.exec(height)) {
      height += 'px';
    }

    return {
      width: width,
      height: height
    };
  }
  
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
  
  /**
   * Replace with video iframes
   */
  showdown.extension('youtube', function () {
    return [
      {
        // It's a bit hackish but we let the core parsers replace the reference image for an image tag
        // then we replace the full img tag in the output with our iframe
        type: 'output',
        filter: function (text, converter, options) {
          var tag = ytb_iframe;
          if (options.smoothLivePreview) {
            tag = (options.youtubeUseSimpleImg) ? ytb_img : ytb_svg;
          }
          return text.replace(ytb_imgRegex, function (match, url, rest) {
            var d = parseDimensions(rest, options),
              m, 
              fUrl = '';
            if ((m = ytb_shortYoutubeRegex.exec(url)) || (m = ytb_fullYoutubeRegex.exec(url))) {
              fUrl = 'https://www.youtube.com/embed/' + m[1] + '?rel=0';
            } else if ((m = ytb_vimeoRegex.exec(url))) {
              fUrl = 'https://player.vimeo.com/video/' + m[1];
            } else {
              return match;
            }
            return tag.replace(/%1/g, fUrl).replace('%2', d.width).replace('%3', d.height);
          });
        }
      }
    ];
  });
  
}));