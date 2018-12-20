# -------------------------------------------------------
# ----- profile setting -----
# -------------------------------------------------------

# set vim as default editor
export EDITOR="/usr/bin/vim"

# enable italic fonts in terminal
export TERM=xterm-256color-italic
alias ssh="TERM=xterm-256color ssh"

# enable GPG for command line
#export GPG_TTY=/dev/ttys001


# -------------------------------------------------------
# ----- functions -----
# -------------------------------------------------------

# ----- shadowsocks proxy functions in terminal environment

# enable shadowsocks proxy
function ssproxyon()  {
    export http_proxy=127.0.0.1:1087
    export https_proxy=127.0.0.1:1087
}
# disable shadowsocks proxy
function ssproxyoff() {
    unset  http_proxy
    unset  https_proxy
}


# ----- python virtual environment functions
# workon a virtual environment
function wkpyvenv {
    if [ ${#@} = 0 ] ; then
        echo -e "Please specify a virtual environment.\n" >&2
        return 1
    fi
    if [ ! -d $PYVENV_HOME/$1 ] ; then
        echo -e "The virtual environment does not exist.\n" >&2
        return 1
    fi
    source "$PYVENV_HOME/$1/bin/activate"
}

# make a virtual environment
function mkpyvenv {
    if [ ${#@} = 0 ] ; then
        echo -e "Please specify a virtual environment.\n" >&2
        return 1
    fi
    if [ -d $PYVENV_HOME/$1 ] ; then
        echo -e "The virtual environment is already there.\n" >&2
        return 1
    fi
    python3 -m venv $PYVENV_HOME/$1
}

# remove a virtual environment
function rmpyvenv {
    if [ ${#@} = 0 ] ; then
        echo -e "Please specify a virtual environment.\n" >&2
        return 1
    fi
    if [ ! -d $PYVENV_HOME/$1 ] ; then
        echo -e "The virtual environment does not exist.\n" >&2
        return 1
    fi
    rm -r $PYVENV_HOME/$1
}

# list all virtual environments
function lspyvenv {
    (echo $PYVENV_HOME/*/bin/activate) 2>/dev/null \
        | command \sed "s|$PYVENV_HOME/||g" \
        | command \sed "s|/bin/activate||g" \
        | command \fmt -w 1 \
        | (unset GREP_OPTIONS; command \egrep -v '^\*$') 2>/dev/null
}

# set auto tab completion
function pyvenv_tab_completion {
    if [ -n "$ZSH_VERSION" ] ; then
        _venvs () {
            reply=( $(lspyvenv) )
        }
        compctl -K _venvs wkpyvenv rmpyvenv
    fi
}

# set up pyvenvwrapper properly
function pyvenvwrapper_initialize {
    if command -v python3 &>/dev/null; then
        export PYVENV_HOME="$HOME/.pyvenvs"
        [[ -d $PYVENV_HOME ]] || mkdir $PYVENV_HOME

        pyvenv_tab_completion
    else
        unset -f wkpyvenv mkpyvenv rmpyvenv lspyvenv
    fi
}
# Invoke the initialization functions
pyvenvwrapper_initialize

