
# set vim as default editor
export EDITOR="/usr/bin/vim"

# docker X11 configuration initializing
xhost +local:docker > /dev/null
export XSOCK="/tmp/.X11-unix"
export XAUTH="/tmp/.docker.xauth"
touch $XAUTH
xauth nlist $DISPLAY | sed -e 's/^..../ffff/' | xauth -f $XAUTH nmerge -

