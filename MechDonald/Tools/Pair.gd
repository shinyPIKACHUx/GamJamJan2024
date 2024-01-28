
class_name Pair

var first
var second

static func construct(nFirst, nSecond) -> Pair:
	var p: Pair = Pair.new()
	p.first = nFirst
	p.second = nSecond
	return p

func getFirst():
	return self.first
func getSecond():
	return self.second
	
func setFirst(nFirst):
	self.first = nFirst
func setSecond(nSecond):
	self.second = nSecond
