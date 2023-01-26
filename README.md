# Install

1. Install Oh My Zsh
```
sh -c "$(curl -fsSL https://raw.githubusercontent.com/Rapha-Borges/ohmyzsh/master/tools/install.sh)"
```
2. Install powerlevel10k theme:
```
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
```
3. Replace .pk10k.zsh and .zshrc files
```
curl https://raw.githubusercontent.com/Rapha-Borges/ohmyzsh/master/files/.p10k.zsh > $HOME/.p10k.zsh && curl https://raw.githubusercontent.com/Rapha-Borges/ohmyzsh/master/files/.zshrc > $HOME/.zshrc
