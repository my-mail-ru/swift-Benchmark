import Glibc

let minCount = 4
let minCpuTime = 0.4

public func timethis(count: Int, title: String? = nil, _ body: () throws -> Void) rethrows {
	var clockStart = timespec()
	var clockFinish = timespec()
	var start = rusage()
	var finish = rusage()
	clock_gettime(CLOCK_MONOTONIC, &clockStart)
	getrusage(RUSAGE_SELF.rawValue, &start)
	for _ in 0..<count {
		try body()
	}
	getrusage(RUSAGE_SELF.rawValue, &finish)
	clock_gettime(CLOCK_MONOTONIC, &clockFinish)
	let wcl = clockFinish - clockStart
	let usr = finish.ru_utime - start.ru_utime
	let sys = finish.ru_stime - start.ru_stime
	print("\(title != nil ? title! + ": " : "")\(wcl) wallclock secs (\(usr) usr + \(sys) sys = \(usr + sys) CPU)")
	if count < minCount || Double(usr + sys) < minCpuTime {
		print("\t(warning: too few iterations for a reliable count)")
	}
}