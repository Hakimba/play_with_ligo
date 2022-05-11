#include "../src/taco-shop.mligo"

let test =
  let (pedro_taco_shop_addr, _, _) = Test.originate buy_taco init_storage 0tez in
  let pedro_taco_shop_ctr = Test.to_contract pedro_taco_shop_addr in
  let pedro_taco_shop = Tezos.address (pedro_taco_shop_ctr) in

  let classico_taco = 1n in
  let special_taco = 2n in
  let unknown_taco = 3n in

  ()

