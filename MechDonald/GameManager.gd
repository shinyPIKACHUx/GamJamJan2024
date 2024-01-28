extends Node3D

@export var mob_scenes : Array[PackedScene]
@export var boss_scene : PackedScene

func _physics_process(_delta):
	var fps = Engine.get_frames_per_second()
	if fps > 60:
		if Engine.physics_ticks_per_second != fps:
			Engine.physics_ticks_per_second = fps
			Engine.max_physics_steps_per_frame = fps / 7.5
		else: return
	else:
		if Engine.physics_ticks_per_second != 60:
			Engine.physics_ticks_per_second = 60
			Engine.max_physics_steps_per_frame = 8
		else: return

func _notification(what):
	if what == MainLoop.NOTIFICATION_APPLICATION_FOCUS_IN:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		print("focus in")
	elif what == MainLoop.NOTIFICATION_APPLICATION_FOCUS_OUT:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		print("focus out")

func _on_mob_timer_timeout():
	# Create new mob
	var mob = mob_scenes.pick_random().instantiate()
	
	var mob_spawn_location = get_node("SpawnPath/SpawnLocation")
	mob_spawn_location.progress_ratio = randf()
	
	mob.initialize(mob_spawn_location.position)
	
	add_child(mob)
	

func _on_boss_spawn_timer_timeout():
	# Create new mob
	var mob = boss_scene.instantiate()
	
	var mob_spawn_location = get_node("SpawnPath/SpawnLocation")
	mob_spawn_location.progress_ratio = randf()
	
	mob.initialize(mob_spawn_location.position)
	
	add_child(mob)
