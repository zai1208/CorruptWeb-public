extends Control






func _ready():
	var p = LoadAssets.get_asset("Image_Placeholder")
	$TextureRect.texture = p
