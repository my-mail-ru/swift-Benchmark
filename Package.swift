// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "Benchmark",
	products: [
		.library(name: "Benchmark", targets: ["Benchmark"]),
	],
	targets: [
		.target(name: "Benchmark", path: "Sources"),
		.testTarget(name: "BenchmarkTests", dependencies: ["Benchmark"]),
	]
)
