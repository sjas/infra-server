#!/bin/sh
# kFreeBSD do not accept scripts as interpreters, using #!/bin/sh and sourcing.
if [ true != "$INIT_D_SCRIPT_SOURCED" ] ; then
    set "$0" "$@"; INIT_D_SCRIPT_SOURCED=true . /lib/init/init-d-script
fi
### BEGIN INIT INFO
# Provides:          prestashop
# Required-Start:    $remote_fs $syslog
# Required-Stop:     $remote_fs $syslog
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: spawn-fcgi wrapper for php-cgi running as prestashop
### END INIT INFO

# Author: whitequark <whitequark@whitequark.org>

DESC="prestashop"
PIDFILE=/var/run/prestashop.pid
DAEMON=/usr/bin/spawn-fcgi
DAEMON_ARGS="-s /run/prestashop.sock -u prestashop -U www-data -P ${PIDFILE}"
DAEMON_ARGS="${DAEMON_ARGS} -C 3 -- /usr/bin/php-cgi7.0"

do_stop_cmd() {
  start-stop-daemon --stop --quiet --retry=TERM/30/KILL/5 \
      --pidfile ${PIDFILE} --exec /usr/bin/php-cgi7.0
}