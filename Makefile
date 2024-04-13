.PHONY: update setup-github-cli setup-git-config install-oh-my-zsh install-fonts install-powerlevel10k install-plugins install-stow install-docker-kubectl install-kind install-helm install-opentofu info help set-gpg-key unistall-all

all: update setup-github-cli setup-git-config install-oh-my-zsh install-fonts install-powerlevel10k install-plugins install-stow install-docker-kubectl install-kind install-helm install-opentofu set-gpg-key info

KUBECTL_VERSION := v1.29.1
KIND_VERSION := v0.20.0

update:
	sudo apt update && sudo apt upgrade -y

setup-github-cli:
	type -p curl >/dev/null || (sudo apt update && sudo apt install curl -y)
	curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg \
	&& sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg \
	&& echo "deb [arch=$$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
	&& sudo apt update \
	&& sudo apt install gh -y

setup-git-config:
	gh auth login
	git config --global user.name "Raphael Borges"
	git config --global user.email "53947674+Rapha-Borges@users.noreply.github.com"
	gpg --full-generate-key
	
install-oh-my-zsh:
	sudo rm -rf /home/rapha/.zshrc /home/rapha/.zshrc.pre-oh-my-zsh*
	sudo apt install zsh -y
	zsh --version
	sudo rm -rf "/home/rapha/.oh-my-zsh"
	sh -c "$$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

install-fonts:
	# Download and install MesloLGS NF fonts
	wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf
	wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf
	wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf
	wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf
	mkdir -p ~/.local/share/fonts/
	mv MesloLGS* ~/.local/share/fonts/

install-powerlevel10k:
	git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $${ZSH_CUSTOM:-$$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

install-plugins:
	git clone https://github.com/zsh-users/zsh-autosuggestions $${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

install-stow:
	sudo apt-get install stow
	sudo rm -rf ~/.dotfiles
	git clone https://github.com/Rapha-Borges/.dotfiles.git ~/.dotfiles
	sudo rm -rf ~/.zshrc ~/.oci ~/.kube ~/.ssh ~/.bashrc ~/cosign ~/.p10k.zsh ~/.vimrc ~/.zshrc.pre-oh-my-zsh*
	cd ~/.dotfiles && stow .

install-docker-kubectl:
	curl -fsSL https://get.docker.com -o get-docker.sh
	sudo sh get-docker.sh
	curl -LO https://dl.k8s.io/release/$(KUBECTL_VERSION)/bin/linux/amd64/kubectl
	sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
	rm get-docker.sh kubectl

install-kind:
	[ $$(uname -m) = x86_64 ] && curl -Lo ./kind https://kind.sigs.k8s.io/dl/$(KIND_VERSION)/kind-linux-amd64
	chmod +x ./kind
	sudo mv ./kind /usr/local/bin/kind

install-helm:
	curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

install-opentofu:
	curl --proto '=https' --tlsv1.2 -fsSL https://get.opentofu.org/install-opentofu.sh -o install-opentofu.sh
	chmod +x install-opentofu.sh
	./install-opentofu.sh --install-method deb
	rm install-opentofu.sh

set-gpg-key:
	@GPG_KEY_ID=$$(gpg --list-secret-keys --keyid-format=long | grep sec | awk '{print $$2}' | awk -F/ '{print $$2}'); \
	git config --global user.signingkey $$GPG_KEY_ID; \
	git config --global commit.gpgSign true; \
	echo "GPG Key ID: $$GPG_KEY_ID set for Git"

info:
	@echo "############################### MANUAL STEPS #################################################"
	@echo "Run 'chsh -s \$$(which zsh)' to change the default shell to zsh"
	@echo "To finish the setup, run 'dockerd-rootless-setuptool.sh install' and follow the instructions"
	@GPG_KEY_ID=$$(gpg --list-secret-keys --keyid-format=long | grep sec | awk '{print $$2}' | awk -F/ '{print $$2}'); \
	export GPG_KEY_ID=$$GPG_KEY_ID; \
	echo "Run ' gpg --armor --export $$GPG_KEY_ID ' and add the value to your GitHub account at https://github.com/settings/gpg/new"
	@echo "############################### MANUAL STEPS #################################################"

unistall-all:
	-sudo apt-get remove gh zsh stow docker-buildx-plugin docker-ce-cli docker-ce-rootless-extras docker-compose-plugin containerd.io kubectl -y
	-sudo rm -rf /usr/local/bin/kind /usr/local/bin/helm
	-sudo rm -rf ~/.oh-my-zsh ~/.zshrc ~/.local/share/fonts/MesloLGS* /usr/local/bin/kind /usr/local/bin/helm /usr/local/bin/kubectl /usr/local/bin/docker /usr/local/bin/dockerd-rootless-setuptool.sh /usr/local/bin/opentofu
	-sudo rm -rf /etc/apt/sources.list.d/github-cli.list /etc/apt/sources.list.d/kubernetes.list /etc/apt/keyrings/githubcli-archive-keyring.gpg /etc/apt/keyrings/kubernetes-apt-keyring.gpg
	-sudo rm -rf /themes/powerlevel10k /plugins/zsh-autosuggestions
	-sudo apt-get autoremove -y
	-sudo apt-get clean

help:
	@echo "Usage: make [target]"
	@echo "Targets:"
	@echo "  update: Update and upgrade the system"
	@echo "  setup-github-cli: Install GitHub CLI"
	@echo "  setup-git-config: Configure Git"
	@echo "  install-oh-my-zsh: Install Oh My Zsh"
	@echo "  install-fonts: Install MesloLGS NF fonts"
	@echo "  install-powerlevel10k: Install Powerlevel10k theme"
	@echo "  install-plugins: Install zsh-autosuggestions plugin"
	@echo "  install-stow: Install stow and clone .dotfiles"
	@echo "  install-docker-kubectl: Install Docker and kubectl"
	@echo "  install-kind: Install kind"
	@echo "  install-helm: Install Helm"
	@echo "  install-opentofu: Install OpenTofu"
	@echo "  set-gpg-key: Set GPG Key for Git"
	@echo "  info: Show manual steps"
	@echo "  unistall-all: Uninstall all installed packages and remove files"
	@echo "  help: Show this help message"
