ZSHA_BASE=$HOME/.zsh-antigen
source $ZSHA_BASE/antigen/antigen.zsh
source ~/.zprofile

antigen use oh-my-zsh

if [ "$OSTYPE"="darwin11.0" ]; then
	antigen bundle osx
fi

antigen bundle git
antigen bundle b4b4r07/emoji-cli
antigen bundle chrissicool/zsh-256color
antigen bundle zsh-users/zsh-history-substring-search
antigen bundle zsh-users/zsh-syntax-highlighting

antigen theme $ZSHA_BASE/themes nautilus

antigen apply

export PATH=$HOME/bin:/bin:/sbin:/usr/bin:/usr/local/sbin:/usr/local/bin:/opt/local/bin:/opt/local/sbin:$PATH
export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
export EDITOR=vim

if [ -d $HOME/.rbenv ]; then
	eval "$(rbenv init -)"
fi

alias pretty='pygmentize -g -O encoding=utf-8'
alias glp="git log --all --graph --pretty=format:'%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative"

if [ -f /opt/homebrew/bin/src-hilite-lesspipe.sh ]; then
export LESSOPEN="| /opt/homebrew/bin/src-hilite-lesspipe.sh %s"
export LESS=' -R '
fi
