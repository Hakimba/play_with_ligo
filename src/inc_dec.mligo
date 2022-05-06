type storage = int

type parameter =
    Increment of int
    | Decrement of int
    | Reset

type return = operation list * storage

let main (action, store : parameter * storage) : return =
    ([] : operation list),
    (match action with
        Increment (n) -> (fun (store : storage) -> (fun (delta : int) -> store + delta)n) store
        | Decrement (n) -> (fun (store : storage) -> (fun (delta : int) -> store - delta)n) store
        | Reset -> 0
    )