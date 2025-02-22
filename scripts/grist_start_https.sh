#!/bin/bash

docker run \
  -p 80:80 -p 443:443 \
  -e URL=https://grist.pugetsoundsra.org \
  -e TEAM=pssra-admin \
  -e HTTPS=auto \
  -e EMAIL=$GRIST_EMAIL_ONE \
  -e PASSWORD=$GRIST_PASS_ONE \
  -e EMAIL2=$GRIST_EMAIL_TWO \
  -e PASSWORD2=$GRIST_PASS_TWO \
  -v /mnt/prod_grist_data:/persist \
  --name grist \
  --restart unless-stopped \
  -it gristlabs/grist-omnibus
