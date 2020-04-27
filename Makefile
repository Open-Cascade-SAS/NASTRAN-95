################################################################################

F77 = gfortran
AR = ar
# The -g flag is used because compilation of NASTRAN 95 with optimization flag lead to:
# Program received signal SIGSEGV: Segmentation fault - invalid memory reference.
# It occurs with -g flag too sometimes for inp/d03031a.inp test.
FLAGS += -g -fno-range-check -fno-automatic -std=legacy -Imds -Imis -Llib -Jobj

BINDIR := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))bin
ifeq ($(OS), Windows_NT)
	NASTRAN = $(BINDIR)/nastran.bat
else
	# TODO
	NASTRAN = $(BINDIR)/nastran.sh
endif

################################################################################

all:       nastran nasthelp nastplot chkfil ff tests
nastran:   obj lib bin/nastran.exe
nasthelp:  obj bin/nasthelp.exe
nastplot:  obj bin/nastplot.exe
chkfil:    obj bin/chkfil.exe
ff:        obj lib bin/ff.exe

lib:
	mkdir -p lib
obj:
	mkdir -p obj
output:
	mkdir -p output
clean:
	rm -rf obj lib
	rm -f bin/*.exe
	rm -rf output

################################################################################

BDOBJ+=$(patsubst bd/%.f,obj/%.o,$(wildcard bd/*.f))
MDSOBJ+=$(patsubst mds/%.f,obj/%.o,$(wildcard mds/*.f))
MISOBJ+=$(patsubst mis/%.f,obj/%.o,$(wildcard mis/*.f))

################################################################################

bin/nastran.exe: obj/nastrn.o $(BDOBJ) $(MISOBJ) $(MDSOBJ)
	$(F77) $(FLAGS) -static $^ -o $@
bin/nasthelp.exe: obj/nasthelp.o
	$(F77) $(FLAGS) -static $^ -o $@
bin/nastplot.exe: obj/nastplot.o
	$(F77) $(FLAGS) -static $^ -o $@
bin/ff.exe: obj/ff.o $(BDOBJ) $(MISOBJ) $(MDSOBJ)
	$(F77) $(FLAGS) -static $^ -o $@
bin/chkfil.exe: obj/chkfil.o
	$(F77) $(FLAGS) -static $^ -o $@

################################################################################

obj/%.o : bd/%.f
	$(F77) $(FLAGS) -c $< -o $@
obj/%.o : bin/%.f
	$(F77) $(FLAGS) -c $< -o $@
obj/%.o : mds/%.f
	$(F77) $(FLAGS) -c $< -o $@
obj/%.o : mis/%.f
	$(F77) $(FLAGS) -c $< -o $@
obj/%.o : um/%.f
	$(F77) $(FLAGS) -c $< -o $@
obj/%.o : utility/%.f
	$(F77) $(FLAGS) -c $< -o $@

################################################################################

TESTS+=$(patsubst inp/%.inp,output/%.f06,$(wildcard inp/*.inp))

tests: nastran output $(TESTS)

################################################################################

output/%.f06 : inp/%.inp output
	$(NASTRAN) outdir=output $<
output/d02022a.f06: inp/d02022a.inp output/d02021a.f06
	$(NASTRAN) outdir=output sof1=output/d02021a.sof1 $<
output/d02023a.f06: inp/d02023a.inp output/d02022a.f06
	$(NASTRAN) outdir=output sof1=output/d02021a.sof1 $<
output/d02024a.f06: inp/d02024a.inp output/d02023a.f06
	$(NASTRAN) outdir=output sof1=output/d02021a.sof1 $<
output/d02025a.f06: inp/d02025a.inp output/d02024a.f06
	$(NASTRAN) outdir=output sof1=output/d02021a.sof1 $<
output/d02026a.f06: inp/d02026a.inp output/d02025a.f06
	$(NASTRAN) outdir=output sof1=output/d02021a.sof1 $<
output/d02027a.f06: inp/d02027a.inp output/d02026a.f06
	$(NASTRAN) outdir=output sof1=output/d02021a.sof1 $<
output/d02032a.f06: inp/d02032a.inp output/d02031a.f06
	$(NASTRAN) outdir=output sof1=output/d02031a.sof1 $<
output/d02033a.f06: inp/d02033a.inp output/d02032a.f06
	$(NASTRAN) outdir=output sof1=output/d02031a.sof1 $<
output/d02034a.f06: inp/d02034a.inp output/d02033a.f06
	$(NASTRAN) outdir=output sof1=output/d02031a.sof1 $<
output/d02035a.f06: inp/d02035a.inp output/d02034a.f06
	$(NASTRAN) outdir=output sof1=output/d02031a.sof1 $<
output/d02036a.f06: inp/d02036a.inp output/d02035a.f06
	$(NASTRAN) outdir=output sof1=output/d02031a.sof1 $<
output/d01011b.f06: inp/d01011b.inp output/d01011a.f06
	$(NASTRAN) dictnm=output/d01011a.dict outdir=output optpnm=output/d01011a.nptp $<
output/d01011c.f06: inp/d01011c.inp output/d01011a.f06
	$(NASTRAN) dictnm=output/d01011a.dict outdir=output optpnm=output/d01011a.nptp $<
output/d01021b.f06: inp/d01021b.inp output/d01021a.f06
	$(NASTRAN) dictnm=output/d01021a.dict outdir=output optpnm=output/d01021a.nptp $<
output/d11011b.f06: inp/d11011b.inp output/d11011a.f06
	$(NASTRAN) dictnm=output/d11011a.dict outdir=output optpnm=output/d11011a.nptp $<
output/t00001a.f06: inp/t00001a.inp
	$(NASTRAN) outdir=output ftn15=inp/t00001a.inp1 ftn16=inp/t00001a.inp2 $<
output/t03111b.f06: inp/t03111b.inp output/t03111a.f06
	$(NASTRAN) dictnm=output/t03111a.dict outdir=output optpnm=output/t03111a.nptp $<
output/t03121b.f06: inp/t03121b.inp output/t03121a.f06
	$(NASTRAN) dictnm=output/t03121a.dict outdir=output optpnm=output/t03121a.nptp $<
output/t03121c.f06: inp/t03121c.inp output/t03121a.f06
	$(NASTRAN) dictnm=output/t03121a.dict outdir=output optpnm=output/t03121a.nptp $<
output/t04021b.f06: inp/t04021b.inp output/t04021a.f06
	$(NASTRAN) dictnm=output/t04021a.dict outdir=output optpnm=output/t04021a.nptp $<
