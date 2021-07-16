IMAGES:=zipf.png zipflog.png linear.png yeq.png xeq.png meq.png ceq.png logr.png logf.png m.png alpha.png A.png Aeq.png
BOILERPLATE:=boilerplate.tex

.PHONY: all clean
all: $(IMAGES)
clean:
	-@rm -f $(IMAGES)

%.png: %.tex
	pdflatex -shell-escape $<
	-rm -f $(<:.tex=.aux) $(<:.tex=.log) $(<:.tex=.pdf)
	convert $@ -colorspace RGB -scale 50% $@

%.tex: %.txt $(BOILERPLATE)
	python -c 'open("$@","w").write(open("$(BOILERPLATE)").read().replace("--FORMULA--",open("$<").read().strip()))'
