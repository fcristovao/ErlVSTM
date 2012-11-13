TYPE=eps
MONOCHROME=false
PLANTUML_JAR = plantuml.jar
SOURCES = $(wildcard *.puml)
OUTPUTS = $(SOURCES:.puml=.$(TYPE))

all: $(OUTPUTS)

%.$(TYPE): %.puml
	java -jar $(PLANTUML_JAR) -t$(TYPE) -Smonochrome=$(MONOCHROME) -duration -pipe < $< > $@

clean:
	rm -f *.$(TYPE)
