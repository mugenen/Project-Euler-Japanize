'use strict';

getProblemNumber = () ->
    if document.URL.indexOf('http://projecteuler.net/problem=') == 0
        document.URL.split('=')[1].replace(/^0+/, '')
    else if document.URL.indexOf('http://projecteuler.net/index.php?section=problems&id=') == 0
        document.URL.split('=')[2].replace(/^0+/, '')
    else
        return ''

getJapanized = (num) ->
    xhr = $.ajax
        url: "http://odz.sakura.ne.jp/projecteuler/index.php?Problem%20#{num}"
        async: false
        crossDomain: true
    text = xhr.responseText
    start = text.indexOf('<div id="body"')
    end_outer = text.lastIndexOf('</table>')
    end_inner = text.lastIndexOf('</div>', text.lastIndexOf('</table>'))
    if start == -1 or end_outer == -1 or end_inner == -1
        return
    target = text.substring(start, end_inner + 6)
    jp_wiki = $(target)
    jp_wiki.children()

getProblemName = (jp) ->
    jp.eq(0).contents().eq(1).text()

num = getProblemNumber()

if not $.isNumeric(num)
    return

jp = getJapanized(num)
if not jp?
    return

name = getProblemName(jp)

$('h2').append(name)
$('.problem_content').prepend($('<hr>'))
$('.problem_content').prepend($("<p style=\"text-align: right;\"><a href=\"http://odz.sakura.ne.jp/projecteuler/index.php?Problem%20#{num}\">from http://odz.sakura.ne.jp/projecteuler/index.php?Problem%20#{num}</a></p>"))
$('.problem_content').prepend(jp.slice(1))
