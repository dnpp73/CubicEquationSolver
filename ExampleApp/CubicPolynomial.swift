import Foundation
import CoreGraphics
import CubicEquationSolver

// y = (a * x^3) + (b * x^2) + (c * x) + d

struct CubicPolynomial {

    static var zero = CubicPolynomial(a: 0.0, b: 0.0, c: 0.0, d: 0.0)

    var a: Double
    var b: Double
    var c: Double
    var d: Double

    var roots: [Double] {
        return solveCubicEquation(a: a, b: b, c: c, d: d)
    }

    func y(for x: Double) -> Double {
        return a * pow(x, 3.0) + b * pow(x, 2.0) + c * x + d
    }

    func point(for x: CGFloat) -> CGPoint {
        let y = CGFloat(self.y(for: Double(x)))
        return CGPoint(x: x, y: y)
    }

}
