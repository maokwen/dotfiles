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

export PATH=$PATH:/opt/android-sdk/platform-tools

# vi mode
bindkey -v
source /usr/share/zsh/plugins/zsh-vi-mode/zsh-vi-mode.plugin.zsh

function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

alias ls='eza'
alias ll='eza -l --icons --group-directories-first'
alias la='eza -la --icons'
alias lt='eza -lT --icons --level=2'

alias tunon='sudo systemctl restart sing-box.service'
alias tunoff='sudo systemctl stop sing-box.service'

alias hx='helix'

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - zsh)"

# if uwsm check may-start; then
#     exec uwsm start niri-session
#     exec uwsm start start-cosmic
# fi

# if uwsm check may-start && uwsm select; then
#     exec systemd-cat -t uwsm start uwsm start default
# fi

