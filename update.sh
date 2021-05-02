#!/bin/bash
git add .
read time <<< $(echo $(date) | awk '{print $2, $3, $6}')
git commit -m "updated at ""$time"
git push origin master
