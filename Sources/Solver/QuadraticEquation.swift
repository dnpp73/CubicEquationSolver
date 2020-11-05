import Foundation

// real number only

// ax^2 + bx + c = 0
public func solveQuadraticEquation(a: Double, b: Double, c: Double) -> [Double] {
    if a == 0.0 {
        // seems linear equation
        let root = solveLinearEquation(a: b, b: c)
        return [root].filter({ !$0.isNaN })
    }

    let discriminant = pow(b, 2.0) - (4.0 * a * c) // D = b^2 - 4ac
    if discriminant < 0.0 {
        return []
    } else if discriminant == 0.0 {
        let root = -b / (2.0 * a)
        return [root]
    } else {
        let d = sqrt(discriminant)
        let root1 = (-b + d) / (2.0 * a)
        let root2 = (-b - d) / (2.0 * a)
        return [root1, root2]
    }
}
