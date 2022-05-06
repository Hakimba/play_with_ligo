ligo := docker run --rm -v "${PWD}":"${PWD}" -w "${PWD}" ligolang/ligo:0.41.0
interpret := $(ligo) run interpret
all: inc_dec balance_under

#le '@' c'est pour pas afficher les commandes qui vont etre executées c'est super moche et long

inc_dec:
	@echo "inc_dec : tests interpreted :\n"
	@$(interpret) "main (Increment(30) , 10)" --init-file src/inc_dec.mligo
	@$(interpret) "main (Decrement(30) , 10)" --init-file src/inc_dec.mligo
	@$(interpret) "main (Reset , 10)" --init-file src/inc_dec.mligo

balance_under:
	@echo "balance_under : tests are not implemented yet"