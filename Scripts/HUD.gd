extends CanvasLayer

func _ready():
	$Coins.text = String(0)
	
func update_coin(coins):
	$Coins.text = String(coins)
