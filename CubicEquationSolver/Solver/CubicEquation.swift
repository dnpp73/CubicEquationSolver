import Foundation

// real number only

// ax^3 + bx^2 + cx + d = 0
public func solveCubicEquation(a: Double, b: Double, c: Double, d: Double) -> [Double] {
    if a == 0.0 {
        return solveQuadraticEquation(a: b, b: c, c: d)
    } else {
        // should be delete `a`
        let A = b / a
        let B = c / a
        let C = d / a
        return solveCubicEquation(A: A, B: B, C: C)
    }
}

//MARK:- Private

// x^3 + Ax^2 + Bx + C = 0
private func solveCubicEquation(A: Double, B: Double, C: Double) -> [Double] {
    if A == 0.0 {
        return solveCubicEquation(p: B, q: C)
    } else {
        // x = X - A/3 (completing the cubic. should be delete `Ax^2`)
        let p = B - (pow(A, 2.0) / 3.0)
        let q = C - ((A * B) / 3.0) + ((2.0 / 27.0) * pow(A, 3.0))
        let roots = solveCubicEquation(p: p, q: q)
        return roots.map { $0 - A/3.0 }
    }
}

// x^3 + px + q = 0
// for avoid considering the complex plane, I choose geometric solution.
// respect François Viète
// ref: https://pomax.github.io/bezierinfo/#extremities
private func solveCubicEquation(p: Double, q: Double) -> [Double] {
    let p3 = p / 3.0
    let q2 = q / 2.0
    let discriminant = pow(q2, 2.0) + pow(p3, 3.0) // D: discriminant
    if discriminant < 0.0 {
        // three possible real roots
        let r = sqrt(pow(-p3, 3.0))
        let t = -q / (2.0 * r)
        let cosphi = min(max(t, -1.0), 1.0)
        let phi = acos(cosphi)
        let c = 2.0 * cuberoot(r)
        let root1 = c * cos(phi/3.0)
        let root2 = c * cos((phi+2.0*Double.pi)/3.0)
        let root3 = c * cos((phi+4.0*Double.pi)/3.0)
        return [root1, root2, root3]
    } else if discriminant == 0.0 {
        // three real roots, but two of them are equal
        let u: Double
        if q2 < 0.0 {
            u = cuberoot(-q2)
        } else {
            u = -cuberoot(q2)
        }
        let root1 = 2.0 * u
        let root2 = -u
        return [root1, root2]
    } else {
        // one real root, two complex roots
        let sd = sqrt(discriminant)
        let u = cuberoot(sd - q2)
        let v = cuberoot(sd + q2)
        let root1 = u - v
        return [root1]
    }
}

private func cuberoot(_ v: Double) -> Double {
    let c = 1.0 / 3.0
    if v < 0.0 {
        return -pow(-v, c)
    } else {
        return pow(v, c)
    }
}
