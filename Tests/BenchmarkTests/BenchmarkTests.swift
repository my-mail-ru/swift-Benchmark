import XCTest
import Benchmark

class BenchmarkTests : XCTestCase {
	static let allTests = [
		("testBenchmark", testBenchmark),
	]

	func testBenchmark() {
		var count = 0
		var string = ""
		let sample = benchmark(count: 1000000) {
			count += 1
			string.append("Ъ")
		}
		XCTAssertEqual(count, 1000000)
		XCTAssertEqual(sample.count, 1000000)
		XCTAssertGreaterThan(sample.wallclock, 0)
		XCTAssertGreaterThan(sample.user, 0)
		XCTAssertGreaterThan(sample.system, 0)
		XCTAssertGreaterThan(sample.cpu, 0)
	}
}
