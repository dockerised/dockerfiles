#!/bin/bash

# start 1541078700
# end 1541081400
#./logshare-cli --api-key $CLOUDFLARE_KEY --api-email $CLOUDFLARE_EMAIL --zone-id $CLOUDFLARE_ZONE_ID --timestamp-format rfc3339 --count -1 --start-time 1541079000 --end-time 1541079060 > ELS/logs.5

start_time=$1
end_time=$2
log_prefix=${3:-cloudflare}
log_count=1

temp_start_time=$start_time
temp_end_time=$start_time

while [ $temp_end_time -lt $end_time ]
do
  temp_end_time=$((temp_start_time + 60))
  log_suffix=$(printf "%03d" $log_count)
  echo "Fetching logs from $temp_start_time to ${temp_end_time}..."
  ./logshare-cli --api-key $CLOUDFLARE_KEY --api-email $CLOUDFLARE_EMAIL --zone-id $CLOUDFLARE_ZONE_ID --timestamp-format rfc3339 --count -1 --start-time $temp_start_time --end-time $temp_end_time > ELS/${log_prefix}.${log_suffix}

  echo "Compressing the log..."
  gzip ELS/${log_prefix}.${log_suffix}

  temp_start_time=$temp_end_time
  log_count=$((log_count + 1))
done
