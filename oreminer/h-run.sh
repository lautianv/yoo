#!/usr/bin/env bash

[ -t 1 ] && . colors

source h-manifest.conf
source $CUSTOM_CONFIG_FILENAME

[[ `ps aux | grep "ore-miner" | grep -v grep | wc -l` != 0 ]] &&
  echo -e "${RED}$MINER_NAME $CUSTOM_NAME miner is already running${NOCOLOR}" &&
  exit 1

./ore-miner worker  $EXTRA 2>&1 | tee --append $MINER_LOG_BASENAME.log

