![Terminal ScreenShot](https://github.com/Rapha-Borges/Oh-My-Zsh/blob/main/img/ScreenShot%20.png)

# Install Oh-My-Zsh and configure the terminal

1. Install Zsh
```
sudo apt install zsh
```
2. Check the version to confirm the installation
```
zsh --version
```
3. Set Zsh as the default shell
```
chsh -s $(which zsh)
```
4. Log out and log in back for the changes to take effect. Then verify that Zsh is the default shell:
```
echo $SHELL
```
5. Install Oh My Zsh
```
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```
6. Install MesloLGS NF font

- [MesloLGS NF Regular.ttf](https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf)

- [MesloLGS NF Bold.ttf](https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf)

- [MesloLGS NF Italic.ttf](https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf)

- [MesloLGS NF Bold Italic.ttf](https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf)

7. Open the terminal and press `0` to create the file ~/.zshrc containing just a comment

8. Setup the font in your terminal

    Open Terminal → Preferences and click on the selected profile under Profiles. Check Custom font under Text Appearance and select `MesloLGS NF Regular`.

9. Install powerlevel10k theme
```
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
```
10. Replace .pk10k.zsh and .zshrc files
```
curl https://raw.githubusercontent.com/Rapha-Borges/Oh-My-Zsh/master/files/.p10k.zsh > $HOME/.p10k.zsh && curl https://raw.githubusercontent.com/Rapha-Borges/Oh-My-Zsh/master/files/.zshrc > $HOME/.zshrc
```
11. Install plugins
```
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
```

# Log in at GitHub and configure the commit signature

1. Install GitHub CLI
```
type -p curl >/dev/null || (sudo apt update && sudo apt install curl -y)
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg \
&& sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg \
&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
&& sudo apt update \
&& sudo apt install gh -y
```
2. Authenticate with your GitHub account
```
gh auth login
```
3. Set name and email
```
git config --global user.name "<Your Name>"
git config --global user.email "<Your Email>"
```
4. Generate a new GPG key (RSA and RSA, 4096 bits, 0 day expiration, name and the verified email address for your GitHub)
```
gpg --full-generate-key
```
5. List the GPG keys
```
gpg --list-secret-keys --keyid-format=long
```
From the list of GPG keys, copy the long form of the GPG key ID you'd like to use. In this example, the GPG key ID is 3AA5C34371567BD2:
```
gpg --list-secret-keys --keyid-format=long
/Users/hubot/.gnupg/secring.gpg
------------------------------------
sec   4096R/3AA5C34371567BD2 2016-03-10 [expires: 2017-03-10]
uid                          Hubot <hubot@example.com>
ssb   4096R/4BB6D45482678BE3 2016-03-10
```
6. Copy your GPG key, beginning with `-----BEGIN PGP PUBLIC KEY BLOCK-----` and ending with `-----END PGP PUBLIC KEY BLOCK-----`.
```
gpg --armor --export <GPG key ID>
```
7. Go to GitHub → Settings → SSH and GPG keys → [New GPG key](https://github.com/settings/gpg/new) and paste your GPG key.
8. Set the GPG signing key in Git
```
git config --global user.signingkey <GPG key ID>
```
9. Configure Git to sign all commits
```
git config --global commit.gpgsign true
```

# Install Docker and Kubectl

1. Install Docker
```
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
```
2. Install Kubectl
```
sudo apt-get install -y apt-transport-https ca-certificates curl
```
```
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.29/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.29/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list
```
```
sudo apt-get update
sudo apt-get install -y kubectl
```
```
alias k=kubectl
```

# Install Kind

```
[ $(uname -m) = x86_64 ] && curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.20.0/kind-linux-amd64
chmod +x ./kind
sudo mv ./kind /usr/local/bin/kind
```

# Install Helm and Terraform 

1. Install Helm
```
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh
```
2. Install Terraform
```
sudo apt-get update && sudo apt-get install -y gnupg software-properties-common
```
```
wget -O- https://apt.releases.hashicorp.com/gpg | \
gpg --dearmor | \
sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg
```
```
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
sudo tee /etc/apt/sources.list.d/hashicorp.list
```
```
sudo apt update
sudo apt-get install terraform
```
```
touch ~/.zshrc
```
```
terraform -install-autocomplete
```