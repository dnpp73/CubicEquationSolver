import XCTest
import CubicEquationSolver


final class CubicEquationSolverTests: XCTestCase {

    let accuracy: Double = 1e-8

    func testLinearEquation() {
        XCTAssertEqual(solveLinearEquation(a: 2.0, b: 3.0), -1.5, accuracy: accuracy)
    }

    func testQuadraticEquation() {
        XCTAssertEqual(solveQuadraticEquation(a: 1.0, b: 2.0, c: 1.0).first!, -1.0, accuracy: accuracy)
    }

    func testCubicEquation() {
        XCTAssertEqual(solveCubicEquation(a: 1.0, b: 1.0, c: 1.0, d: 1.0).first!, -1.0, accuracy: accuracy)
    }

}
