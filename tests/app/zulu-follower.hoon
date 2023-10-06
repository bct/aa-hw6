/+  *test
/=  agent  /app/zulu-follower
|%
++  bowl  *bowl:gall
--
|%
++  poke-sub
  |=  target=@p
  ^-  [(list card:agent:gall) _agent]
  (~(on-poke agent bowl) %noun !>([%sub target]))
++  poke-unsub
  |=  target=@p
  ^-  [(list card:agent:gall) _agent]
  (~(on-poke agent bowl) %noun !>([%unsub target]))
++  card-pass-watch
  |=  target=@p
  ^-  card:agent:gall
  [%pass /values-wire %agent [target %zulu] %watch /values]
++  card-pass-leave
  |=  target=@p
  ^-  card:agent:gall
  [%pass /values-wire %agent [target %zulu] %leave ~]
--
|%
++  test-sub
  =|  run=@ud
  =^  move  agent  (poke-sub ~nec)
  %+  expect-eq
    !>  ~[(card-pass-watch ~nec)]
    !>  move
++  test-unsub
  =|  run=@ud
  =^  move  agent  (poke-unsub ~nec)
  %+  expect-eq
    !>  ~[(card-pass-leave ~nec)]
    !>  move
++  test-on-agent-kick
  =|  run=@ud
  =^  move  agent  (~(on-agent agent bowl) /values-wire [%kick ~])
  :: we attempt to resubscribe
  %+  expect-eq
    :: TODO: modify the bowl to give a better test of who we should
    :: resubscribe to
    !>  ~[(card-pass-watch ~zod)]
    !>  move
--
