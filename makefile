objdir = object
srcdir = source
incdir = include

python3inc = /usr/include/python3.6
python2inc = /usr/include/python2.7

objects = $(objdir)/windows.o $(objdir)/signal_processing.o $(objdir)/brent.o $(objdir)/frequency.o $(objdir)/fft.o  

cc = gcc
#cflags = --shared -fPIC -O2 -std=c99 -Wall -I$(INCDIR)
#cflags = -DCOMPILE_WITHOUT_FFTW -O3 -std=c99 -Wall -fPIC -I$(incdir)  #-I/usr/include/python2.7
cflags = -O3 -std=c99 -Wall -fPIC -I$(incdir)  #-I/usr/include/python2.7
#ldflags = -lm #-lpython
ldflags = -lfftw3 -lm #-lpython

all: NAFFlib_c.so NAFFlib2_c.so

NAFFlib_c.so: $(objects) $(objdir)/pynafflib3.o
	@#$(cc) $(cflags) $^ -o $@  
	@$(cc) --shared -fPIC $(cflags) $^ -o $@ $(ldflags) 

NAFFlib2_c.so: $(objects) $(objdir)/pynafflib2.o
	@#$(cc) $(cflags) $^ -o $@  
	@$(cc) --shared -fPIC $(cflags) $^ -o $@ $(ldflags) 

#$(objdir)/toy1.o: $(srcdir)/toy1.c $(incdir)/toy1.h 
#	@$(cc) -c $(cflags) $< -o $@ 

$(objdir)/windows.o: $(srcdir)/windows.c $(incdir)/windows.h 
	@$(cc) -c $(cflags) $< -o $@ 

$(objdir)/signal_processing.o: $(srcdir)/signal_processing.c $(incdir)/signal_processing.h 
	@$(cc) -c $(cflags) $< -o $@ 

$(objdir)/brent.o: $(srcdir)/brent.c $(incdir)/brent.h 
	@$(cc) -c $(cflags) $< -o $@ 

$(objdir)/frequency.o: $(srcdir)/frequency.c $(incdir)/frequency.h 
	@$(cc) -c $(cflags) $< -o $@ 

$(objdir)/fft.o: $(srcdir)/fft.c $(incdir)/fft.h 
	@$(cc) -c $(cflags) $< -o $@ 

$(objdir)/pynafflib3.o: $(srcdir)/pynafflib.c $(incdir)/pynafflib.h 
	@$(cc) -c $(cflags) -I$(python3inc) $< -o $@ 

$(objdir)/pynafflib2.o: $(srcdir)/pynafflib.c $(incdir)/pynafflib.h 
	@$(cc) -c $(cflags) -I$(python2inc) $< -o $@ 

clean:
	rm $(objdir)/*
	rm NAFFlib_c.so
	rm NAFFlib2_c.so
