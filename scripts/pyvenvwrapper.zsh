# -------------------------------------------------------
# python virtual environment commands
# -------------------------------------------------------

# workon a virtual environment
function pyvenv {
    if [ ${#@} = 0 ] ; then
        echo "Please specify an environment." >&2
        return 1
    fi
    if [ ! -d $PYVENV_HOME/$1 ] ; then
        echo "The environment does not exist." >&2
        return 1
    fi
    source "$PYVENV_HOME/$1/bin/activate"
}

# create a virtual environment
function mkvenv {
    if [ ${#@} = 0 ] ; then
        echo "Please specify an environment." >&2
        return 1
    fi
    if [ -d $PYVENV_HOME/$1 ] ; then
        echo "The environment already exist." >&2
        return 1
    fi
    python3 -m venv $PYVENV_HOME/$1
}

# remove a virtual environment
function rmvenv {
    if [ ${#@} = 0 ] ; then
        echo "Please specify an environment." >&2
        return 1
    fi
    if [ ! -d $PYVENV_HOME/$1 ] ; then
        echo "The environment does not exist." >&2
        return 1
    fi
    rm -r $PYVENV_HOME/$1
}

# list all virtual environments
function lsvenv {
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
            reply=( $(lsvenv) )
        }
        compctl -K _venvs pyvenv rmvenv
    fi
}

# set up pyvenvwrapper properly
function pyvenvwrapper_initialize {
    export PYVENV_HOME="$HOME/.pyvenv"
    [[ -d $PYVENV_HOME ]] || mkdir $PYVENV_HOME

    pyvenv_tab_completion
}

# Invoke the initialization functions
pyvenvwrapper_initialize
