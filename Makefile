# Makefile for ttcomp
# Original by Tony Lewis <tlewis@exelana.com>
# Extended with debug and sanitizer targets

# Standard compilation flags
COMPILE = gcc -Isrc -O2 -Wall
LINK    = gcc -o $@

# Debug compilation flags (with backtrace support)
COMPILE_DEBUG = gcc -Isrc -O0 -g -Wall -rdynamic
LINK_DEBUG = gcc -o $@ -rdynamic

# AddressSanitizer flags
COMPILE_ASAN = gcc -Isrc -O1 -g -Wall -fsanitize=address -fno-omit-frame-pointer
LINK_ASAN = gcc -o $@ -fsanitize=address

# Undefined Behavior Sanitizer flags
COMPILE_UBSAN = gcc -Isrc -O1 -g -Wall -fsanitize=undefined -fno-omit-frame-pointer
LINK_UBSAN = gcc -o $@ -fsanitize=undefined

# Combined sanitizers (ASAN + UBSAN)
COMPILE_SANITIZE = gcc -Isrc -O1 -g -Wall -fsanitize=address,undefined -fno-omit-frame-pointer
LINK_SANITIZE = gcc -o $@ -fsanitize=address,undefined

# Object files
OBJ = implode.o ttdecomp.o
OBJ_DEBUG = implode_debug.o ttdecomp_debug.o
OBJ_ASAN = implode_asan.o ttdecomp_asan.o
OBJ_UBSAN = implode_ubsan.o ttdecomp_ubsan.o
OBJ_SANITIZE = implode_sanitize.o ttdecomp_sanitize.o

# Phony targets
.PHONY: all debug asan ubsan sanitize clean

all: ttdecomp

debug: ttdecomp.debug

asan: ttdecomp.asan

ubsan: ttdecomp.ubsan

sanitize: ttdecomp.sanitize

# Standard build
implode.o: src/implode.c
	$(COMPILE) -c $< -o $@

ttdecomp.o: src/ttdecomp.c
	$(COMPILE) -c $< -o $@

ttdecomp: $(OBJ)
	$(LINK) $(OBJ)

# Debug build with backtrace
implode_debug.o: src/implode.c
	$(COMPILE_DEBUG) -c $< -o $@

ttdecomp_debug.o: src/ttdecomp.c
	$(COMPILE_DEBUG) -c $< -o $@

ttdecomp.debug: $(OBJ_DEBUG)
	$(LINK_DEBUG) $(OBJ_DEBUG)

# ASAN build
implode_asan.o: src/implode.c
	$(COMPILE_ASAN) -c $< -o $@

ttdecomp_asan.o: src/ttdecomp.c
	$(COMPILE_ASAN) -c $< -o $@

ttdecomp.asan: $(OBJ_ASAN)
	$(LINK_ASAN) $(OBJ_ASAN)

# UBSAN build
implode_ubsan.o: src/implode.c
	$(COMPILE_UBSAN) -c $< -o $@

ttdecomp_ubsan.o: src/ttdecomp.c
	$(COMPILE_UBSAN) -c $< -o $@

ttdecomp.ubsan: $(OBJ_UBSAN)
	$(LINK_UBSAN) $(OBJ_UBSAN)

# Sanitize build (ASAN + UBSAN)
implode_sanitize.o: src/implode.c
	$(COMPILE_SANITIZE) -c $< -o $@

ttdecomp_sanitize.o: src/ttdecomp.c
	$(COMPILE_SANITIZE) -c $< -o $@

ttdecomp.sanitize: $(OBJ_SANITIZE)
	$(LINK_SANITIZE) $(OBJ_SANITIZE)

# Clean
clean:
	-$(RM) *.o ttdecomp ttdecomp.debug ttdecomp.asan ttdecomp.ubsan ttdecomp.sanitize *~ *.bak
