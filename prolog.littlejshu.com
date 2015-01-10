<!DOCTYPE HTML>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <meta name="Keywords" content="blog"/>
    <meta name="Description" content="blog"/>
    <title>Simple</title>
    <link rel="shortcut icon" href="/static/favicon.png"/>
    <link rel="stylesheet" type="text/css" href="/main.css" />
</head>
<body>
<div class="main">
    <div class="header">
    	<ul id="pages">
            <li><a href="/">home</a></li>
            <li><a href="/#/tags">tags</a></li>
            <li><a href="/#/archive">archive</a></li>
    	</ul>
    </div>
	<div class="wrap-header">
	<h1>
    <a href="/" id="title"></a>
	</h1>
	</div>
<div id="md" style="display: none;">
<!-- markdown -->
Today I start to learn something about PROLOG, an interesting language.

$first part$

How to set up the environment on a MAC?

1. download SWI-PROLOG from the internet and install it.

2. start the software and try this command:
writeln('hello world!').
<!-- markdown end -->
</div>
<div class="entry" id="main">
<!-- content -->
<p>Today I start to learn something about PROLOG, an interesting language.</p>

<p><span class="MathJax_Preview"></span><span class="MathJax" id="MathJax-Element-321-Frame" role="textbox" aria-readonly="true"><nobr><span class="math" id="MathJax-Span-3483" style="width: 4.271em; display: inline-block;"><span style="display: inline-block; position: relative; width: 3.458em; height: 0px; font-size: 123%;"><span style="position: absolute; clip: rect(1.73em 1000.003em 2.899em -0.607em); top: -2.538em; left: 0.003em;"><span class="mrow" id="MathJax-Span-3484"><span class="mi" id="MathJax-Span-3485" style="font-family: STIXGeneral-Italic;">f<span style="display: inline-block; overflow: hidden; height: 1px; width: 0.155em;"></span></span><span class="mi" id="MathJax-Span-3486" style="font-family: STIXGeneral-Italic;">i</span><span class="mi" id="MathJax-Span-3487" style="font-family: STIXGeneral-Italic;">r<span style="display: inline-block; overflow: hidden; height: 1px; width: 0.003em;"></span></span><span class="mi" id="MathJax-Span-3488" style="font-family: STIXGeneral-Italic;">s</span><span class="mi" id="MathJax-Span-3489" style="font-family: STIXGeneral-Italic;">t<span style="display: inline-block; overflow: hidden; height: 1px; width: 0.003em;"></span></span><span class="mi" id="MathJax-Span-3490" style="font-family: STIXGeneral-Italic;">p</span><span class="mi" id="MathJax-Span-3491" style="font-family: STIXGeneral-Italic;">a</span><span class="mi" id="MathJax-Span-3492" style="font-family: STIXGeneral-Italic;">r<span style="display: inline-block; overflow: hidden; height: 1px; width: 0.003em;"></span></span><span class="mi" id="MathJax-Span-3493" style="font-family: STIXGeneral-Italic;">t<span style="display: inline-block; overflow: hidden; height: 1px; width: 0.003em;"></span></span></span><span style="display: inline-block; width: 0px; height: 2.543em;"></span></span></span><span style="border-left-width: 0.003em; border-left-style: solid; display: inline-block; overflow: hidden; width: 0px; height: 1.191em; vertical-align: -0.309em;"></span></span></nobr></span><script type="math/tex" id="MathJax-Element-321">first part</script></p>

<p>How to set up the environment on a MAC?</p>

<ol>
<li><p>download SWI-PROLOG from the internet and install it.</p></li>
<li><p>start the software and try this command:
writeln('hello world!').</p></li>
</ol>
<!-- content end -->
</div>
<br>
<br>
    <div id="disqus_thread"></div>
	<div class="footer">
		<p>© Copyright 2014 by isnowfy, Designed by isnowfy</p>
	</div>
</div>
<script src="main.js"></script>
<script src="http://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML"></script>
<script type="text/x-mathjax-config">
    MathJax.Hub.Config({tex2jax: {inlineMath: [['$','$'], ["\\(", "\\)"]], processEscapes: true}});
</script>
<script id="content" type="text/mustache">
    <h1>{{title}}</h1>
    <div class="tag">
    {{date}}
    {{#tags}}
    <a href="/#/tag/{{name}}">#{{name}}</a>
    {{/tags}}
    </div>
</script>
<script id="pagesTemplate" type="text/mustache">
    {{#pages}}
    <li>
        <a href="{{path}}">{{title}}</a>
    </li>
    {{/pages}}
</script>
<script>
$(document).ready(function() {
    $.ajax({
        url: "main.json",
        type: "GET",
        dataType: "json",
        success: function(data) {
            $("#title").html(data.name);
            var pagesTemplate = Hogan.compile($("#pagesTemplate").html());
            var pagesHtml = pagesTemplate.render({"pages": data.pages});
            $("#pages").append(pagesHtml);
            //path
            var path = "prolog.littlejshu.com";
            //path end
            var now = 0;
            for (var i = 0; i < data.posts.length; ++i)
                if (path == data.posts[i].path)
                    now = i;
            var post = data.posts[now];
            var tmp = post.tags.split(" ");
            var tags = [];
            for (var i = 0; i < tmp.length; ++i)
                if (tmp[i].length > 0)
                    tags.push({"name": tmp[i]});
            var contentTemplate = Hogan.compile($("#content").html());
            var contentHtml = contentTemplate.render({"title": post.title, "tags": tags, "date": post.date});
            $("#main").prepend(contentHtml);
            if (data.disqus_shortname.length > 0) {
                var disqus_shortname = data.disqus_shortname;
                (function() {
                    var dsq = document.createElement('script'); dsq.type = 'text/javascript'; dsq.async = true;
                    dsq.src = '//' + disqus_shortname + '.disqus.com/embed.js';
                    (document.getElementsByTagName('head')[0] || document.getElementsByTagName('body')[0]).appendChild(dsq);
                })();
            }
        }
    });
});
</script>
</body>
</html>
