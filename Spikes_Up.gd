extends Area2D

signal hit_player


func _on_Spikes_Up_body_entered(body):
	if body.name == "Player":
		print("Player hit spikes!")
		emit_signal("hit_player")
