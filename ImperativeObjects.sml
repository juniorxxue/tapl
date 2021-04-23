val c =
    let
        val x = ref 1
    in
        {
          get = fn (_ : unit) => !x,
          inc = fn (_ : unit) => x := 1 + !x
        }
    end

(*
#inc c ();
#get c ();

#inc c (); #inc c (); #get c ();
*)

val newCounter =
 fn (_ : unit) => let
     val x = ref 1
 in
     {
       get = fn (_ : unit) => !x,
       inc = fn (_ : unit) => x := 1 + !x
     }
 end


val newResetCounter =
 fn (_ : unit) => let
     val x = ref 1
 in
     {
       get = fn (_ : unit) => !x,
       inc = fn (_ : unit) => x := 1 + !x,
       reset = fn (_ : unit) => x := 1
     }
 end

type Counter = {
    get: unit -> int,
    inc: unit -> unit
}

val inc3 = fn (c : Counter) => (#inc c (); #inc c (); #inc c ())

val rc = newResetCounter ()
