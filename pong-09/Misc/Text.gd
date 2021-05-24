extends Node2D

class_name Text09

# font variable
var _font: DynamicFont = DynamicFont.new()
var _value: String = ""

var _halfWidth: float
var _height: float
var _pos: Vector2
var _centerPos: Vector2 #this is where our string centers to

func _init(value: String, position: Vector2, size:=24, file := load("res://Roboto-Light.ttf")) -> void:
	_font.set_font_data(file)
	_font.set_size(size)
	_value = value
	_halfWidth = _font.get_string_size(_value).x/2.0
	_height = _font.get_height()
	_centerPos = position
	_pos = Vector2(_centerPos.x - _halfWidth, _centerPos.y + _height)

func _draw() -> void:
	draw_string(_font, _pos, _value)

func updateString(newValue: String):
	_value = newValue
	_halfWidth = _font.get_string_size(_value).x/2.0
	_pos = Vector2(_centerPos.x - _halfWidth, _centerPos.y + _height)
	update()
