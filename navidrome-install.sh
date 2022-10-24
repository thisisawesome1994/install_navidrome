apt update && apt upgrade -y
apt install vim ffmpeg
sudo install -d -o root -g root /opt/navidrome
sudo install -d -o root -g root /var/lib/navidrome
wget https://github.com/navidrome/navidrome/releases/download/v0.48.0/navidrome_0.48.0_Linux_x86_64.tar.gz -O Navidrome.tar.gz
sudo tar -xvzf Navidrome.tar.gz -C /opt/navidrome/
sudo chown -R root:root /opt/navidrome
echo 'MusicFolder = "/mnt/Music"' >> /var/lib/navidrome/navidrome.toml
echo '[Unit]' >> /etc/systemd/system/navidrome.service
echo 'Description=Navidrome Music Server and Streamer compatible with Subsonic/Airsonic' >> /etc/systemd/system/navidrome.service
echo 'After=remote-fs.target network.target' >> /etc/systemd/system/navidrome.service
echo 'AssertPathExists=/var/lib/navidrome' >> /etc/systemd/system/navidrome.service
echo '' >> /etc/systemd/system/navidrome.service
echo '[Install]' >> /etc/systemd/system/navidrome.service
echo 'WantedBy=multi-user.target' >> /etc/systemd/system/navidrome.service
echo '' >> /etc/systemd/system/navidrome.service
echo '[Service]' >> /etc/systemd/system/navidrome.service
echo 'User=root' >> /etc/systemd/system/navidrome.service
echo 'Group=root' >> /etc/systemd/system/navidrome.service
echo 'Type=simple' >> /etc/systemd/system/navidrome.service
echo 'ExecStart=/opt/navidrome/navidrome --configfile "/var/lib/navidrome/navidrome.toml"' >> /etc/systemd/system/navidrome.service
echo 'WorkingDirectory=/var/lib/navidrome' >> /etc/systemd/system/navidrome.service
echo 'TimeoutStopSec=20' >> /etc/systemd/system/navidrome.service
echo 'Restart=on-failure' >> /etc/systemd/system/navidrome.service
echo '' >> /etc/systemd/system/navidrome.service
echo '# See https://www.freedesktop.org/software/systemd/man/systemd.exec.html' >> /etc/systemd/system/navidrome.service
echo 'DevicePolicy=closed' >> /etc/systemd/system/navidrome.service
echo 'NoNewPrivileges=yes' >> /etc/systemd/system/navidrome.service
echo 'PrivateTmp=yes' >> /etc/systemd/system/navidrome.service
echo 'PrivateUsers=yes' >> /etc/systemd/system/navidrome.service
echo 'ProtectControlGroups=yes' >> /etc/systemd/system/navidrome.service
echo 'ProtectKernelTunables=yes' >> /etc/systemd/system/navidrome.service
echo 'RestrictAddressFamilies=AF_UNIX AF_INET AF_INET6' >> /etc/systemd/system/navidrome.service
echo 'RestrictNamespaces=yes' >> /etc/systemd/system/navidrome.service
echo 'RestrictRealtime=yes' >> /etc/systemd/system/navidrome.service
echo 'SystemCallFilter=~@clock @debug @module @mount @obsolete @reboot @setuid @swap' >> /etc/systemd/system/navidrome.service
echo 'ReadWritePaths=/var/lib/navidrome' >> /etc/systemd/system/navidrome.service
echo '' >> /etc/systemd/system/navidrome.service
echo 'ProtectSystem=full' >> /etc/systemd/system/navidrome.service
echo 'ProtectHome=true' >> /etc/systemd/system/navidrome.service
sudo systemctl daemon-reload
sudo systemctl start navidrome.service
sudo systemctl enable navidrome.service