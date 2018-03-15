#!/bin/bash

# TODO: not entirely working yet, tidy fails hard when html can't be parsed
# also, the output is not entirely canonical
cat "$1" | perl -pe 's/\s+/ /gm' | tidy -q --sort-attributes alpha --wrap 0 -i -utf8  -ashtml - 2> /dev/null

exit 0