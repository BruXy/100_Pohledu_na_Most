TEX = context
SOURCES = $(wildcard *.tex)
PHOTOS = ./fotografie
OUTPUT = 100_Pohledu_na_Most

# Automatic variables
#
# https://monades.roperzh.com/rediscovering-make-automatic-variables/

# $@ ... targer name
# $< ... name of current prerequisite
# $? ... list of prerequisities newer than the target
# $^ ... list of all prerequisites

################################################################################

all: $(OUTPUT).pdf

$(OUTPUT).pdf: $(SOURCES)
	PHOTOS=$(PHOTOS) $(TEX) $(OUTPUT).tex

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
	-rm $(OUTPUT){-error.log,.log,.tua,.tuc}

veryclean: clean
	rm $(OUTPUT).pdf

