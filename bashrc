export PATH="$PATH:$HOME/.cargo/bin:$HOME/.local/bin:$HOME/go/bin"

[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias ll='ls -lh'
alias l='ll -a'

echo "Get the job done."

PS1='\w  '

