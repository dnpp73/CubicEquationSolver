CubicEquationSolver
===========

[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat-square)](https://github.com/Carthage/Carthage)
![bitrise status](https://app.bitrise.io/app/3144cb5fb712fe14/status.svg?token=S1zRdswv1i47m4Y9j9Aq4Q&branch=master)


![ExampleApp](/ExampleApp.gif)


## What is this

Cubic Equation Solver written in [Swift](https://github.com/apple/swift).

I tested only iOS 10 - 12. maybe works fine macOS too.

```swift
// find roots of `ax^3 + bx^2 + cx + d = 0`
// returns only real number
func solveCubicEquation(a: Double, b: Double, c: Double, d: Double) -> [Double]
```


## For What?

I had to find `y` for any `x` in the cubic Bézier curve `B(t) = (x, y)`.

so I had to convert them to cubic equations `y = f(x)`  and solve...


## Carthage

https://github.com/Carthage/Carthage

Write your `Cartfile`

```
github "dnpp73/CubicEquationSolver"
```

and run

```sh
carthage bootstrap --no-use-binaries --platform iOS
```


## License

[MIT](/LICENSE)
