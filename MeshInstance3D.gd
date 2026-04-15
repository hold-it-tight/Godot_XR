extends MeshInstance3D

func _ready():
	# Ensure the node has a valid mesh
	if mesh == null:
		push_error("No mesh assigned to MeshInstance3D!")
		return
	
	# Check if the parent is already a physics body
	var parent = get_parent()
	var is_physics_body = parent is StaticBody3D or parent is RigidBody3D or parent is CharacterBody3D
	
	# If no physics body parent, add a StaticBody3D
	if not is_physics_body:
		var static_body = StaticBody3D.new()
		get_parent().add_child(static_body)
		static_body.owner = get_tree().edited_scene_root
		# Reparent MeshInstance3D to be a child of StaticBody3D
		get_parent().remove_child(self)
		static_body.add_child(self)
		self.owner = get_tree().edited_scene_root
		parent = static_body
	
	# Create a CollisionShape3D
	var collision_shape = CollisionShape3D.new()
	parent.add_child(collision_shape)
	collision_shape.owner = get_tree().edited_scene_root
	
	# Generate a convex collision shape from the mesh
	var shape = ConvexPolygonShape3D.new()
	var mesh_data = mesh.create_convex_shape(true, true) # Clean and simplify the mesh
	shape.points = mesh_data.get_faces()
	collision_shape.shape = shape
	
	# Optionally, use a concave shape (for static, complex meshes)
	# var shape = ConcavePolygonShape3D.new()
	# shape.set_faces(mesh.create_trimesh_shape().get_faces())
	# collision_shape.shape = shape
	
	# Position the collision shape to match the MeshInstance3D
	collision_shape.transform = transform
	
