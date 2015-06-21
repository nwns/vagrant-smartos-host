#!/bin/bash

exec >/var/log/setup_insecure_vagrant_key.sh 2>&1

PUB_KEY="ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA6NF8iallvQVp2\
	2WDkTkyrtvp9eWW6A8YVr+kz4TjGYe7gHzIw+niNltGEFHzD8+\
	v1I2YJ6oXevct1YeS0o9HZyN1Q9qgCgzUFtdOKLv6IedplqoPk\
	cmF0aYet2PkEDo3MlTBckFXPITAMzF8dJSIFo9D8HfdOV0IAdx\
	4O7PtixWKn5y2hMNG0zQPyUecp4pzC6kivAIhyfHilFR61RGL+\
	GPXQ2MWZWFYbAGjyiYJnAmCP3NOTd0jMZEnDkbUvxhMmBYSdET\
	k1rRgm+R4LOzFUGaHqHDLKLX+FIPKcF96hrucXzcWyLbIbEgE9\
	8OHlnVYCzRdK8jlqm8tehUc9c9WhQ== \
	vagrant insecure public key"
KEY_FILE=/usbkey/ssh/authorized_keys

echo $PUB_KEY >$KEY_FILE
chmod 600 $KEY_FILE
