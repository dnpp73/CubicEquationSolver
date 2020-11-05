// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "CubicEquationSolver",
    platforms: [
        .macOS(.v10_10), .iOS(.v9), .tvOS(.v9), .watchOS(.v2)
    ],
    products: [
        .library(name: "CubicEquationSolver", targets: ["CubicEquationSolver"]),
    ],
    targets: [
        .target(
            name: "CubicEquationSolver",
            dependencies: [],
            path: "Sources/CubicEquationSolver/Solver"
        ),
        .testTarget(
            name: "CubicEquationSolverTests",
            dependencies: ["CubicEquationSolver"],
            path: "Tests/CubicEquationSolverTests"
        ),
    ]
)
