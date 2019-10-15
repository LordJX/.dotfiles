
# set vim as default editor
export EDITOR="/usr/bin/vim"

# enable shadowsocks proxy
function ssproxyon()  { export ALL_PROXY=socks5://127.0.0.1:1080 }
# disable shadowsocks proxy
function ssproxyoff() { unset ALL_PROXY }

# X11 configuration initializing
xhost +local:docker > /dev/null
export XSOCK="/tmp/.X11-unix"
export XAUTH="/tmp/.docker.xauth"
touch $XAUTH
xauth nlist $DISPLAY | sed -e 's/^..../ffff/' | xauth -f $XAUTH nmerge -

