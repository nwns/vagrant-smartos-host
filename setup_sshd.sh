#!/bin/bash

exec >/var/log/setup_sshd.log 2>&1
set -o xtrace

cat >/usbkey/ssh/sshd_config <<EOFSSHDCONF
# Adapted for Vagrant Boxes from Original

Protocol 2
Port 22
LookupClientHostnames no
VerifyReverseMapping no
ListenAddress ::
GatewayPorts no
X11Forwarding yes
X11DisplayOffset 10
X11UseLocalhost yes
MaxStartups 10:30:60
PrintMotd no
KeepAlive yes
SyslogFacility auth
LogLevel info

HostKey /var/ssh/ssh_host_rsa_key
HostKey /var/ssh/ssh_host_dsa_key

ServerKeyBits 1024
KeyRegenerationInterval 3600
StrictModes yes
LoginGraceTime 600
MaxAuthTries    6
MaxAuthTriesLog 3
PermitEmptyPasswords no
PasswordAuthentication yes
PermitRootLogin yes
Subsystem       sftp    internal-sftp
IgnoreRhosts yes
RhostsAuthentication no
RhostsRSAAuthentication no
RSAAuthentication yes

# Disable GSS since we don't need it and it slows down login
GSSAPIAuthentication no
GSSAPIKeyExchange no

AuthorizedKeysFile /usbkey/ssh/authorized_keys
EOFSSHDCONF
