extends Node2D

# screen values
onready var screenWidth = get_tree().get_root().size.x
onready var screenHeight = get_tree().get_root().size.y
onready var halfScreenWidth = screenWidth/2
onready var halfScreenHeight = screenHeight/2

# ball variables
var ballRadius = 10.0
var ballColor = Color.white

# paddle variables
var paddleColor = Color.white
var paddleSize = Vector2(10.0,100.0)
var halfPaddleHeight = paddleSize.y/2
var paddlePadding = 10.0

# font variable
var font = DynamicFont.new()
var robotoFile = load("res://Roboto-Light.ttf")
var fontSize = 24
var halfWidthFont
var heightFont
var stringValue = "Hello World!"

# ball variable
onready var ballPosition = Vector2(halfScreenWidth,halfScreenHeight)

# player paddle
onready var playerPosition = Vector2(paddlePadding, halfScreenHeight - halfPaddleHeight)
onready var playerRectangle = Rect2(playerPosition, paddleSize)

#ai paddle
onready var aiPostion = Vector2(screenWidth - (paddlePadding + paddleSize.x), 
halfScreenHeight - halfPaddleHeight)
onready var aiRectangle = Rect2(aiPostion, paddleSize)

#string variable
var stringPosition

func _ready() -> void:
	# print(get_tree().get_root().size)
	font.font_data = robotoFile
	font.size = fontSize
	halfWidthFont = font.get_string_size(stringValue).x/2
	heightFont = font.get_height()
	stringPosition = Vector2(halfScreenWidth - halfWidthFont, heightFont)

func _physics_process(_delta: float) -> void:
	pass

func _draw() -> void:
	setStartingPosition()

func setStartingPosition():
	draw_circle(ballPosition, ballRadius, ballColor)
	draw_rect(playerRectangle, paddleColor)
	draw_rect(aiRectangle, paddleColor)
	draw_string(font, stringPosition, stringValue)


