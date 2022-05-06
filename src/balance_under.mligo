type balances = (address, tez) map

let balances_under (b : balances) (threshold : tez) : balances =
    Map.fold
        (fun ((acc,(k,v)) : balances * (address * tez)) ->
            if v < threshold then Map.remove k acc else acc)
        b b

let _u = Test.reset_state 3n ([] : tez list)

let balances : balances =
    let a1 = Test.nth_bootstrap_account 0 in
    let a2 = Test.nth_bootstrap_account 1 in
    let a3 = Test.nth_bootstrap_account 2 in
    Map.literal [(a1, 10tz);(a2, 100tz);(a3, 1000tz)]