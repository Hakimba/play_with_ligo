#include "../src/inc_dec.mligo"

(*le test fail volontairement, j'ai deux endpoints que je test pas du tout*)

let originate_and_test (mainf : parameter * storage -> return) =
    let initial_storage = 7 in
    let (taddr,_,_) = Test.originate mainf initial_storage 0tez in
    let contr = Test.to_contract taddr in
    let _ = Test.transfer_to_contract_exn contr (Increment 7) 1mutez in
    assert (Test.get_storage taddr = initial_storage + 7)

let test = originate_and_test main

(*La, mutation_test_all va me renvoyer toute les mutations pour lesquelles les tests passent tous, et va les foutre dans un fichier pour
chaque mutation.*)
let test_mutation =
    match Test.mutation_test_all main originate_and_test with
      [] -> ()
    | ms -> 
        let () = List.iter (fun ((_, mutation) : unit * mutation) ->
                            let path = Test.save_mutation "." mutation in
                            let () = Test.log "Saved at:" in
                            Test.log path) ms in
        failwith "some mutation also passes the tests"