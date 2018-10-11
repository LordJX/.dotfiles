# set vim as default editor
export EDITOR="/usr/bin/vim"

# proxy function for terminal environment
function proxyon()  { 
    export http_proxy=127.0.0.1:1087
    export https_proxy=127.0.0.1:1087
}
function proxyoff() { 
    unset  http_proxy 
    unset  https_proxy 
}

# enable italic fonts in terminal
export TERM=xterm-256color-italic
alias ssh="TERM=xterm-256color ssh"

# enable GPG for command line
export GPG_TTY=/dev/ttys001

