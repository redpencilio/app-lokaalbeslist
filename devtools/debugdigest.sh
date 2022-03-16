# 0: Get IPs
DELIVER_EMAIL_SERVICE_IP=`docker network inspect app-lokaalbeslist_default | jq -r '.[0].Containers[] | select(.Name == "app-lokaalbeslist-deliver-email-service-1") | .IPv4Address [:-3]'`
SUBSCRIPTION_IP=`docker network inspect app-lokaalbeslist_default | jq -r '.[0].Containers[] | select(.Name == "app-lokaalbeslist-subscription-1") | .IPv4Address [:-3]'`

echo "Using IP: $DELIVER_EMAIL_SERVICE_IP for app-lokaalbeslist-deliver-email-service-1"
echo "Using IP: $SUBSCRIPTION_IP for app-lokaalbeslist-subscription-1"

# 1: Post delta
http POST $SUBSCRIPTION_IP/.mu/delta @devtools/exampledelta.json

# 2: Trigger subscription-service (adds a subscription mail to the queue)
http POST $SUBSCRIPTION_IP/notify_users/weekly

# 3: Trigger deliver-email-service (empties mail queue)
http POST $DELIVER_EMAIL_SERVICE_IP/email-delivery/