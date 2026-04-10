paru -S --needed - < apps.txt
sudo mkdir -p /srv/omv/mergerfs/{mgfsp1-cache,mgfsp1-nocache}
sudo mkdir -p /srv/omv/zfs/zfsmr01-mediadata
sudo chown -R ulyesses:ulyesses /srv/omv
sudo chmod -R 755 /srv/omv
