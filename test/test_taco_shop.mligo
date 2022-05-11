#include "../src/taco-shop.mligo"

let test =
  let (pedro_taco_shop_ta, _, _) = Test.originate buy_taco init_storage 0tez in
  ()
