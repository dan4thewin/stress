# mkfile — cross-compile stress for aarch64
#
# Usage:  mk  |  mk clean  |  mk info
#
# Requires CROSSCC, CROSSSYSROOT, and optionally CROSSCFLAGS
# in the environment.  Example (in ~/.bash_local or shell profile):
#   export CROSSCC=/path/to/aarch64-...-gcc
#   export CROSSSYSROOT=/path/to/sysroot
#   export CROSSCFLAGS="-mcpu=cortex-a57+crc"

CFLAGS=$CROSSCFLAGS --sysroot=$CROSSSYSROOT -I. -O2 -DHAVE_SYS_PRCTL_H
LDFLAGS=-static
LIBS=-lm

BIN=stress
SRC=src/stress.c

$BIN: $SRC config.h
    $CROSSCC $CFLAGS $LDFLAGS -o $target $SRC $LIBS

config.h:
    echo '#define PACKAGE "stress"' > $target
    echo '#define VERSION "1.0.7"' >> $target

clean:V:
    rm -f $BIN config.h

info:V:
    echo "CROSSCC = $CROSSCC"
    echo "SYSROOT = $CROSSSYSROOT"
    file $BIN || echo '(not yet built)'
