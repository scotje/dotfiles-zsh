# Environment
export EDITOR=vim
export RACK_ENV=development

# Aliases
alias bx="bundle exec"
alias tmux="tmux -2"

# Restore emacs style keybinds in zsh (ctrl-a/e, etc.)
bindkey -e

# Reset PATH on macOS so we can rebuild it
if [ -x /usr/libexec/path_helper ]; then
  export PATH=""
  eval `/usr/libexec/path_helper -s`
fi

# homebrew
[ -x /usr/local/bin/brew ] && eval "$(/usr/local/bin/brew shellenv)"

# Better SSH/Rsync/SCP Autocomplete
zstyle ':completion:*:(scp|rsync):*' tag-order ' hosts:-ipaddr:ip\ address hosts:-host:host files'
zstyle ':completion:*:(ssh|scp|rsync):*:hosts-host' ignored-patterns '*(.|:)*' loopback ip6-loopback localhost ip6-localhost broadcasthost
zstyle ':completion:*:(ssh|scp|rsync):*:hosts-ipaddr' ignored-patterns '^(<->.<->.<->.<->|(|::)([[:xdigit:].]##:(#c,2))##(|%*))' '127.0.0.<->' '255.255.255.255' '::1' 'fe80::*'

# add homebrew provided tab completions
if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH
fi

# TODO: Add floaty tab completions

# activate autocomplete
autoload -Uz compinit
compinit

# antibody (zsh plugin manager)
if (( $+commands[antibody] )); then
  source <(antibody init)
  [[ -f ~/.zsh_plugins ]] && antibody bundle < ~/.zsh_plugins
fi

# rbenv
if (( $+commands[rbenv] )); then
  eval "$(rbenv init -)"
fi

# nodenv
if (( $+commands[nodenv] )); then
  eval "$(nodenv init -)"
fi

# configure spaceship prompt
SPACESHIP_PROMPT_ORDER=(
  host          # Hostname section
  time          # Time stamps section
  user          # Username section
  dir           # Current directory section
  git_branch    # Current git branch
  node          # Node.js section
  ruby          # Ruby section
  #docker        # Docker section
  #aws           # Amazon Web Services section
  #gcloud        # Google Cloud Platform section
  #kubectl       # Kubectl context section
  #terraform     # Terraform workspace section
  #exec_time     # Execution time
  #exit_code     # Exit code section
  char          # Prompt character
)

SPACESHIP_PROMPT_ADD_NEWLINE=false
SPACESHIP_PROMPT_DEFAULT_PREFIX=""
SPACESHIP_HOST_SHOW=always
SPACESHIP_TIME_SHOW=true
SPACESHIP_TIME_PREFIX=""
SPACESHIP_DIR_PREFIX=""
SPACESHIP_DIR_TRUNC=0
SPACESHIP_GIT_BRANCH_SUFFIX=" "
SPACESHIP_RUBY_PREFIX=""
SPACESHIP_NODE_PREFIX=""
SPACESHIP_CHAR_SYMBOL="$"
SPACESHIP_CHAR_SUFFIX=" "

# homedir bin at end of PATH
export PATH="${PATH}:${HOME}/bin"

# local customizations
[[ -f ~/.zshrc_local ]] && source ~/.zshrc_local
