extends CanvasLayer

func _ready():
	pass
	##$CoinPanel/Coins.text = String(0)
	##$LivesPanel/Players.text = String(0)
	##$KillsPanel/Kills.text = String(0)
	
func update_coin(coins):
	$CoinPanel/Coins.text = String(coins)

func update_lives(lives):
	$LivesPanel/Players.text = String(lives)
	
func update_kills(kills):
	$KillsPanel/Kills.text = String(kills)
