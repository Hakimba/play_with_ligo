#include "../src/mutation.mligo"

(*
ces tests ne sont pas assez précis pour capturer la sémantique de la fonction que je veux tester (ici twice)
donc le test va fail parce que la mutation va trouver un opérateur arithmetique dans lequel les tests sont valide.
*)
let simple_tests (f : int -> int) =
    let () = assert (Test.michelson_equal (Test.run f 0) (Test.eval 0)) in
    let () = assert (Test.michelson_equal (Test.run f 2) (Test.eval 4)) in ()

let test_mutation =
    match Test.mutation_test twice simple_tests with
      None -> ()
    | Some (_, mutation) ->
        let () = Test.log mutation in failwith "Some mutation also passes the tests"