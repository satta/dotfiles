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
alias cdg='cd ~gt'
alias vg='valgrind --leak-check=full'
alias less='/usr/share/vim/vim74/macros/less.sh'
alias sau='sudo aptitude update; sudo aptitude safe-upgrade;'
alias sasu='sudo aptitude safe-upgrade'
alias safu='sudo aptitude full-upgrade'
alias kf='killall -q firefox ; killall -q firefox-bin'
alias wea='weather -v EDDH'
alias enable-hooks='cp /home/satta/uni/gt/scripts/pre-commit /home/satta/uni/gt/.git/hooks'
alias disable-hooks='rm /home/satta/uni/gt/.git/hooks/pre-commit'
alias cchr='rm -rf .config/google-chrome; rm -rf .cache/google-chrome; rm -rf .config/chromium; rm -rf .cache/chromium'
alias lintian='lintian --info --display-info --display-experimental --pedantic --show-overrides --color auto --profile debian'
alias a2man='a2x --doctype manpage --format manpage'
#alias git=hub

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

export PATH=$PATH:$HOME/uni/vstree/bin/i686-pc-linux-gnu:$HOME/bin:$HOME/uni/research/bin:$HOME/code/android-sdk/tools:$HOME/uni/lehre/repo/bin
export GTDIR=$HOME/uni/gt
export RUBYLIB=$HOME/uni/research/lib:$GTDIR/gtruby:$HOME/uni/rubylib:$HOME/uni/lehre/repo/lib:$RUBYLIB
export GTRUBY=$GTDIR/gtruby
export PYTHONPATH=$GTDIR/gtpython:${HOME}/lib/python:$PYTHONPATH
export LD_LIBRARY_PATH=$GTDIR/lib:$LD_LIBRARY_PATH
export PROJECT=/home/satta/uni/projects
export CC="ccache gcc"
export CPP="ccache cpp"
export CXX="ccache g++"
PERL5LIB=$PERL5LIB:${HOME}/uni/lehre/repo/etc/lehre/Admin/Perldir
PERL5LIB=${PERL5LIB}:${HOME}/uni/gtperl
export PERL5LIB
export TEXINPUTS=.:${HOME}/uni/zeugs/Briefvorlage:${HOME}/uni/lehre/repo/etc/texinputs//:$TEXINPUTS:${HOME}/.texmf::
export BIBINPUTS=.:$HOME/uni/bibinputs/:$BIBINPUTS
export GTTESTDATA=${HOME}/uni/gttestdata
export gt_prefix=/${HOME}/uni/installed
#export JAVA_HOME=/usr/lib/jvm/java-6-openjdk
export VALGRIND_OPTS="--num-callers=30 --read-var-info=yes"
DEBEMAIL="satta@tetrinetsucht.de"
DEBFULLNAME="Sascha Steinbiss"
export DEBEMAIL DEBFULLNAME
export DEBSIGN_KEYID=0x04A3610B
export CGL_SO_SOURCE=${HOME}/uni/ontology/so.obo

# error error when unset variables are used
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

export PS1='[%n@%m:%{$fg_bold[yellow]%}%0(4c,%2c,%~)%{$reset_color%}] ◇ '
export RPS1='$(git_prompt_info)[%?]'
export EDITOR=/usr/bin/vi

precmd () {print -Pn "\e]0;%n@%m\a"}

#trap 'echo -ne "\033[1;31m"✕\\n' INT

# turn off flow control
stty -ixon
# turn off beep
setterm -bfreq 0


gt=/home/satta/uni/gt
research=/home/satta/uni/research
teaching=/home/satta/lehre/repo
diss=/home/satta/uni/promotion/diss
debmed=/home/satta/uni/debian-work


[[ -s "$HOME/.pythonbrew/etc/bashrc" ]] && source "$HOME/.pythonbrew/etc/bashrc"

{
[ "_$TERM" = "_xterm" ] && type ldd && type grep && type tput && [ -L "/proc/$PPID/exe" ] && {
  if ldd /proc/$PPID/exe | grep libvte; then
    if [ "`tput -Tgnome-256color colors`" = "256" ]; then
      TERM=gnome-256color
    elif [ "`tput -Txterm-256color colors`" = "256" ]; then
      TERM=xterm-256color
    elif tput -T gnome; then
      TERM=gnome
    fi
  fi
}
} >/dev/null 2>/dev/null 

#function _update_ps1()
#{
#  export PROMPT="$(~/bin/powerline-zsh.py $?)"
#}
#precmd()
#{
#  _update_ps1
#}
