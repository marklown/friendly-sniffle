extends Node

var node_player = preload("res://Player.tscn")
var node_spikes_up = preload("res://Spikes_Up.tscn")
var node_falling_block = preload("res://FallingBlock.tscn")

func _ready():
	
	var player_placed = false
	
	var tm = get_node('TileMap')
	var sizex = tm.get_cell_size().x
	var sizey = tm.get_cell_size().y
	var ts = tm.get_tileset()
	var uc = tm.get_used_cells()
	for pos in uc :
		var id = tm.get_cell(pos.x, pos.y)
		var name = ts.tile_get_name(id)
		# replace spikes up
		if name == "Placeholder_SpikesUp":
			var node = node_spikes_up.instance()
			node.position = Vector2( pos.x * sizex + (0.5*sizex), pos.y * sizey + (0.5*sizey))
			$Spikes.add_child(node)
			tm.set_cell(pos.x, pos.y, -1)
		# replace falling blocks
		if name == "Placeholder_FallingBlock":
			var node = node_falling_block.instance()
			node.position = Vector2( pos.x * sizex + (0.5*sizex), pos.y * sizey + (0.5*sizey))
			$FallingBlocks.add_child(node)
			tm.set_cell(pos.x, pos.y, -1)
		if name == "Placeholder_PlayerStart" and !player_placed:
			tm.set_cell(pos.x, pos.y, -1)
			if !player_placed:
				var node = node_player.instance()
				node.position = Vector2( pos.x * sizex + (0.5*sizex), pos.y * sizey + (0.5*sizey))
				add_child(node)
				player_placed = true	
	
	var spikes = get_node('Spikes')
	if spikes:
		for spike in spikes.get_children():
			spike.connect('hit_player', self, '_on_player_hit_spikes')
			
	$Player.connect('player_fell_off_map', self, '_on_player_fell_off_map')
			
			
func _on_player_hit_spikes():
	$Player.hit()

	
func _on_player_fell_off_map():
	get_tree().reload_current_scene()