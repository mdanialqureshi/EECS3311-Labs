INCLUDE_PATH =  -I"$(ISE_LIBRARY)/library/time/spec/include"
SHELL = /bin/sh
CC = cc
CPP = c++
CFLAGS = -O0 -pipe -fno-common -fPIC -DEIF_THREADS -DEIF_POSIX_THREADS  -DWORKBENCH -I"/Applications/MacPorts/Eiffel_19.05/studio/spec/macosx-x86-64/include" -I. $(INCLUDE_PATH)
CPPFLAGS = -O0 -pipe -fno-common -fPIC -DEIF_THREADS -DEIF_POSIX_THREADS  -DWORKBENCH -I"/Applications/MacPorts/Eiffel_19.05/studio/spec/macosx-x86-64/include" -I. $(INCLUDE_PATH)
LDFLAGS = 
CCLDFLAGS =   
LDSHAREDFLAGS =   -dynamiclib -flat_namespace -undefined suppress -o
EIFLIB = "/Applications/MacPorts/Eiffel_19.05/studio/spec/macosx-x86-64/lib/libmtwkbench.a"
EIFTEMPLATES = /Applications/MacPorts/Eiffel_19.05/studio/config/macosx-x86-64/templates
LIBS = -lm -lpthread
MAKE = make
AR = ar
LD = ld
MKDEP = \$(EIFFEL_SRC)/C/mkdep $(DPFLAGS) --
MV = /bin/mv
CP = /bin/cp
RANLIB = :
RM = /bin/rm -f
FILE_EXIST = 
RMDIR = 
X2C = "/Applications/MacPorts/Eiffel_19.05/studio/spec/macosx-x86-64/bin/x2c"
SHAREDLINK = cc
SHAREDLIBS = -lm
SHARED_SUFFIX = .dylib
COMMAND_MAKEFILE = 
START_TEST = if [ ! -f finished ] ; then 
END_TEST = ; fi 
CREATE_TEST = touch finished 
SYSTEM_IN_DYNAMIC_LIB = abstract-graph.dylib 

.SUFFIXES:.cpp .o

.c.o:
	$(CC) $(CFLAGS) -c $<

.cpp.o:
	$(CPP) $(CPPFLAGS) -c $<

OBJECTS = big_file_C3_c.o 

OLDOBJECTS =  pa1025.o pa1025d.o ce1047.o ce1047d.o ve1055.o ve1055d.o ed1056.o \
	ed1056d.o ed1057.o ed1057d.o pa1033.o pa1033d.o pa1035.o pa1035d.o \
	pa1036.o pa1036d.o pa1037.o pa1037d.o pa1048.o pa1048d.o pa1049.o \
	pa1049d.o pa1051.o pa1051d.o pa1052.o pa1052d.o se1038.o se1038d.o \
	ve1040.o ve1040d.o co1053.o co1053d.o gr1039.o gr1039d.o se1031.o \
	se1031d.o se1032.o se1032d.o se1046.o se1046d.o fu1026.o fu1026d.o \
	fu1028.o fu1028d.o fu1030.o fu1030d.o fu1034.o fu1034d.o fu1042.o \
	fu1042d.o fu1044.o fu1044d.o fu1045.o fu1045d.o fu1050.o fu1050d.o \
	re1041.o re1041d.o ba1027.o ba1027d.o ba1029.o ba1029d.o ba1043.o \
	ba1043d.o in1054.o in1054d.o 

all: Cobj3.o

Cobj3.o: $(OBJECTS) Makefile
	$(LD) $(LDFLAGS) -r -o Cobj3.o $(OBJECTS)
	$(RM) $(OBJECTS)
	$(CREATE_TEST)

clean: local_clean
clobber: local_clobber

local_clean::
	$(RM) core finished *.o

local_clobber:: local_clean
	$(RM) Makefile

