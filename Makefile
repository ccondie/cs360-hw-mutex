CXX=		g++ $(CCFLAGS)
EXAMPLE=	example.o
PROBLEM=	problem.o
SEMAPHORE=	semaphore.o
MUTEX=		mutex.o
SOLUTION=	solution.o

OBJS =		$(EXAMPLE) $(PROBLEM) $(SEMAPHORE) $(MUTEX) $(SOLUTION)

LIBS=		-pthread

CCFLAGS= -g

all:		example problem semaphore mutex solution

example:	$(EXAMPLE)
		$(CXX) -o example $(EXAMPLE) $(LIBS)

problem:	$(PROBLEM)
		$(CXX) -o problem $(PROBLEM) $(LIBS)

semaphore:	$(SEMAPHORE)
		$(CXX) -o semaphore $(SEMAPHORE) $(LIBS)

mutex:	$(MUTEX)
		$(CXX) -o mutex $(MUTEX) $(LIBS)

solution:	$(SOLUTION)
			$(CXX) -o solution $(SOLUTION) $(LIBS)

clean:
		rm -f $(OBJS) $(OBJS:.o=.d)

realclean:
		rm -f $(OBJS) $(OBJS:.o=.d) example problem semaphore mutex solution


# These lines ensure that dependencies are handled automatically.
%.d:	%.cc
	$(SHELL) -ec '$(CC) -M $(CPPFLAGS) $< \
		| sed '\''s/\($*\)\.o[ :]*/\1.o $@ : /g'\'' > $@; \
		[ -s $@ ] || rm -f $@'

include	$(OBJS:.o=.d)
