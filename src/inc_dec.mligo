type storage = int

type parameter =
    Increment of int
    | Decrement of int
    | Reset

type return = operation list * storage

let incr (store, delta : storage * int) : storage = store + delta
let decr (store, delta : storage * int) : storage = store - delta

let main (action, store : parameter * storage) : return =
    ([] : operation list),
    (match action with
          Increment (n) -> incr (store, n)
        | Decrement (n) -> decr (store, n)
        | Reset -> 0
    )