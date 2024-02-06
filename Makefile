.PHONY: setup-github-cli setup-git-config install-oh-my-zsh install-fonts install-powerlevel10k install-plugins install-stow install-docker-kubectl install-kind install-helm install-opentofu info set-gpg-key unistall-all

all: setup-github-cli setup-git-config install-oh-my-zsh install-fonts install-powerlevel10k install-plugins install-stow install-docker-kubectl install-kind install-helm install-opentofu info

setup-github-cli:
	type -p curl >/dev/null || (sudo apt update && sudo apt install curl -y)
	curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg \
	&& sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg \
	&& echo "deb [arch=amd64 signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
	&& sudo apt update \
	&& sudo apt install gh -y

setup-git-config:
	gh auth login
	git config --global user.name "Raphael Borges"
	git config --global user.email "raps_rnb@hotmail.com"
	gpg --full-generate-key
	
install-oh-my-zsh:
	sudo apt install zsh -y
	zsh --version
	wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh
	sudo chmod +x install.sh
	sh -c ./install.sh
	rm install.sh

install-fonts:
	# Download and install MesloLGS NF fonts
	curl -O https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf 
	curl -O https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf
	curl -O https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf
	curl -O https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf
	sudo mkdir -p ~/.local/share/fonts/
	sudo mv MesloLGS* ~/.local/share/fonts/

install-powerlevel10k:
	git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k

install-plugins:
	git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions

install-stow:
	sudo apt-get install stow
	cd ~
	git clone https://github.com/Rapha-Borges/.dotfiles.git
	rm .zshrc
	cd .dotfiles && sudo stow .

install-docker-kubectl:
	curl -fsSL https://get.docker.com -o get-docker.sh
	sudo sh get-docker.sh
	sudo apt-get install -y apt-transport-https ca-certificates curl
	curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.29/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
	echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.29/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list
	sudo apt-get update
	sudo apt-get install -y kubectl

install-kind:
	curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.20.0/kind-linux-amd64
	chmod +x ./kind
	sudo mv ./kind /usr/local/bin/kind

install-helm:
	curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

install-opentofu:
	curl --proto '=https' --tlsv1.2 -fsSL https://get.opentofu.org/install-opentofu.sh -o install-opentofu.sh
	chmod +x install-opentofu.sh
	./install-opentofu.sh --install-method deb
	rm install-opentofu.sh

info:
	gpg --list-secret-keys --keyid-format=long
	@echo "Run 'chsh -s \$$(which zsh)' to change the default shell to zsh"
	@echo "To finish the setup, run 'dockerd-rootless-setuptool.sh install' and follow the instructions"
	@echo "Copy your GPG key ID from the list and run 'make set-gpg-key GPG_KEY_ID=<GPG key ID>' and 'run sudo make set-gpg-key'"

set-gpg-key:
	git config --global user.signingkey $(GPG_KEY_ID) # TODO FIX
	git config --global commit.gpgsign true

unistall-all:
	-sudo apt-get remove gh zsh stow docker-buildx-plugin docker-ce-cli docker-ce-rootless-extras docker-compose-plugin containerd.io kubectl -y
	-sudo rm -rf /usr/local/bin/kind /usr/local/bin/helm
	-sudo rm -rf ~/.oh-my-zsh ~/.zshrc ~/.local/share/fonts/MesloLGS* /usr/local/bin/kind /usr/local/bin/helm /usr/local/bin/kubectl /usr/local/bin/docker /usr/local/bin/dockerd-rootless-setuptool.sh /usr/local/bin/opentofu
	-sudo rm -rf /etc/apt/sources.list.d/github-cli.list /etc/apt/sources.list.d/kubernetes.list /etc/apt/keyrings/githubcli-archive-keyring.gpg /etc/apt/keyrings/kubernetes-apt-keyring.gpg
	-sudo rm -r /themes/powerlevel10k /plugins/zsh-autosuggestions
	-sudo apt-get autoremove -y
	-sudo apt-get clean