extends Node3D

@onready var gun_anim = $AnimationPlayer
@onready var gun_barrel = $gun_barrel
@onready var fire_rate = $fire_rate_gun
@onready var player = $"../../.."
@onready var secondaryAmmoDisplay = $"../../../../../UI/Hud/Ammo/Secondary"
var gunAmmo = 20
var can_fire_gun = true

#stats
var damage := 1


var bullet = load("res://Scenes/bullet.tscn")
var instance

# Called when the node enters the scene tree for the first time.
func _ready():
	player.fire_gun.connect(_on_player_fire_gun)
	update_gun_ammo_display()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	

func _on_player_fire_gun():
	if !gun_anim.is_playing() and can_fire_gun and gunAmmo > 0:
		gunAmmo -= 1
		update_gun_ammo_display()
		can_fire_gun = false
		fire_rate.start()
		gun_anim.play("Shoot")
		instance = bullet.instantiate()
		instance.position = gun_barrel.global_position
		instance.transform.basis = gun_barrel.global_transform.basis
		print(gun_barrel.position)
		player.get_parent().add_child(instance)


func _on_fire_rate_gun_timeout():
	can_fire_gun = true
	
func update_gun_ammo_display():
	secondaryAmmoDisplay.text = str(gunAmmo)


func _on_player_increase_gun_ammo():
	gunAmmo += 4
	update_gun_ammo_display()
