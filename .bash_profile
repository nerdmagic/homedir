[[ $(uname) == "SunOS" ]] && alias egrep="/usr/gnu/bin/egrep"

PathExec() {
  which "$1" > /dev/null 2>&1
  return $?
}

PathSearch() {
  echo "$PATH" | egrep -q "(^|:)${1}(:.+|$)"
  return $?
}

PathPrepend() {
  for item in $* ; do
    PathSearch "$item" || {
      [[ -d "$item" ]] && export PATH="${item}:${PATH}"
    }
  done
}

PathAppend() {
  for item in $* ; do
    PathSearch "$item" || {
      [[ -d "$item" ]] && export PATH="${PATH}:${item}"
    }
  done
}

export SHORTNAME=$(hostname | cut -d. -f1)
export PS1='${SHORTNAME}:$(echo $PWD | sed -es%${HOME}%~%) \$ '

case $(uname) in
  "Linux")
      PathPrepend /usr/local/bin /usr/local/sbin
      alias ls="ls --color=always"
    ;;
  "Darwin")
      export PS1='$(echo $PWD | sed -es%${HOME}%~%) \$ '
      [[ -d "${HOME}/.homebrew" ]] && {
        export LIBRARY_PATH="~/.homebrew/lib:${LIBRARY_PATH}"
        PathAppend "${HOME}/.homebrew/bin"
      }
    ;;
  "SunOS")
      PathAppend /opt/csw/bin /opt/omni/bin /usr/local/bin
      PathAppend /sbin /usr/sbin /opt/csw/sbin /opt/omni/sbin
    ;;
  "FreeBSD")
      PathPrepend /usr/local/bin /usr/local/sbin
    ;;
esac

PathAppend "${HOME}/bin" "${HOME}/scripts"

[[ -d "${HOME}/go" ]] && {
  export GOPATH="${HOME}/go"
  PathPrepend "$GOPATH"
}

[[ -f "${HOME}/.env.vagrant" ]] && source "${HOME}/.env.vagrant"
[[ -f "${HOME}/.env.artifactory" ]] && source "${HOME}/.env.artifactory"
PathExec direnv && eval "$(direnv hook bash)"
PathExec pyenv && eval "$(pyenv init -)"

[[ -d "${HOME}/.rvm" ]] && {
  PathAppend "${HOME}/.rvm/bin"
  [[ -s "${HOME}/.rvm/scripts/rvm" ]] && source "${HOME}/.rvm/scripts/rvm"
}

PathExec vim && alias vi=vim

shopt -s histappend cdspell autocd checkjobs cmdhist
set -o vi

export EDITOR=vi
export PAGER=/usr/bin/less
export HISTSIZE=5000
export HISTFILESIZE=10000
export PROMPT_COMMAND="history -a; history -c ; history -r"

umask 077
