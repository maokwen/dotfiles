#!/bin/sh

mkdir -p tmp

jq -n -f template.jsonl >tmp/template.json

#curl -o tmp/outbounds.ori.json "https://dler.cloud/subscribe/J2LVklbQNfWBagndA0vZ?protocols=smart&provider=singbox&lv=2%7C3"

jq 'del(.outbounds.[] | select(.type=="direct" or .type=="dns" or .type=="block" or .type=="selector" or .type=="urltest"))' tmp/outbounds.ori.json >tmp/outbounds.json

jq '.outbounds.[] | .tag' tmp/outbounds.json | jq -n '.tag="auto" | .type="urltest" | .outbounds |= [inputs] | {outbounds: [.]}' >tmp/urltest.json

jq '.outbounds.[] | .tag' tmp/outbounds.json | jq -n '.tag="select" | .type="selector" | .outbounds |= [inputs] | {outbounds: [.]}' | jq '.outbounds.[].outbounds |= ["auto"] + .' >tmp/selector

jq -s '.[0].outbounds=([.[].outbounds]|flatten)|.[0]' tmp/template.json tmp/selector.json tmp/urltest.json tmp/outbounds.json >config.json

sudo cp config.json /etc/sing-box/config.json
sudo chown sing-box:sing-box /etc/sing-box/config.json

# jq -n -f template.jsonl > template.json
# jq -s '.[0] * .[1]' template.json outbounds.conf > config.json.merge
# jq 'del(.outbounds.[] | select(.type=="direct" or .type=="dns" or .type=="block" or .tag=="AdBlock"))' config.json.merge > config.json
#
# jq 'del(.outbounds.[] | select(.type=="direct" or .type=="dns" or .type=="block" or (.outbounds | contains("block")) ))' config.json
# jq '.outbounds.[] | select(.outbounds) | contains("block")' config.json
# jq '.outbounds.[].outbounds.[]' config.json
# jq '.outbounds.[].outbounds | any("block")' config.json
# jq 'select(.outbounds.[] | select(.outbounds.[].outbounds | any("block")))' config.json
#
#jq '.outbounds.[] | .tag' tmp/outbounds.json | jq -n '.tag="select" | .type="selector" | .outbounds |= [inputs] | {outbounds: [.]}' | jq '.outbounds += [{tag: "auto", type: "urltest", outbounds: [.outbounds.[].outbounds.[]] }]'
