ligo := docker run --rm -v "${PWD}":"${PWD}" -w "${PWD}" ligolang/ligo:0.41.0
interpret := $(ligo) run interpret
test := $(ligo) run test

#les tests d'interpretation d'une seule operation
all_interpret : inc_dec_inter balance_under_inter

#le '@' c'est pour pas afficher les commandes qui vont etre executées c'est super moche et long

inc_dec_inter:
	@echo "inc_dec : tests interpreted :\n"
	@$(interpret) "main (Increment(30) , 10)" --init-file src/inc_dec.mligo
	@$(interpret) "main (Decrement(30) , 10)" --init-file src/inc_dec.mligo
	@$(interpret) "main (Reset , 10)" --init-file src/inc_dec.mligo

balance_under_inter:
	@echo "balance_under : tests are not implemented yet"

#les tests lancé avec 'ligo run test'
all_tests : inc_dec_test balance_under_test mutation_tests

inc_dec_test:
	@$(test) test/test_inc_dec.mligo

balance_under_test:
	@$(test) test/test_balance_under.mligo

mutation_tests:
	@$(test) test/test_mutation_contract.mligo
	@$(test) test/test_mutation.mligo