# System __F__

An implementation of System F, as described in PFPL.

## Running

Hopefully, `./repl.sh` should get you in a repl. Then you can do stuff like
this.

```
> (/\ t . \ x . x) : (all t . t -> t)
ann(Lam([t@40].lam([x@42].x@42)); all([t@43].arr(t@43; t@43)))
Good!
```

You can use actual Unicode too: `(Λ t . λ x . x) : (∀ t . t → t)`.
