#!/bin/bash
counter=0
echo "Beginning to download the greatest TV show ever"
#ep1 - https://mtg-vod-http.babahhcdn.com/mtg/_definst_/smil:tv3/prooviabielu/season1/20388082/20388082e_HD.smil/media_b1096000_sleng_${counter}.ts
#ep2 - https://mtg-vod-http.babahhcdn.com/mtg/_definst_/smil:tv3/prooviabielu/season1/20388083/20388083_HD.smil/media_b1096000_sleng_${counter}.ts
#ep3 - https://mtg-vod-http.babahhcdn.com/mtg/_definst_/smil:tv3/prooviabielu/season1/20388084/20388084_HD.smil/media_b1096000_sleng_${counter}.ts
#ep4 - https://mtg-vod-http.babahhcdn.com/mtg/_definst_/smil:tv3/prooviabielu/season1/20388085/20388085_HD.smil/media_b1096000_sleng_${counter}.ts
while [[ true ]]; do
  current_time_nanos=$(ruby -e 'puts Time.now.to_f')
  wget -q "https://mtg-vod-http.babahhcdn.com/mtg/_definst_/smil:tv3/prooviabielu/season1/20388083/20388083_HD.smil/media_b1096000_sleng_${counter}.ts" -O ${current_time_nanos}.ts
  if [ $? -ne 0 ];then
    break
  else
    echo "Downloading part ${counter}"
    counter=$((counter+1))
  fi
done

echo "Finished downloading all parts. Found total of ${counter} files"
echo "Generating whole episode"

timestamp=$(date +%s)
cat *.ts > all.ts
ffmpeg -i all.ts -acodec copy -vcodec copy ${timestamp}-final.mp4
echo "Cleaning up partial files"
rm -rf *.ts

exit
