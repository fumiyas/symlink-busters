#!/bin/sh

if [ $# -lt 1 ]; then
  echo "Usage: $0 COMMAND [ARGUEMNT ...]" 1>&2
  exit 1
fi

symlink_filter_so="@libdir@/symlink-filter.so"

case ":$LD_PRELOAD:" in
*":$symlink_filter_so:"*)
  ;;
*)
  LD_PRELOAD="${LD_PRELOAD:+$LD_PRELOAD:}$symlink_filter_so"
  ;;
esac

if [ x"$1" = x"--sh-init" ]; then
  echo "LD_PRELOAD='$LD_PRELOAD'"
  echo "export LD_PRELOAD"
  exit 0
fi

export LD_PRELOAD

exec "$@"
exit 1

