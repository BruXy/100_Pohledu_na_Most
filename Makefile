TEX = context

# Automatic variables
#
# https://monades.roperzh.com/rediscovering-make-automatic-variables/

# $@ ... targer name
# $< ... name of current prerequisite
# $? ... list of prerequisities newer than the target
# $^ ... list of all prerequisites

################################################################################

.SUFFIXES:
.SUFFIXES: .c .o

all: 100_Pohledu_na_Most.pdf

100_Pohledu_na_Most.pdf: 100_Pohledu_na_Most.tex
	$(TEX) $<
	

################################################################################

.PHONY: all clean veryclean

clean:
	-rm 100_Pohledu_na_Most.pdf

veryclean: clean


