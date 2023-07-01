#!/bin/bash


API_URL="https://public.api.openprocurement.org/api/2.5/tenders"
BASE_URL=${API_URL}

while [[ -n "${API_URL}" ]]; do
    echo "Fetching ${API_URL}"
    RESPONSE=$(curl -s "${API_URL}")
    
    echo "${RESPONSE}" | jq -rc '.data[] | {date: (.dateModified), id: .id}' | while read DATA; do
        DATE=$(echo "${DATA}" | jq -r '.date')
        ID=$(echo "${DATA}" | jq -r '.id')
        YEAR_MONTH=$(date -d "${DATE}" '+%Y-%m')
        FILENAME="urls_${YEAR_MONTH}.txt"
        LINE="${DATE} ${BASE_URL}/${ID}"
        
        # check if the line already exists in the file
        if ! grep -Fxq "${LINE}" "${FILENAME}"; then
            # if the line does not exist, append it to the file
            echo "${LINE}" >> "${FILENAME}"
        fi
    done

    API_URL=$(echo "${RESPONSE}" | jq -r '.next_page.uri // empty')
done

