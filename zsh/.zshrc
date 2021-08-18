##### XDG Support #####

export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share
export XDG_STATE_HOME=$HOME/.local/state

# I think these dont work
#ZSH_CACHE_DIR=$XDG_CACHE_HOME/zsh
#ZSH_COMPDUMP="${ZSH_CACHE_DIR}/.zcompdump-${(%):-%m}-${ZSH_VERSION}"

export GNUPGHOME=${XDG_CONFIG_HOME}/gnupg
export LESSHISTFILE="${XDG_STATE_HOME}/less/history"
export LESSKEY="${XDG_CONFIG_HOME}/less/keys"
export LPASS_HOME=$XDG_CONFIG_HOME/lpass

export HISTFILE=$XDG_CACHE_HOME/.zsh_history

export ASDF_DATA_DIR="${XDG_DATA_HOME:-~/.local/share}/asdf"
export ASDF_CONFIG_FILE="${XDG_CONFIG_HOME:-~./config}/asdf/asdfrc"

export npm_config_userconfig=$XDG_CONFIG_HOME/npm/config
export npm_config_cache=$XDG_CACHE_HOME/npm
# if you do this one, make sure to add $XDG_DATA_HOME/npm/bin to the $PATH,
# otherwise global installed executables won't be accessible on the cli.
#export npm_config_prefix=$XDG_DATA_HOME/npm
#export PATH=$PATH:$XDG_DATA_HOME/npm/bin
#
# Ensures python puts its history in the right place
export PYTHONSTARTUP="${XDG_CONFIG_HOME:-$HOME/.config}/python/startup.py"
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block, everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh

source "$(brew --prefix antigen)/share/antigen/antigen.zsh"

antigen use oh-my-zsh

antigen bundle git
antigen bundle zsh-users/zsh-syntax-highlighting

antigen bundle Tarrasch/zsh-autoenv
	export AUTOENV_FILE_ENTER=.env
	export AUTOENV_FILE_LEAVE=.env_leave

antigen theme romkatv/powerlevel10k

antigen apply

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

eval "$(asdf exec direnv hook zsh)"

PATH=$HOME/.config/bin:/usr/local/sbin:$PATH:./bin

export LS_COLORS="$(vivid generate molokai)"
export CLICOLOR=1
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}


alias g='git'

alias glf='git log'
alias gl1='git log --oneline'
alias gl='git log --oneline --decorate'
alias glog="git log --graph --pretty=format:'%Cred%h%Creset %an: %s - %Creset %C(yellow)%d%Creset %Cgreen(%cr)%Creset' --abbrev-commit --date=relative"

alias gp='git push'
alias gpu='git pull'
alias gpur='git pull --rebase'

alias gd='git diff'

alias ga='git add'
alias gap='git add -p'

alias gc='git commit'
alias gca='git commit -a'
alias gcam='git commit -am'
alias gcm='git commit -m'

alias gco='git checkout'

alias gb='git branch'
alias gbc='git checkout -b'
alias gba='git branch -a'
alias gbr='git branch -r'

alias gra='git remote add'
alias grr='git remote rm'
alias grl='git remote -v'

alias gs='git status -sb'
alias gss='git status'
alias grm="git status | grep deleted | awk '{\$1=\$2=\"\"; print \$0}' | \
           perl -pe 's/^[ \t]*//' | sed 's/ /\\\\ /g' | xargs git rm"

alias gcl='git clone'

alias gr='git rebase'
alias grp='git checkout -p'

alias gcdr='cd ./$(git rev-parse --show-cdup)'

alias ibrew='arch -x86_64 /usr/local/bin/brew'
alias mbrew='arch -arm64 /opt/homebrew/bin/brew'

alias activate='. ./.venv/bin/activate'

source "$(brew --prefix asdf)/asdf.sh"

