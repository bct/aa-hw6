/+  *test
/=  agent  /app/zulu
|%
::++  bowl
::  |=  run=@ud
::  ^-  bowl:gall
::  :*  [~zod ~zod %hark-store]
::    [~ ~]
::    [run `@uvJ`(shax run) (add (mul run ~s1) *time) [~zod %aa-hw6 ud+run]]
::  ==
++  bowl  *bowl:gall
+$  state
  $:  %0
      values=(list @)
  ==
--
|%
++  test-push
  =|  run=@ud
  =^  move  agent  (~(on-poke agent bowl) %zulu-action !>([%push ~zod 10.000]))
  =+  !<(=state on-save:agent)
  %+  expect-eq
    !>  `(list @)`~[10.000]
    !>  values.state
--
