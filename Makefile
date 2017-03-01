# PIN_ROOT must point to the Pin kit root.

override PIN_ROOT = /home/mdiener/pin

# Do not edit below this line

ifdef PIN_ROOT
CONFIG_ROOT := $(PIN_ROOT)/source/tools/Config
else
CONFIG_ROOT := ../Config
endif
include $(CONFIG_ROOT)/makefile.config

TOOL_CXXFLAGS += -Wall -g -std=c++0x -Wno-error -Wextra -Wno-unused-parameter -pedantic -DTHREADSAFE

TOOL_LDFLAGS+= $(OBJDIR)/tracer_decode.o $(OBJDIR)/shadow.o $(OBJDIR)/resultvector.o $(OBJDIR)/tracebb.o $(OBJDIR)/output.o $(OBJDIR)/threads.o

OBJECT_ROOTS := tracer_decode shadow resultvector tracebb output threads

TOOL_ROOTS := tracer

include $(TOOLS_ROOT)/Config/makefile.default.rules


# all: tracer.so mintest deeploops mintest-nodebug

# tracer.o: tracer.cpp tracer.h tracerlib.h tracer_decode.h shadow.h resultvector.h tracebb.h instructions.h output.h threads.h
# 	$(CXX) $(COPTS1) $(INCDIR) $(COPTS2) -o tracer.o tracer.cpp

# tracer_decode.o: tracer_decode.cpp tracer_decode.h tracer.h instructions.h shadow.h
# 	$(CXX) $(COPTS1) $(INCDIR) $(COPTS2) -o tracer_decode.o tracer_decode.cpp

# tracebb.o: tracebb.cpp tracer_decode.h tracer.h tracebb.h shadow.h instructions.h resultvector.h
# 	$(CXX) $(COPTS1) $(INCDIR) $(COPTS2) -o tracebb.o tracebb.cpp

# shadow.o: shadow.cpp shadow.h
# 	$(CXX) $(COPTS1) $(INCDIR) $(COPTS2) -o shadow.o shadow.cpp

# output.o: output.cpp output.h instructions.h tracer.h
# 	$(CXX) $(COPTS1) $(INCDIR) $(COPTS2) -o output.o output.cpp

# threads.o: threads.cpp threads.h
# 	$(CXX) $(COPTS1) $(INCDIR) $(COPTS2) -o threads.o threads.cpp

# resultvector.o: resultvector.cpp resultvector.h
# 	$(CXX) $(COPTS1) $(INCDIR) $(COPTS2) -o resultvector.o resultvector.cpp

# tracer.so: tracer.o tracer_decode.o shadow.o resultvector.o tracebb.o output.o threads.o
# 	$(CXX) $(LOPTS) $(LINKDIR1) -o tracer.so tracer.o tracer_decode.o shadow.o resultvector.o output.o threads.o tracebb.o $(LINKDIR2) $(LIBS)

# mintest: mintest.o dummy.o
# 	$(CXX) -g -o mintest mintest.o dummy.o tracerlib.o

# mintest-nodebug: mintest-nodebug.o dummy.o tracerlib.o
# 	$(CXX) -o mintest-nodebug mintest-nodebug.o dummy.o tracerlib.o

# mintest-nodebug.o: mintest.cpp dummy.h tracerlib.h
# 	$(CXX) -O1 -c -o mintest-nodebug.o mintest.cpp

# mintest.o: mintest.cpp dummy.h tracerlib.h
# 	$(CXX) -O1 -g -c -gdwarf-2 -o mintest.o mintest.cpp

# deeploops: deeploops.o dummy.o tracerlib.o
# 	$(CXX) -std=gnu99 -g -O0 -o deeploops deeploops.o dummy.o tracerlib.o

# deeploops.o: deeploops.c dummy.h tracerlib.h
# 	$(CC) -O1 -std=c99 -c -g -gdwarf-2 -o deeploops.o deeploops.c

# deeploops-sol: deeploops-sol.o dummy.o tracerlib.o
# 	$(CXX) -g -o deeploops-sol deeploops-sol.o dummy.o tracerlib.o

# deeploops-sol.o: deeploops-sol.c dummy.h tracerlib.h
# 	$(CC) -O1 -std=c99 -c -g -gdwarf-2 -o deeploops-sol.o deeploops-sol.c

# buildtest.o: mintest.cpp dummy.h tracerlib.h
# 	$(CXX) $(BUILDTEST) -c -o mintest.o mintest.cpp

# dummy.o: dummy.cpp dummy.h
# 	$(CC) -c -o dummy.o dummy.cpp

# tracerlib.o: tracerlib.c tracerlib.h
# 	$(CC) -c -O0 -o tracerlib.o tracerlib.c

runtest: mintest
	$(PIN_ROOT)/pin -t $(OBJDIR)/tracer.so -o mintest.log -- ./mintest

rundeeploops: tracer.so deeploops
	$(PIN_ROOT)/pin -t $(OBJDIR)/tracer.so -o deeploops.log -- ./deeploops

rundeepbbloops: tracer.so deeploops
	$(PIN_ROOT)/pin -t $(OBJDIR)/tracer.so -o deeploops.log -bb -- ./deeploops

clean:
	rm -rf $(OBJDIR) *.o *.so mintest mintest.log deeploops deeploops.log deeploops-sol deeploops-sol.log mintest-nodebug

