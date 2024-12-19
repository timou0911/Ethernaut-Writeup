[Level 11. Elevator](https://ethernaut.openzeppelin.com/level/11)

## In A Nutshell

> Functions without `pure` or `view` modifiers may lead to unexpected state modifications.

## Concept

1. `pure` and `view` modifiers.
2. Be careful when inheriting contracts.

## Level Target

1. Reach the top of the building, which means we should make the state variable `top` to `true`.

## Breakdown & Analysis

1. In Solidity, boolean values are default set to `false` if not explicitly initialized.
2. In contract `Elevator`, the only code that modifies the value of `top` is located in function `goTo`, specifically inside `if` statement.
3. To execute the code inside `if` statement, `isLastFloor(_floor)` should return `false`.
4. Inside the `if` statement, `top` can be set to `true` only if `isLastFloor(_floor)`  returns `true`.

Notice that `isLastFloor(_floor)` is called twice. To achieve the desired behavior, the first call should return `false`, while the second call should return `true`.

Since the logic of `isLastFloor` is not implemented, we can create our own `isLastFloor`!

## Detailed Steps

See [Attack.sol](https://github.com/timou0911/Ethernaut_Writeup/blob/main/11.%20Elevator%20%E2%98%85%E2%98%85%E2%98%86%E2%98%86%E2%98%86/Attack.sol).

## State Modifier - `view` & `pure`

* `view` modifier indicates that the function can only read the state but cannot write(change) the state of the contract. Mostly used in getter functions.
* `pure` modifier indicates that the function can neither read nor write the state of the contract.

|      | view | pure |
| ---- | ---- | ---- |
| read |  ✅ |  ❌ |
| write |  ❌ |  ❌ |

_Actions considered as write: modifying state variables, emitting events, sending ether, `selfdestruct`, creating contracts, and calling non-view and non-pure functions._

_Actions considered as read: reading state variables, accessing members of `block`, `tx`, `msg` (except `msg.sig` and `msg.data`), accessing address balance, and calling non-pure functions._

Both `view` function and `pure` functions don't cost gas if called from outside the contract.
