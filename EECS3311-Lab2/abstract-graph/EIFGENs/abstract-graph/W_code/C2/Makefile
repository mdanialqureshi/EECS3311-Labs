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

OBJECTS = big_file_C2_c.o 

OLDOBJECTS =  fu1006.o fu1006d.o ty1007.o ty1007d.o bi1021.o bi1021d.o so1023.o \
	so1023d.o tw1020.o tw1020d.o tw1019.o tw1019d.o tw1018.o tw1018d.o \
	so1024.o so1024d.o ve1008.o ve1008d.o co992.o co992d.o ed1013.o \
	ed1013d.o li1002.o li1002d.o ds1009.o ds1009d.o ed1014.o ed1014d.o \
	qu1003.o qu1003d.o co1017.o co1017d.o nu1004.o nu1004d.o nu1005.o \
	nu1005d.o kl1010.o kl1010d.o ds1011.o ds1011d.o kl1015.o kl1015d.o \
	my1022.o my1022d.o da998.o da998d.o ti996.o ti996d.o kl1012.o \
	kl1012d.o kl1016.o kl1016d.o da994.o da994d.o da1001.o da1001d.o \
	da997.o da997d.o ti995.o ti995d.o da1000.o da1000d.o fi993.o fi993d.o \
	da999.o da999d.o 

all: Cobj2.o

Cobj2.o: $(OBJECTS) Makefile
	$(LD) $(LDFLAGS) -r -o Cobj2.o $(OBJECTS)
	$(RM) $(OBJECTS)
	$(CREATE_TEST)

clean: local_clean
clobber: local_clobber

local_clean::
	$(RM) core finished *.o

local_clobber:: local_clean
	$(RM) Makefile

