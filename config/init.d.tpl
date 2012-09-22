#!/bin/bash
#
#    /etc/init.d/<%= project %>
#
#    Controls the <%= project %> service.
#
# chkconfig: 345 90 10
# description: <%= project %> service
# processname: <%= project %>-daemon
# pidfile: <%= pid %>

### BEGIN INIT INFO
# Provides: <%= project %>
# Required-Start: $network $local_fs $remote_fs
# Required-Stop: $network $local_fs $remote_fs
# Should-Start: $syslog
# Short-Description: control <%= project %>
# Description: control <%= project %>
### END INIT INFO

# source libaries

. /etc/init.d/functions

# environment

export PATH=/opt/bin:/usr/local/sbin:/usr/local/bin:$PATH

# variables

servicename=<%= project %>
pidfile=<%= pid %>
lockfile=<%= lockfile %>
prog=<%= project %>

# functions

start() {
    if [ ! -x $exec ]; then
        echo $exec not found
        exit 5
    fi
    echo -n "Starting $servicename: "
    if [[ $EUID -ne 0 ]]; then
        daemon --pidfile $pidfile "<%= start_cmd %>" > /dev/null 2>&1
    else
        daemon --user <%= user %> --pidfile $pidfile "<%= start_cmd %>" > /dev/null 2>&1
    fi
    retval=$?
    if [ $retval -eq 0 ]; then
        touch $lockfile
        echo_success
    else
        echo_failure
    fi
    echo
    return $retval
}

stop() {
    echo -n "Shutting down $servicename: "
    killproc -p $pidfile -d 5 $prog
    retval=$?
    [ $retval -eq 0 ] && rm -f $lockfile
    echo
    return $retval
}

restart() {
    stop
    start
}

reload() {
    echo -n "Reloading $servicename: "
    <%= reload_cmd %>
    retval=$?
    if [ $retval -eq 0 ]; then
        echo_success
    else
        echo_failure
    fi
    echo
    return $retval
}

# command

case "$1" in
    start)
        status -p $pidfile $prog >/dev/null 2>&1 && exit 0
        $1
        ;;
    stop)
        status -p $pidfile $prog >/dev/null 2>&1 || exit 0
        $1
        ;;
    status)
        status -p $pidfile $prog
        ;;
    restart)
        $1
        ;;
    reload)
        status -p $pidfile $prog >/dev/null 2>&1 || exit 7
        $1
        ;;
    forcereload)
        restart
        ;;
    condrestart)
        status -p $pidfile $prog >/dev/null 2>&1 || exit 0
        restart
        ;;
    *)
        echo "Usage: $SERVICE_NAME {start|stop|status|reload|forcereload|condrestart|restart}"
        exit 1
        ;;
esac
exit $?
