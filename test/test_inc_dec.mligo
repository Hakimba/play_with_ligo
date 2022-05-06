#include "../src/inc_dec.mligo"

let test =
    let initial_storage = 40 in
    let taddr,_,size_prog = Test.originate main initial_storage 0tez in
    let () = Test.log ("size of the michelson compiled program : ", size_prog) in
    assert (Test.get_storage taddr = initial_storage)

let test2 =
    let initial_storage = 42 in
    let taddr,_,_ = Test.originate main initial_storage 0tez in
    let contr = Test.to_contract taddr in
    let gas_ = Test.transfer_to_contract_exn contr (Reset) 0mutez in
    let () = Test.log ("gas consumption", gas_) in
    assert (Test.get_storage taddr = 0)