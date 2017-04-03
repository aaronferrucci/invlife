INDATA := data/blinker.dzn
OUTDATA := data/out.dzn
ALL := out print
.PHONY: all $(ALL)
all: $(ALL)

out: invlife.mzn $(INDATA)
	mzn2fzn invlife.mzn -d $(INDATA)
	flatzinc -a -b lazy invlife.fzn | \
	solns2out invlife.ozn | \
	grep -v '^---' > \
	$(OUTDATA)

.PHONY: print
print: out
	cat $(OUTDATA)

.PHONY: clean
clean:
	rm -f invlife.fzn
	rm -f invlife.ozn

