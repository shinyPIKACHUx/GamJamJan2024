
class_name AudioBusLayoutIndicies

# this provides constant results and should be updated if the audio bus layout is changed!
# idk if there's a way to automatically make this

const busMap: Dictionary = {
	"Master": ["Amplify"],
	"Music": ["Amplify"],
	"Effects": ["Amplify"],
	"Noise": ["Amplify"],
	"Voices": ["Amplify"]
}

static func getBusList() -> Array[String]:
	var busList: Array[String]
	for key in busMap:
		busList.append(key)
	return busList

static func getBusIndex(busName: String) -> int:
	var busList = getBusList()
	var i = 0
	for name in busList:
		if (name == busName):
			return i
		i += 1
	return -1 # means not found

static func getBusEffectIndex(busName: String, effectName: String) -> Pair:
	var busIndex = getBusIndex(busName)
	if (busIndex == -1):
		return Pair.construct(-1, 0)
	var effectsList = busMap[busName]
	var i = 0
	for name in effectsList:
		if (name == effectName):
			return Pair.construct(busIndex, i)
	return Pair.construct(busIndex, -1)
