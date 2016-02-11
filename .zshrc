# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git brew)

source $ZSH/oh-my-zsh.sh

# User configuration

export PATH="/usr/local/sbin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

fpath=(/usr/local/share/zsh-completions $fpath)

export HOMEBREW_CASK_OPTS="--appdir=/Applications"

export LC_ALL=en_US.UTF-8  
export LANG=en_US.UTF-8

export PYTHONSTARTUP=~/.pythonrc

export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/Projects
source /usr/local/bin/virtualenvwrapper.sh

export PATH="$(brew --prefix homebrew/php/php56)/bin:$PATH"
export PHP_AUTOCONF="'$(which autoconf)'"

### SERVER SERVICES ALIAS
# Nginx
alias nginx.start='sudo launchctl load /Library/LaunchDaemons/homebrew.mxcl.nginx.plist'
alias nginx.stop='sudo launchctl unload /Library/LaunchDaemons/homebrew.mxcl.nginx.plist'
alias nginx.restart='nginx.stop && nginx.start'

# PHP-FPM
alias php-fpm.start="launchctl load -w ~/Library/LaunchAgents/homebrew.mxcl.php56.plist"
alias php-fpm.stop="launchctl unload -w ~/Library/LaunchAgents/homebrew.mxcl.php56.plist"
alias php-fpm.restart='php-fpm.stop && php-fpm.start'

# Nginx Logs
alias nginx.logs.error='tail -250f /usr/local/etc/nginx/logs/error.log'
alias nginx.logs.access='tail -250f /usr/local/etc/nginx/logs/access.log'
alias nginx.logs.default.access='tail -250f /usr/local/etc/nginx/logs/default.access.log'
alias nginx.logs.default-ssl.access='tail -250f /usr/local/etc/nginx/logs/default-ssl.access.log'
alias nginx.logs.phpmyadmin.access='tail -250f /usr/local/etc/nginx/logs/phpmyadmin.access.log'

#rbenv
export RBENV_ROOT=/usr/local/var/rbenv
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

#user scripts
export PATH="/Users/berto/.bin:$PATH"

#local npm modules
export PATH="$PATH:./node_modules/.bin"

#local composer modules
export PATH="$PATH:./vendor/bin"

#local web server
alias serve='python -m SimpleHTTPServer'

archey -c

source $HOME/.bin/z/z.sh
export PKG_CONFIG_PATH=/opt/X11/lib/pkgconfig

#mongo
alias mon='echo "Starting MongoDB" && mongod --config /usr/local/etc/mongod.conf'

#midori
alias midori='mosh berto@midori.ber.to'

#redis
alias redis='redis-server /usr/local/etc/redis.conf'

source ~/.iterm2_shell_integration.`basename $SHELL`

brew-cask-upgrade() { 
  if [ "$1" != '--continue' ]; then 
    echo "Removing brew cache" 
    rm -rf "$(brew --cache)" 
    echo "Running brew update" 
    brew update 
  fi 
  for c in $(brew cask list); do 
    echo -e "\n\nInstalled versions of $c: " 
    ls /opt/homebrew-cask/Caskroom/$c 
    echo "Cask info for $c" 
    brew cask info $c 
    select ynx in "Yes" "No" "Exit"; do  
      case $ynx in 
        "Yes") echo "Uninstalling $c"; brew cask uninstall --force "$c"; echo "Re-installing $c"; brew cask install "$c"; break;; 
        "No") echo "Skipping $c"; break;; 
        "Exit") echo "Exiting brew-cask-upgrade"; return;; 
      esac 
    done 
  done 
} 

export HISTSIZE=20000

alias dot='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
