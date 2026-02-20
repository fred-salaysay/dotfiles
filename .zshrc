export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:/home/fred/.opencode/bin:$PATH
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

zstyle ":omz:update" mode auto      # update automatically without asking

DISABLE_UNTRACKED_FILES_DIRTY="true"
COMPLETION_WAITING_DOTS="true"

HIST_STAMPS="mm/dd/yyyy"
HISTSIZE=5000
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

plugins=(
  git
  tmux
  dirhistory
)

source $ZSH/oh-my-zsh.sh

# User configuration
export EDITOR="zed"

alias zshconfig="mate ~/.zshrc"
alias ohmyzsh="mate ~/.oh-my-zsh"

# =============================================== #
# end of default oh-my-zsh
# =============================================== #

# =============================================== #
# nvm post-install
# requirements: nvm
# =============================================== #

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# =============================================== #
# 1password cli post-install
# requirements: 1password
# =============================================== #

export SSH_AUTH_SOCK="$HOME/.1password/agent.sock"

if [ ! -S "$SSH_AUTH_SOCK" ] || ! ssh-add -l &>/dev/null; then
    rm -f "$SSH_AUTH_SOCK"
    mkdir -p "$HOME/.1password"
    (setsid socat UNIX-LISTEN:"$SSH_AUTH_SOCK",fork EXEC:"$HOME/.local/bin/npiperelay.exe -ei -s //./pipe/openssh-ssh-agent",nofork &) >/dev/null 2>&1
fi

# =============================================== #
# requirements: fzf, fdfind, bat
# =============================================== #
# -- Use fdfind instead of fzf --

alias bat="batcat"
eval "$(fzf --zsh)"

# 1. Default Command (for general fzf)
# We remove --strip-cwd-prefix to make it "universal"
export FZF_DEFAULT_COMMAND="fdfind --hidden --exclude .git"

# 2. CTRL-T (Files & Folders)
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# 3. ALT-C (Targeted to your ~/dev folder)
# REMOVED: "| fzf" from the end
export FZF_ALT_C_COMMAND="fdfind --type d --hidden --exclude .git --exclude node_modules . ~/dev | xargs -d'\n' stat --printf='%Y\t%n\n' 2>/dev/null | sort -rn | cut -f2-"

# 4. Global Options (UI & Preview)
export FZF_DEFAULT_OPTS="--height=40% --layout=reverse --info=inline --border \
--preview '[ -d {} ] && tree -L 2 -C {} | head -200 || batcat --style=numbers --color=always {}'"

# Use fdfind (https://github.com/sharkdp/fd) for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fdfind --hidden --exclude .git . "$1"
}

# Use fdfind to generate the list for directory completion
_fzf_compgen_dir() {
  fdfind --type=d --hidden --exclude .git . "$1"
}

# =============================================== #
# oh-my-posh
# requirements: oh-my-posh
# =============================================== #
eval "$(oh-my-posh init zsh --config atomic)"