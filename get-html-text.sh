#!/bin/bash

URL="https://prozorro.gov.ua/tender/UA-2023-07-01-000105-a"
wget -O- "$URL" | hxnormalize -x 2>/dev/null | hxselect -s '\n' -c 'body main div:nth-child(4)' | lynx -stdin -dump

