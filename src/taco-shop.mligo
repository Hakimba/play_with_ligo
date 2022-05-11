type taco_context = {
    stock : nat;
    max_price : tez;
}

type taco_shop_storage = (nat, taco_context) map

let init_storage : taco_shop_storage = Map.literal [
  (1n, { stock = 50n ; max_price = 50tez }) ;
  (2n, { stock = 20n ; max_price = 75tez }) ;
]

type return = operation list * taco_shop_storage

let ownerAddr : address = ("tz1gfdQqxbCQKDKdftCtHNQmHZLTgoVzY47h" : address)

let buy_taco (taco_kind_index, taco_shop_storage : nat * taco_shop_storage) : return =
    let taco_kind : taco_context =
      match Map.find_opt (taco_kind_index) taco_shop_storage with
      | Some k -> k
      | None -> (failwith "unknown kind of taco" : taco_context)
    in
    let current_purchase_price = taco_kind.max_price / taco_kind.stock in
    if Tezos.amount >= current_purchase_price 
      then 
        let updated_stock = Map.update
          taco_kind_index
          (Some {taco_kind with stock = abs (taco_kind.stock - 1n) })
          taco_shop_storage
        in
        let receiverContract : unit contract = match (Tezos.get_contract_opt ownerAddr : unit contract option) with
          | Some (ctr) -> ctr
          | None -> (failwith "This address doesn't lead to a contract" : unit contract)
        in
        let ops = [Tezos.transaction unit Tezos.amount receiverContract] in
        (ops, updated_stock)
      else
        (failwith "not enough tez send for buying this kind of taco" : return)