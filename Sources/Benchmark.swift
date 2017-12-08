#if os(Linux) || os(FreeBSD) || os(PS4) || os(Android) || CYGWIN
import Glibc
#elseif os(macOS) || os(iOS) || os(watchOS) || os(tvOS)
import Darwin
#endif

let minCpuTime = 0.4

public struct Sample : CustomStringConvertible {
	public let count: Int
	let wcl: timespec
	let usr: timeval
	let sys: timeval

	public var wallclock: Double { return Double(wcl) }
	public var user: Double { return Double(usr) }
	public var system: Double { return Double(sys) }
	public var cpu: Double { return Double(usr + sys) }

	public var description: String {
		return "\(wcl) wallclock secs (\(usr) usr + \(sys) sys = \(usr + sys) CPU) @ \(Double(count) / cpu)/s (n=\(count))"
	}
}

public func benchmark(count: Int = 1, _ body: () throws -> Void) rethrows -> Sample {
	var clockStart = timespec()
	var clockFinish = timespec()
	var start = rusage()
	var finish = rusage()
	if #available(macOS 10.12, iOS 10.0, watchOS 3.0, tvOS 10.0, *) {
		clock_gettime(CLOCK_MONOTONIC, &clockStart)
	}
	getrusage(rusageSelf(), &start)
	for _ in 0..<count {
		try body()
	}
	getrusage(rusageSelf(), &finish)
	if #available(macOS 10.12, iOS 10.0, watchOS 3.0, tvOS 10.0, *) {
		clock_gettime(CLOCK_MONOTONIC, &clockFinish)
	}
	let wcl = clockFinish - clockStart
	let usr = finish.ru_utime - start.ru_utime
	let sys = finish.ru_stime - start.ru_stime
	return Sample(count: count, wcl: wcl, usr: usr, sys: sys)
}

public func timethis(count: Int, title: String? = nil, _ body: () throws -> Void) rethrows {
	let sample = try benchmark(count: count, body)
	print("\(title != nil ? title! + ": " : "")\(sample)")
	if sample.cpu < minCpuTime {
		print("\t(warning: too few iterations for a reliable count)")
	}
}

#if os(Linux)
	private func rusageSelf() -> __rusage_who {
		return RUSAGE_SELF
	}

	private func rusageSelf() -> __rusage_who.RawValue {
		return RUSAGE_SELF.rawValue
	}
#else
	private func rusageSelf() -> Int32 {
		return RUSAGE_SELF
	}
#endif
