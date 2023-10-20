#!/usr/bin/env sh

CNTX={users}
NAME={prex-aliya}
PAGE=1

#tor &
curl "https://api.github.com/$CNTX/$NAME/repos?page=$PAGE&per_page=100" |
    grep -e 'clone_url*' |
    cut -d \" -f 4 |
    proxychains xargs -L1 git clone
