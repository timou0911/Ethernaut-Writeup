[Level 9. King](https://ethernaut.openzeppelin.com/level/9)

## In A Nutshell

> A contract without `fallback()` and `receive()` implemented can't receive any ether.

## Concepts

1. Three methods to send ether to other contracts. (`transfer()`, `send()`, and `call()`)
2. `receive()` function.

## Level Target

1. Take the kingship and avoid being taken when submitting the instance. (the level will try to reclaim it, and this should be denied)

## Breakdown & Analysis

1. In order to claim the kingship, we will need to call `receive()` with ether equal or more than the current prize. 

2. To ensure that the kingship cannot be taken when submitting the instance, we need a contract without implementing `fallback()` and `receive()`, so all we need is a contract that has a function to call `receive()`.

3. It's important to note that neither send nor transfer will work in this scenario, as the operation in receive costs more than the 2300 gas limit imposed on both methods.

## Detailed Steps

See [Attack.sol](https://github.com/timou0911/Ethernaut-Writeup/blob/main/09.%20King%20%E2%98%85%E2%98%85%E2%98%85%E2%98%86%E2%98%86/Attack.sol).

```js
await contract.prize().then(v => fromWei(v).toString()) // check the prize required to take the kingship
await contract._king() // check if kingship has been taken
```
## Three Methods to Send Ethers: `send()`, `transfer()`, & `call()`

### `send()`

1. This method has a gas limit of 2300 gas, which means that `receive()` or `fallback()` in the receiver contract can’t implement complicated operatioln.

2. It won’t `revert` if the transaction fails.

3. It has a boolean return value that indicates whether the transaction was successful or not.

```Solidity
function Send(address payable to, uint256 amount) external payable {
	bool success = to.send(amount);
  // since `send` won't revert the tx automatically, further code is usually necessary to handle the result
	if (!success) {
        	revert SendFailed();
    	}
}
```

### `transfer()`

1. This method has a gas limit of 2300 gas, which means that `receive()` or `fallback()` in the receiver contract can’t implement complicated operatioln.

2. Automatically `revert` if the transaction fails.

```Solidity
function Transfer(address payable to, uint amount) external payable {
	to.transfer(amount);
}
```

### `call()`

1. This method allows users to customize the gas limit and enables support for `receive()` or `fallback()` in the receiver contract to implements complicated operations.

2. It won’t `revert` if the transaction fails.

3. It has two return values:

    1. `bool success`: indicates whether the transaction was successful or not.
    
    2. `bytes memory data`: the return value of called function.

4. Users use `call()` to invoke functions in another contract and send ethers along with it, even without knowledge of its ABI.

```Solidity
// use call to send ethers to another contract
function sendEtherViaCall(address payable to) public payable {
     	// returns two values
   	(bool success, bytes memory data) = to.call{value: msg.value}("");
    	require(success, "Tx Failed");
}

// use call to invoke functions in another contract
function invokeFunction(address payable to, uint256 value) public payable {
	(bool success, bytes memory data) = to.call{value: msg.value}(
		abi.encodeWithSignature("changeValue(uint256)", value)
	);
	require(success, "Tx Failed");
}

// we can specify the gas, too
function invokeFunction(address payable to, uint256 value) public payable {
	(bool success, bytes memory data) = to.call{gas: 5000, value: msg.value}(
		abi.encodeWithSignature("changeValue(uint256)", value)
	);
	require(success, "Tx Failed");
}
```

## Two Methods to Receive Ethers: `receive()` & `fallback()`

* `msg.data` is empty:
  
  * If `receive()` exists, then `receive()` is triggered.
 
  * If `receive()` doesn't exist and `fallback()` exists, then `fallback()` is trigger.

* `msg.data` is not empty → `fallback()` is triggered.

* If both aren't implemented, then a contract can't reveice ethers.
