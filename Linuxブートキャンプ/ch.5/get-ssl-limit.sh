openssl s_client -connect gihyo.jp:443 -servername gihyo.jp < /dev/null | \
> openssl x509 -noout -enddate|awk -F= '{print $2}'| date -d "$(cat -)" '+%s'| \
> echo '(' $(cat) - $(date '+%s') ')/(60*60*24)'|bc