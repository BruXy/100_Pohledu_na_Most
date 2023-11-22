TEX = context
SOURCES = $(wildcard *.tex)

# Automatic variables
#
# https://monades.roperzh.com/rediscovering-make-automatic-variables/

# $@ ... targer name
# $< ... name of current prerequisite
# $? ... list of prerequisities newer than the target
# $^ ... list of all prerequisites

################################################################################

all: 100_Pohledu_na_Most.pdf

100_Pohledu_na_Most.pdf: $(SOURCES)
	$(TEX) 100_Pohledu_na_Most.tex

vlna: $(SOURCES)
	@for i in $^; do \
			vlna $$i; \
		done
	# Delete backup files created by vlna
	# rm $$(find | grep '\.te~')

################################################################################

.PHONY: all vlna clean veryclean

clean:
	-rm 100_Pohledu_na_Most.pdf

veryclean: clean


