all:vcs

vcs:
	vcs -kdb -sverilog -debug_acc -full64 -R mul.v mul_tb.v

verdi:
	verdi  -simflow -simBin simv -ssf mul.fsdb 

clean:
	rm -rf unrSimv* simv* csrc* novas* *fsdb *.key verdi* novas* BSS* nWaveLog* vericom* work*

