if [ -r /etc/profile ] ; then
. /etc/profile
fi

HISTSIZE=10000
SAVEHIST=0
bindkey -e

autoload -Uz compinit
compinit
autoload -Uz colors
colors

setopt notify
setopt AUTO_CONTINUE
setopt extendedglob
setopt hist_ignore_all_dups
setopt prompt_subst
setopt autopushd
setopt pushdsilent

export COLORTERM="yes"
alias -g '...'='../..'
alias -g '....'='../../..'
alias ssh='ssh -Y'
alias ll='ls -Al'
alias vg='valgrind --leak-check=full --track-origins=yes --dsymutil=yes'
alias enable-hooks='cp /home/satta/uni/gt/scripts/pre-commit /home/satta/uni/gt/.git/hooks'
alias disable-hooks='rm /home/satta/uni/gt/.git/hooks/pre-commit'
alias lintian='lintian --info --display-info --display-experimental --pedantic --show-overrides --color auto --profile debian'
alias a2man='a2x --doctype manpage --format manpage'
alias svn-b='svn-buildpackage -us -uc --svn-ignore'
alias svn-br='svn-b --svn-dont-purge --svn-reuse'
alias svn-bt='svn-buildpackage --svn-tag'
alias pbuilder-update='sudo DIST=sid pbuilder --update'
alias dockerkillall='docker kill $(docker ps -q)'
# Delete all stopped containers.
alias dockercleanc='printf "\n>>> Deleting stopped containers\n\n" && docker rm $(docker ps -a -q)'
# Delete all untagged images.
alias dockercleani='printf "\n>>> Deleting untagged images\n\n" && docker rmi $(docker images -q -f dangling=true)'
# Delete all stopped containers and untagged images.
alias dockerclean='dockercleanc || true && dockercleani'
alias brew-cask-upgrade='for c in `brew cask list`; do ! brew cask info $c | grep -qF "Not installed" || brew cask install $c; done'

export DOCKER_CERT_PATH=/Users/satta/.boot2docker/certs/boot2docker-vm
export DOCKER_TLS_VERIFY=1
export DOCKER_HOST=tcp://192.168.59.103:2376
export HOMEBREW_CASK_OPTS="--appdir=~/MyApplications"

if [ -x /usr/bin/dircolors ]; then
    eval "`dircolors -b`"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi
bindkey ";5C" forward-word
bindkey ";5D" backward-word

zstyle ':completion:*:descriptions' format '%U%B%d%b%u'

export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced
export GTDIR=$HOME/uni/gt
export PATH=/usr/local/sbin:$PATH:$HOME/bin:$GTDIR/bin:$HOME/uni/research/bin:$HOME/uni/lehre/repo/bin
export RUBYLIB=$HOME/uni/research/lib:$GTDIR/gtruby:$HOME/uni/lehre/repo/lib:$RUBYLIB
export GTRUBY=$GTDIR/gtruby
export PYTHONPATH=$GTDIR/gtpython:${HOME}/lib/python:$PYTHONPATH
export LD_LIBRARY_PATH=$GTDIR/lib:$LD_LIBRARY_PATH
export CC="ccache gcc"
export CPP="ccache cpp"
export CXX="ccache g++"
export PERL5LIB=$PERL5LIB:${HOME}/GAL_0.2.2/lib
export TEXINPUTS=.:${HOME}/uni/lehre/repo/etc/texinputs//:$TEXINPUTS:${HOME}/.texmf::
export BIBINPUTS=.:$HOME/uni/bibinputs/:$BIBINPUTS
export GTTESTDATA=${HOME}/uni/gttestdata
export VALGRIND_OPTS="--num-callers=30 --read-var-info=yes"
export DEBEMAIL="satta@tetrinetsucht.de"
export DEBFULLNAME="Sascha Steinbiss"
export DEBSIGN_KEYID=04A3610B
export DEBUILD_DPKG_BUILDPACKAGE_OPTS="-us -uc"
#export CGL_SO_SOURCE=${HOME}/uni/ontology/so.obo
export XML_CATALOG_FILES=/usr/local/etc/xml/catalog

# error when unset variables are used
set -u

# Set a nice git-prompt (calls git_status())
git_prompt_info() {
  local git_dir ref branch_prompt;
  git_dir=$(git rev-parse --git-dir 2> /dev/null) || return
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  branch_prompt=${ref#refs/heads/}
  if [ -n "$branch_prompt" ]; then
    status_icon=$(git_status)
    echo "$status_icon%{$fg[yellow]%} [$branch_prompt] %{$reset_color%}"
  fi
}
# Show character if index and/or work-tree are dirty
git_status() {
  output=""
  my_status=$(git status)
  if [[ "$my_status" == *"Changes to be committed"* ]]; then
    output="%{$fg[green]%}±"
  fi
  if [[ "$my_status" == *"Changes not staged"* ]]; then
    output="$output%{$fg[red]%}±"
  fi
  echo $output
}

export PS1='[%n@%m:%{$fg_bold[yellow]%}%0(4c,%2c,%~)%{$reset_color%}] $ '
export RPS1='$(git_prompt_info)[%?]'
export EDITOR=/usr/bin/vi

precmd () {print -Pn "\e]0;%n@%m\a"}

# turn off flow control
stty -ixon
# turn off beep
#setterm -bfreq 0

gt=/Users/satta/uni/gt
research=/Users/satta/uni/research
