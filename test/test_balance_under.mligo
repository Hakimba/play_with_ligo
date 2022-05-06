#include "../src/balance_under.mligo"


let test =
    let f =
        fun ((threshold, expected_size) : tez * nat) ->
          let tester (balances, threshold : balances * tez) = Map.size (balances_under balances threshold) in
          let size = Test.run tester (balances, threshold) in
          let expected_size_mich = Test.eval expected_size in
          let () = Test.log ("expected", expected_size_mich) in
          let () = Test.log ("actual value", size) in
          assert (Test.michelson_equal size expected_size_mich)
    in List.iter f [(15tez,2n);(130tez,1n);(1200tez,0n)]