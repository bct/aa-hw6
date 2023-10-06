/-  *zulu
/+  *test
/=  agent  /app/zulu
|%
++  bowl  *bowl:gall
+$  state
  $:  %0
      values=(list @)
  ==
--
|%
++  poke-push
  |=  [target=@p value=@]
  ^-  [(list card:agent:gall) _agent]
  (~(on-poke agent bowl) %zulu-action !>([%push target value]))
++  poke-pop
  |=  [target=@p]
  ^-  [(list card:agent:gall) _agent]
  (~(on-poke agent bowl) %zulu-action !>([%pop target]))
++  card-fact-update
  |=  =update
  ^-  card:agent:gall
  [%give %fact ~[/values] %zulu-update !>(update)]
++  card-pass-action
  |=  [target=@p =vase]
  ^-  card:agent:gall
  [%pass /pokes %agent [target %zulu] %poke %zulu-action vase]
--
|%
++  test-push-self
  =|  run=@ud
  =^  mov1  agent  (poke-push ~zod 10.000)
  =^  mov2  agent  (poke-push ~zod 20.000)
  =+  !<(=state on-save:agent)
  ;:  weld
  :: pushing prepends the item to the list
  %+  expect-eq
    !>  `(list @)`~[20.000 10.000]
    !>  values.state
  :: pushing emits a %zulu-update
  %+  expect-eq
    !>  ~[(card-fact-update [%push ~zod 10.000])]
    !>  mov1
  ==
++  test-pop-empty
  =|  run=@ud
  =^  move  agent  (poke-pop ~zod)
  =+  !<(=state on-save:agent)
  ;:  weld
  :: popping an empty state does not modify the state
  %+  expect-eq
    !>  `(list @)`~
    !>  values.state
  :: it does emit a %zulu-update though
  %+  expect-eq
    !>  ~[(card-fact-update [%pop ~zod])]
    !>  move
  ==
++  test-push-other
  =|  run=@ud
  :: the bowl we're using belongs to ~zod, so this is a remote target
  =^  move  agent  (poke-push ~nec 10.000)
  =+  !<(=state on-save:agent)
  ;:  weld
  :: we pass the poke on to the target and emit no %zulu-updates
  %+  expect-eq
    !>  ~[(card-pass-action ~nec !>([%push ~nec `@`10.000]))]
    !>  move
  :: our state is still empty
  %+  expect-eq
    !>  `(list @)`~
    !>  values.state
  ==
++  test-pop-other
  =|  run=@ud
  :: our state has a value in it
  =^  mov1  agent  (poke-push ~zod 10.000)
  :: the bowl we're using belongs to ~zod, so this is a remote target
  =^  move  agent  (poke-pop ~nec)
  =+  !<(=state on-save:agent)
  ;:  weld
  :: we pass the poke on to the target and emit no %zulu-updates
  %+  expect-eq
    !>  ~[(card-pass-action ~nec !>([%pop ~nec]))]
    !>  move
  :: our state was not popped
  %+  expect-eq
    !>  `(list @)`~[10.000]
    !>  values.state
  ==
++  test-peek
  =|  run=@ud
  =^  mov1  agent  (poke-push ~zod 10.000)
  =^  mov2  agent  (poke-push ~zod 20.000)
  %+  expect-eq
    !>  `(list @)`~[20.000 10.000]
    :: is there some way to clean this up?
    :: this is a (unit (unit cage))
    q:(need (need (~(on-peek agent bowl) [%x %values ~])))
++  test-watch
  =|  run=@ud
  =^  mov1  agent  (poke-push ~zod 10.000)
  =^  mov2  agent  (poke-push ~zod 20.000)
  =^  watch  agent  (~(on-watch agent bowl) [%values ~])
  %+  expect-eq
    !>  :~
      `card:agent:gall`[%give %fact ~ %zulu-update !>(`update`[%init ~[20.000 10.000]])]
    ==
    !>  watch
--
