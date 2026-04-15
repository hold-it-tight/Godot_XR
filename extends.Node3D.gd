extends Node3D

var xr_initerface: XRInterface


func _ready():
	xr_initerface = XRServer.find_interface("OpenXR")
	
	if xr_initerface and xr_initerface.is_initialized():
		print("OpenXR initialized successfully")
		
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)
			
		get_viewport().use_xr = true
	else:
		print("OpenXR not initialized, please chech if your headset in connected")
		



	
