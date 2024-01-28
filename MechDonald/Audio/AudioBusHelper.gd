
class_name AudioBusHelper

# this provides constant results and should be updated if the audio bus layout is changed!
# idk if there's a way to automatically make this

#order important
const busList: Array[String] = [ # speeds up getBusList
	"Master",
	"Music",
	"Effects",
	"Noise",
	"Voices"
]

const busMap: Dictionary = {
	"Master": ["Amplify"],
	"Music": ["Amplify"],
	"Effects": ["Amplify"],
	"Noise": ["Amplify"],
	"Voices": ["Amplify"]
}

static func getBusList() -> Array[String]:
	return busList
	
static func isValidBusName(busName: String) -> bool:
	var busList: Array[String] = getBusList()
	return busName in busList

static func getBusIndex(busName: String) -> int:
	var busList: Array[String] = getBusList()
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
	
static func getBusEffectByName(busName: String, effectName: String) -> AudioEffect:
	var indicies: Pair = getBusEffectIndex(busName, effectName)
	return AudioServer.get_bus_effect(indicies.first, indicies.second)

static func getBusFromEnum(busEnum: Enums.BusEnum) -> String:
	return busList[busEnum]
