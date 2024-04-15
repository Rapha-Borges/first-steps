.PHONY: update install-telegram install-visual-studio-code install-zoho-mail install-chrome install-slack install-galaxy-buds-client install-droidcam

all: update install-telegram install-visual-studio-code install-zoho-mail install-chrome install-slack install-galaxy-buds-client

update:
	sudo apt update && sudo apt upgrade -y

install-telegram:
	wget 'https://telegram.org/dl/desktop/linux' -O telegram.tar.xz
	tar -xf telegram.tar.xz
	sudo mv Telegram /opt/
	sudo ln -s /opt/Telegram/Telegram /usr/bin/telegram
	rm telegram.tar.xz

install-visual-studio-code:
	wget 'https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64' -O code.deb
	sudo dpkg -i code.deb
	rm code.deb

install-zoho-mail:
	wget 'https://downloads.zohocdn.com/zmail-desktop/linux/zoho-mail-desktop-lite-installer-x64-v1.6.1.deb' -O zoho-mail.deb
	sudo dpkg -i zoho-mail.deb
	rm zoho-mail.deb

install-chrome:
	wget 'https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb' -O chrome.deb
	sudo dpkg -i chrome.deb
	rm chrome.deb

install-slack:
	sudo snap install slack

install-galaxy-buds-client:
	flatpak install me.timschneeberger.GalaxyBudsClient -y

install-droidcam:
	cd /tmp
	wget -O droidcam_latest.zip 'https://files.dev47apps.net/linux/droidcam_2.1.3.zip'
	# sha1sum: 2646edd5ad2cfb046c9c695fa6d564d33be0f38b
	unzip droidcam_latest.zip -d droidcam
	cd droidcam && sudo ./install-client
	sudo apt install libappindicator3-1 linux-headers-`uname -r` gcc make -y
	sudo ./install-video
	sudo rmmod v4l2loopback_dc
	sudo insmod /lib/modules/`uname -r`/kernel/drivers/media/video/v4l2loopback-dc.ko width=1920 height=1080

install-aws-cli:
	curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
	unzip awscliv2.zip
	sudo ./aws/install
	rm -rf awscliv2.zip aws