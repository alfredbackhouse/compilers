# keiko/config.mk

HOST := $(shell uname -s)-$(shell uname -m)
$(info Configured for $(HOST))

### Let's use the portable code for all platforms,
### so we hear of problems quickly.

#CC-Linux-x86_64 = gcc
#DEF-Linux-x86_64 = -DM64X32

#CC-Linux-i686 = gcc

#CC-Linux-armv6l = gcc
#CC-Linux-armv7l = gcc

HOST_CC := $(CC-$(HOST))
HOST_DEFINES = $(DEF-$(HOST))

ifndef HOST_CC
HOST_CC = gcc -std=gnu99
HOST_DEFINES = -DSEGMEM
endif

CC = $(HOST_CC) -std=gnu99
