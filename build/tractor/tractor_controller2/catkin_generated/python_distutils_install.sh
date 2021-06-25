#!/bin/sh

if [ -n "$DESTDIR" ] ; then
    case $DESTDIR in
        /*) # ok
            ;;
        *)
            /bin/echo "DESTDIR argument must be absolute... "
            /bin/echo "otherwise python's distutils will bork things."
            exit 1
    esac
fi

echo_and_run() { echo "+ $@" ; "$@" ; }

echo_and_run cd "/home/ducthang/agribot2/src/tractor/tractor_controller2"

# ensure that Python install destination exists
echo_and_run mkdir -p "$DESTDIR/home/ducthang/agribot2/install/lib/python3/dist-packages"

# Note that PYTHONPATH is pulled from the environment to support installing
# into one location when some dependencies were installed in another
# location, #123.
echo_and_run /usr/bin/env \
    PYTHONPATH="/home/ducthang/agribot2/install/lib/python3/dist-packages:/home/ducthang/agribot2/build/lib/python3/dist-packages:$PYTHONPATH" \
    CATKIN_BINARY_DIR="/home/ducthang/agribot2/build" \
    "/usr/bin/python3" \
    "/home/ducthang/agribot2/src/tractor/tractor_controller2/setup.py" \
     \
    build --build-base "/home/ducthang/agribot2/build/tractor/tractor_controller2" \
    install \
    --root="${DESTDIR-/}" \
    --install-layout=deb --prefix="/home/ducthang/agribot2/install" --install-scripts="/home/ducthang/agribot2/install/bin"
