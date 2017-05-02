#if os(Linux) || os(FreeBSD) || os(PS4) || os(Android) || CYGWIN
import Glibc
#elseif os(macOS) || os(iOS) || os(watchOS) || os(tvOS)
import Darwin
#endif

func + (lhs: timespec, rhs: timespec) -> timespec {
	var result = timespec(
		tv_sec: lhs.tv_sec + rhs.tv_sec,
		tv_nsec: lhs.tv_nsec + rhs.tv_nsec
	)
	if result.tv_nsec > 1000000000 {
		result.tv_sec += 1
		result.tv_nsec -= 1000000000
	}
	return result
}

func - (lhs: timespec, rhs: timespec) -> timespec {
	var result = timespec(
		tv_sec: lhs.tv_sec - rhs.tv_sec,
		tv_nsec: lhs.tv_nsec - rhs.tv_nsec
	)
	if result.tv_nsec < 0 {
		result.tv_sec -= 1
		result.tv_nsec += 1000000000
	}
	return result
}

extension FloatingPoint {
	init(_ time: timespec) {
		self = Self(time.tv_sec) + Self(time.tv_nsec) / 1000000000
	}
}

extension timespec : CustomStringConvertible {
	public var description: String {
		return "\(Double(self))"
	}
}
