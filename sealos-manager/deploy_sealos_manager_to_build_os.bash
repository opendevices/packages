#!/bin/bash

source ./environment

echo "Deploying  $TARGET  -  to Server $SERVER"

BRANCH=$BRANCH
VERSION=$VERSION
MANAGERS_PATHS=$FILES

# Lets clean previous deployments
ssh -p $SSHPORT $USER@$SERVER rm -fr $TARGET
ssh -p $SSHPORT $USER@$SERVER mkdir -p $TARGET

# Prepare filesystem
ssh -p $SSHPORT $USER@$SERVER sudo mkdir -p /mnt/storage/$SERVER/www/tools/${TARGET}/download/
ssh -p $SSHPORT $USER@$SERVER sudo mkdir -p /mnt/storage/$SERVER/www/tools/${TARGET}/releases/

# Copy release content
scp -r -P $SSHPORT ./releases $USER@$SERVER:~/${TARGET}/

# Copy download content
for i in "${MANAGERS_PATHS[@]}"
do
        remote_path="${TARGET}/download/$BRANCH/$VERSION/"
        ssh -p $SSHPORT $USER@$SERVER mkdir -p ${remote_path}
        scp -pr -P $SSHPORT ./$i $USER@$SERVER:~/${remote_path}
done

ssh -p $SSHPORT $USER@$SERVER sudo -E cp -f -r $HOME/${TARGET}/ /mnt/storage/${SERVER}/www/tools/

# Lets fix permissions in cases
ssh -p $SSHPORT $USER@$SERVER sudo chown -R www-data.www-data /mnt/storage/$SERVER/www/tools/${TARGET}/

exit 0
