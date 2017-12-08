# Benchmark

![Swift: 4.0](https://img.shields.io/badge/Swift-4.0-orange.svg)
![OS: Linux | macOS | iOS | watchOS | tvOS](https://img.shields.io/badge/OS-Linux%20%7C%20macOS%20%7C%20iOS%20%7C%20watchOS%20%7C%20tvOS-brightgreen.svg)
![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)

The Benchmark library provides a number of functions to help you figure out how long
(both in terms of wallclock and CPU time) it takes to execute some code.

## Functions

### timethis

```swift
	func timethis(count: Int, title: String? = nil, _ body: () throws -> Void) rethrows
```

Run a chunk of code several times. Results will be printed to STDOUT.

```swift
	timethis(count: 3) {
		// do something
	}

	// Output:
	// 0.444793617 wallclock secs (0.308 usr + 0.004 sys = 0.312 CPU)
```
