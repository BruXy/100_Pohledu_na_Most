TEX = context
SOURCES = $(wildcard *.tex)
PHOTOS = ./fotografie
#AGENT='Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/119.0.0.0 Safari/537.36' 


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
			vlna -r $$i; \
		done

# Stažení obrázků z iDNES.cz, pokud odkaz nevede přímo na název
# souboru '*.jpg', pak je nutné nastavit cookie adb=1. Pro snadnější
# práci se souborem je u některých přípona doplněna.
download:
	@mkdir -p $(PHOTOS)
	for i in $$(sed -ne '/^% Foto:/{s///;p}' 20*.tex); do \
		output="$(PHOTOS)/$$(basename $$i)"; \
		[[ "$$output" != *".jpg" ]] && output=$${output}.jpg ; \
		[ ! -f "$$output" ] && curl --cookie "adb=1" $$i -o $$output || \
			printf "%s already exists.\n" "$$output"; \
		done
################################################################################

.PHONY: all vlna clean veryclean download

clean:
	-rm 100_Pohledu_na_Most.pdf

veryclean: clean
