extends Position2D

var velocidad = Vector2()
export (float) var GRAVEDAD = 100
export (float) var velocidadDeMovimiento = 4000
export (float) var vel_salto = 300
var puedeSaltar = false
var estaEnAgua = false
func _ready():
	pass 

func _physics_process(delta):
	
	velocidad.y += GRAVEDAD * delta
	if(Input.is_action_pressed("tecla_d")):
		velocidad.x = velocidadDeMovimiento
		get_node("cuerpo_j1/Sprite").flip_h = true
		if(Input.is_action_just_pressed("tecla_a") && (puedeSaltar) && !estaEnAgua):
			get_node("cuerpo_j1/animacion_j1").play("miradaArriba")
		elif(Input.is_action_just_pressed("tecla_ab") && (puedeSaltar) && !estaEnAgua):
			get_node("cuerpo_j1/animacion_j1").play("miradaAbajo")
		elif(Input.is_action_just_released("tecla_ab") && (puedeSaltar) && !estaEnAgua || Input.is_action_just_released("tecla_a") && (puedeSaltar) && !estaEnAgua):
			get_node("cuerpo_j1/animacion_j1").stop()
		elif(!get_node("cuerpo_j1/animacion_j1").is_playing() && (puedeSaltar)):
			if(!estaEnAgua):
				get_node("cuerpo_j1/animacion_j1").play("corriendo")
			else:
				get_node("cuerpo_j1/animacion_j1").play("nadando")
	elif(Input.is_action_pressed("tecla_i")):
		velocidad.x = -velocidadDeMovimiento
		get_node("cuerpo_j1/Sprite").flip_h = false
		if(Input.is_action_just_pressed("tecla_a") && (puedeSaltar) && !estaEnAgua):
			get_node("cuerpo_j1/animacion_j1").play("miradaArriba")
		elif(Input.is_action_just_pressed("tecla_ab") && (puedeSaltar) && !estaEnAgua):
			get_node("cuerpo_j1/animacion_j1").play("miradaAbajo")
		elif(Input.is_action_just_released("tecla_ab") && (puedeSaltar) && !estaEnAgua || Input.is_action_just_released("tecla_a") && (puedeSaltar) && !estaEnAgua):
			get_node("cuerpo_j1/animacion_j1").stop()
		elif(!get_node("cuerpo_j1/animacion_j1").is_playing() && (puedeSaltar)):
			if(!estaEnAgua):
				get_node("cuerpo_j1/animacion_j1").play("corriendo")
			else:
				get_node("cuerpo_j1/animacion_j1").play("nadando")
	elif(Input.is_action_pressed("tecla_a")):
		if(puedeSaltar && !estaEnAgua):
			get_node("cuerpo_j1/animacion_j1").play("miradaARR")
		velocidad.x = 0
	elif(Input.is_action_pressed("tecla_ab")):
		if(puedeSaltar):
			if(!estaEnAgua):
				get_node("cuerpo_j1/animacion_j1").play("cuerpoTierra")
			else:
				get_node("cuerpo_j1/animacion_j1").play("bajoAgua")
		velocidad.x = 0
	else:
		velocidad.x = 0
		if(puedeSaltar):
			if(!estaEnAgua):
				get_node("cuerpo_j1/animacion_j1").play("j_idle")
			else:
				get_node("cuerpo_j1/animacion_j1").play("aguaIdle")

	if(Input.is_action_pressed("tecla_z") && puedeSaltar):
		velocidad.y = -vel_salto
		get_node("cuerpo_j1/animacion_j1").play("salto")
		puedeSaltar = false
	var movimiento = velocidad * delta
	get_node("cuerpo_j1").move_and_slide(movimiento)
	
	if(get_node("cuerpo_j1").get_slide_collision(get_node("cuerpo_j1").get_slide_count()-1) != null):
		var objetoColisionado = get_node("cuerpo_j1").get_slide_collision(get_node("cuerpo_j1").get_slide_count()-1).collider
		if(objetoColisionado.is_in_group("suelo")):
			if(puedeSaltar == false):
				puedeSaltar = true
				get_node("cuerpo_j1/animacion_j1").stop()
				if(objetoColisionado.is_in_group("agua")):
					estaEnAgua = true
				else:
					estaEnAgua = false
	elif(puedeSaltar):
		puedeSaltar = false
