import Glibc

func + (lhs: timeval, rhs: timeval) -> timeval {
	var result = timeval(
		tv_sec: lhs.tv_sec + rhs.tv_sec,
		tv_usec: lhs.tv_usec + rhs.tv_usec
	)
	if result.tv_usec > 1000000 {
		result.tv_sec += 1
		result.tv_usec -= 1000000
	}
	return result
}

func - (lhs: timeval, rhs: timeval) -> timeval {
	var result = timeval(
		tv_sec: lhs.tv_sec - rhs.tv_sec,
		tv_usec: lhs.tv_usec - rhs.tv_usec
	)
	if result.tv_usec < 0 {
		result.tv_sec -= 1
		result.tv_usec += 1000000
	}
	return result
}

extension FloatingPoint {
	init(_ time: timeval) {
		self = Self(time.tv_sec) + Self(time.tv_usec) / 1000000
	}
}

extension timeval : CustomStringConvertible {
	public var description: String {
		return "\(Double(self))"
	}
}
