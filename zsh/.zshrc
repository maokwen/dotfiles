# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=100000

# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/mao/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

export EDITOR='nvim'

source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line
bindkey "^[[3~" delete-char

# vi mode
bindkey -v
source /usr/share/zsh/plugins/zsh-vi-mode/zsh-vi-mode.plugin.zsh

# if uwsm check may-start; then
#     exec uwsm start niri-session
#     exec uwsm start start-cosmic
# fi

# if uwsm check may-start && uwsm select; then
#     exec systemd-cat -t uwsm start uwsm start default
# fi

