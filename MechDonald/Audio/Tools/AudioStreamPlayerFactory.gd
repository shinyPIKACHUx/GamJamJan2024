
class_name AudioStreamPlayerFactory

static func create(
	name: String,
	type: Enums.AudioStreamPlayerEnum,
	soundFile: AudioStream,
	busToUse: Enums.BusEnum
):
	var obj
	if (type == Enums.AudioStreamPlayerEnum.AudioStreamPlayer):
		obj = AudioStreamPlayer.new()
	elif (type == Enums.AudioStreamPlayerEnum.AudioStreamPlayer2D):
		obj = AudioStreamPlayer2D.new()
	else:
		obj = AudioStreamPlayer3D.new()
	obj.set_name(name)
	obj.stream = soundFile
	obj.bus = AudioBusHelper.getBusStringFromEnum(busToUse)
	return obj
	
