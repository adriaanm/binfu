#!/bin/bash

# TODO: not entirely working yet, tidy fails hard when html can't be parsed
# xsltproc is last because tidy seems to not preserve attrib order, but we want them sorted for smaller diffs
# also, the output is not entirely canonical
tidy -q -wrap 0 -i -utf8  -ashtml "$1" 2> /dev/null | xsltproc --html ~/bin/xml-attr-sort.xml 2> /dev/null

exit 0