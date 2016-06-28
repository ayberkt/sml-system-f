# System __F__

An implementation of System F, as described in PFPL.

## Running

Hopefully, `./repl.sh` should get you in a repl. Then you can do stuff like
this.

```
> /\ t . \ f . \ x . f(x) : (t -> t) -> t -> t
Lam([t@6].lam([f@9].lam([x@11].ann(ap(f@9; x@11); arr(arr(t@6; t@6); arr(t@6; t@6))))))
```
