.PHONY: update setup-telegram setup-visual-studio-code setup-zoho-mail setup-chrome setup-slack setup-galaxy-buds-client setup-droidcam

all: update setup-telegram setup-visual-studio-code setup-zoho-mail setup-chrome setup-slack setup-galaxy-buds-client

update:
	sudo apt update && sudo apt upgrade -y

setup-telegram:
	wget https://telegram.org/dl/desktop/linux -O telegram.tar.xz
	tar -xf telegram.tar.xz
	sudo mv Telegram /opt/
	sudo ln -s /opt/Telegram/Telegram /usr/bin/telegram
	rm telegram.tar.xz

setup-visual-studio-code:
	wget https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64 -O code.deb
	sudo dpkg -i code.deb
	rm code.deb

setup-zoho-mail:
	wget https://downloads.zohocdn.com/zmail-desktop/linux/zoho-mail-desktop-lite-installer-x64-v1.6.1.deb -O zoho-mail.deb
	sudo dpkg -i zoho-mail.deb
	rm zoho-mail.deb

setup-chrome:
	wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -O chrome.deb
	sudo dpkg -i chrome.deb
	rm chrome.deb

setup-slack:
	wget https://downloads.slack-edge.com/desktop-releases/linux/x64/4.37.101/slack-4.37.101-0.1.el8.x86_64.rpm -O slack.rpm
	sudo rpm -i slack.rpm
	rm slack.rpm

setup-galaxy-buds-client:
	flatpak install me.timschneeberger.GalaxyBudsClient -y

setup-droidcam:
	cd /tmp
	wget -O droidcam_latest.zip https://files.dev47apps.net/linux/droidcam_2.1.3.zip
	# sha1sum: 2646edd5ad2cfb046c9c695fa6d564d33be0f38b
	unzip droidcam_latest.zip -d droidcam
	cd droidcam && sudo ./install-client
	sudo apt install libappindicator3-1 linux-headers-`uname -r` gcc make -y
	sudo ./install-video
	sudo rmmod v4l2loopback_dc
	sudo insmod /lib/modules/`uname -r`/kernel/drivers/media/video/v4l2loopback-dc.ko width=1920 height=1080