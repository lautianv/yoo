source /hive/miners/custom/ore/h-manifest.conf

get_miner_uptime(){
  local uptime=0
  local log_time=$(stat --format='%Y' "$log_name")

  # If CPU config file doesn't exist, check if GPU config file exists. If it does, get its last modification time.
  if [ -e "$conf_name" ]; then
    local conf_time=$(stat --format='%Y' "$conf_name")
    let uptime=log_time-conf_time
  fi

  echo $uptime
}
# Function to get log time difference
get_log_time_diff() {
    local a=0
    let a=$(date +%s)-$(stat --format='%Y' "$log_name")
    echo $a
}


log_basename="/var/log/miner/custom/custom"
log_name="$log_basename.log"
conf_name="/hive/miners/custom/ore/ore.conf"

  hs_units="hs"
  algo="OREV2"
  uptime=$(get_miner_uptime)
  h=`tail $log_name  -n 50 | grep Hash | tail -n 1 | cut -d " " -f5`
  khs=`echo $h | awk '{print $1/1000}'`
  hs[0]="$h"
  hs[1]="$h"


  stats=$(jq -nc \
            --arg khs "$khs" \
            --arg hs_units "$hs_units" \
            --arg uptime "$uptime" \
            --argjson hs "`echo ${hs[@]} | tr " " "\n" | jq -cs '.'`" \
            --arg algo "$algo" \
            '{$hs, $hs_units, $uptime, $algo}')
 echo khs:   $khs
 echo stats: $stats
 echo ----------
