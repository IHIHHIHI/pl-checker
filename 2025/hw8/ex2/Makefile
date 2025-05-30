all: run

run: parser.cmo sm5.cmo sonata.cmo translator.cmo main.cmo
	ocamlc -o run sm5.cmo str.cma parser.cmo sonata.cmo translator.cmo main.cmo

sm5.cmo : sm5.ml sm5.mli
	ocamlc -c sm5.mli
	ocamlc -c sm5.ml

sonata.cmo : sonata.ml sonata.mli
	ocamlc -c sonata.mli
	ocamlc -c sonata.ml

translator.cmo : translator.ml sm5.cmo sonata.cmo
	ocamlc -c translator.ml

parser.cmo: parser.ml sm5.cmo
	ocamlc -c parser.ml

main.cmo : sm5.cmo parser.cmo sonata.cmo translator.cmo main.ml
	ocamlc -c main.ml

clean:
	rm -f *.cmx *.cmi run *.o *.cmo examples/*.out
