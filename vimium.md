## Move Tabs
map < moveTabLeft
map > moveTabRight

## Custom search engines with o or O then space bar
a: https://www.amazon.com/s?k=%s&shipTo=19711&language=en_US Amazon US (Forced Delware)
g: https://github.com/search?q=%s&type=repositories GitHub
l: https://wiki.archlinux.org/title/Special:Search/%s ArchWiki
r: https://www.google.com/search?q=site:reddit.com+%s Reddit (Google)
y: https://www.youtube.com/results?search_query=%s Youtube

## Custom css styles
```bash
div > .vimiumHintMarker {
  background: rgba(240, 240, 240, 0.9);
  border: 1px solid #ccc;
  border-radius: 4px;
  box-shadow: 0 1px 3px rgba(0, 0, 0, 0.15);
}

div > .vimiumHintMarker span {
  color: #333;
  font-weight: 600;
  font-size: 12px;
}

div > .vimiumHintMarker > .matchingCharacter {
  color: #007acc; /* soft blue for matches */
}
