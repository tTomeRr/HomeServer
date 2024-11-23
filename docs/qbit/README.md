# Installing and Configuring qBittorrent WebUI

## Installation Steps
1. Update system packages:
   ```bash
   sudo apt update && sudo apt upgrade -y
   ```

2. Add qBittorrent repository and install:
   ```bash
   sudo add-apt-repository ppa:qbittorrent-team/qbittorrent-stable
   sudo apt update
   sudo apt install qbittorrent-nox -y
   ```

3. Create and configure service user:
   ```bash
   sudo adduser qbtuser
   sudo usermod -s /usr/sbin/nologin qbtuser
   sudo usermod -s /bin/bash qbtuser
   ```

## Initial Configuration
1. Switch to qbtuser:
   ```bash
   sudo su qbtuser
   ```

2. Run initial setup:
   ```bash
   qbittorrent-nox
   ```
   - Complete the installation questions
   - Access WebUI at `http://[server-ip]:8080`
   - Press Ctrl+C to quit the process

## Systemd Service Setup
1. Create service file at `/usr/lib/systemd/system/qbittorrent-nox@.service`:
   ```ini
   [Unit]
   Description=qBittorrent-nox service for user %i
   Documentation=man:qbittorrent-nox(1)
   Wants=network-online.target
   After=network-online.target nss-lookup.target

   [Service]
   Type=simple
   User=qbtuser
   ExecStart=/usr/bin/qbittorrent-nox
   Restart=on-failure

   [Install]
   WantedBy=multi-user.target
   ```

2. Enable and start service:
   ```bash
   sudo systemctl start qbittorrent-nox@qbtuser
   sudo systemctl enable qbittorrent-nox@qbtuser
   ```

## Setting Default Login Credentials
1. Stop the service:
   ```bash
   sudo systemctl stop qbittorrent-nox@qbtuser
   ```

2. Edit configuration file:
   ```bash
   vim /home/qbtuser/.config/qBittorrent/qBittorrent.conf
   ```

3. Add the following configuration:
   ```ini
   [Preferences]
   WebUI\Password_PBKDF2="@ByteArray(ARQ77eY1NUZaQsuDHbIMCA==:0WMRkYTUWVT9wVvdDtHAjU9b3b7uB8NR1Gur2hmQCvCDpm39Q+PsJRJPaCU51dEiz+dTzh8qbPsL8WkFljQYFQ==)"
   ```

4. Start the service:
   ```bash
   sudo systemctl start qbittorrent-nox@qbtuser
   ```

## Access Information
- WebUI URL: `http://[server-ip]:8080`
- Default login:
  - Username: admin
  - Password: adminadmin

## Reference
- [qBittorrent-nox Installation](https://github.com/qbittorrent/qBittorrent/wiki/Running-qBittorrent-without-X-server-(WebUI-only,-systemd-service-set-up,-Ubuntu-15.04-or-newer))
