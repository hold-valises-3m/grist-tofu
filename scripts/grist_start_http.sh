#!/bin/bash

docker run \
  -p 80:80 -p 443:443 \
  -e URL=143.198.245.2 \
  -e TEAM=pssra_admin \
  -e EMAIL=$GRIST_EMAIL_ONE \
  -e PASSWORD=$GRIST_PASS_ONE \
  -v /mnt/prod_grist_data:/persist \
  --name grist \
  --restart unless-stopped \
  -d \
  -it gristlabs/grist-omnibus
