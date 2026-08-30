#!/bin/bash

if rsync -a --delete --exclude='.*/' "$HOME/" /tmp/backup/; then
    logger -t home-backup -p user.info "OK: копия $HOME создана"
else
    logger -t home-backup -p user.err "FAIL: rsync вернул код $?"
fi
