INDATA := data/blinker.dzn
OUTDATA := data/out.dzn
.PHONY: all
all: invlife.fzn $(OUTDATA)

invlife.fzn: invlife.mzn
	mzn2fzn invlife.mzn -d $(INDATA)

$(OUTDATA): invlife.fzn
	flatzinc invlife.fzn | \
	solns2out invlife.ozn | \
	grep -v '^---' | \
	tee $(OUTDATA)

.PHONY: clean
clean:
	rm -f invlife.fzn
	rm -f invlife.ozn

