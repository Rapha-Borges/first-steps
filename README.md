![Terminal ScreenShot](https://github.com/Rapha-Borges/Oh-My-Zsh/blob/main/img/ScreenShot%20.png)

# Install

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
