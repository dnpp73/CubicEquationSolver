import Foundation

// ax + b = 0
public func solveLinearEquation(a: Double, b: Double) -> Double {
    if a == 0.0 {
        return .nan
    } else {
        let root = -b / a
        return root
    }
}
