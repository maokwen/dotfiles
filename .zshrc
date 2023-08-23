# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e
# End of lines configured by zsh-newuser-install

# compinit
zstyle :compinstall filename '/home/mao/.zshrc'
autoload -Uz compinit
compinit

# Environments
EDITOR=nvim
# PAGER=nvimpager

# Zsh extend
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# Starship
eval "$(starship init zsh)"

# Zoxide
eval "$(zoxide init zsh)"

# Alias
alias ls=exa
alias vi=nvim
alias vim=vim

