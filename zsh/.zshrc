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

##### POWERLEVEL 10K #####

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block, everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
[[ -f $XDG_CONFIG_HOME/zsh/.p10k.zsh ]] && source $XDG_CONFIG_HOME/zsh/.p10k.zsh

##### ZNAP ######

zstyle ':znap:*' repos-dir ~/.cache/znap
source ~/.config/znap/znap.zsh

znap prompt romkatv/powerlevel10k

# Completion
znap source zsh-users/zsh-completions
znap source zsh-users/zsh-autosuggestions # wont work with syntax-highlighting until zsh 5.9
#znap source marlonrichert/zsh-autocomplete
znap source Aloxaf/fzf-tab
  # show fzf in a tmux popup
  zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup
  # disable sort when completing `git checkout`
  zstyle ':completion:*:git-checkout:*' sort false
  # set descriptions format to enable group support
  zstyle ':completion:*:descriptions' format '[%d]'
  # preview directory's content with exa when completing cd
  zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -1 --color=always $realpath'
  # switch group using `,` and `.`
  zstyle ':fzf-tab:*' switch-group ',' '.'
znap source MichaelAquilina/zsh-you-should-use
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
setopt globdots


# History
znap source zsh-users/zsh-history-substring-search
  bindkey -M viins '^[[A' history-substring-search-up
  bindkey -M viins '^[[B' history-substring-search-down
  bindkey -M vicmd 'k' history-substring-search-up
  bindkey -M vicmd 'j' history-substring-search-down

# Behaviour
## VIM MODE
function zvm_config() {
  ZVM_LINE_INIT_MODE=$ZVM_MODE_INSERT
  ZVM_VI_SURROUND_BINDKEY="s-prefix"
}
function zvm_after_init() {
  [ -f "${XDG_CONFIG_HOME:-$HOME/.config}/fzf/fzf.zsh" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/fzf/fzf.zsh"
  enable-fzf-tab
}
znap source jeffreytse/zsh-vi-mode
bindkey -v
export KEYTIMEOUT=1
znap source Tarrasch/zsh-autoenv
  export AUTOENV_FILE_ENTER=.in
  export AUTOENV_FILE_LEAVE=.out

# AppSupport
#znap source alexdesousa/oauth
#znap source Sordie/AWSume

# Colors
znap source zpm-zsh/colorize # auto colorize a bunch of commands
[[ ! -f $XDG_CACHE_HOME/lscolor ]] && vivid generate molokai > $XDG_CACHE_HOME/lscolor # because vivid output is non deterministic
export LS_COLORS="$(cat ${XDG_CACHE_HOME}/lscolor)"
export LSCOLORS="gxbxabagFxghbhfhfhxxxx" # Approximation of molokai
export CLICOLOR=1
#znap source marlonrichert/zcolors
#znap eval zcolors "zcolors ${(q)LS_COLORS}"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

znap source zsh-users/zsh-syntax-highlighting

#znap does this automatically?
#autoload -Uz compinit zrecompile
#compinit -d $XDG_CACHE_HOME/zsh/zcompdump


PATH=$HOME/.config/bin:/usr/local/sbin:$PATH:./bin

alias ls="gls --color -F"
alias ll="exa -lg -a --git --octal-permissions --no-permissions --color=always"

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
