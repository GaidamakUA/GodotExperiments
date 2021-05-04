extends Panel

signal interaction_finished
signal potion_used

var sword: Wearable = preload("res://items/Sword.tres")
var armour: Wearable = preload("res://items/Armour.tres")
var boots: Wearable = preload("res://items/Boots.tres")
var potion: Item = preload("res://items/Potion.tres")

func show_shop():
	_init_item($VBoxContainer/Sword, sword)
	_init_item($VBoxContainer/Armour, armour)
	_init_item($VBoxContainer/Boots, boots)
	_init_item($VBoxContainer/Potion, potion)
	show()

func _init_item(button: Button, item: Item):
	button.text = str(item.name, " (", item.description, ") ", item.price, "G")
	if PlayerStats.items.has(item):
		button.disabled = true
		return
	if not item.is_available(PlayerStats.gold):
		button.disabled = true
		return
	button.disabled = false

func _on_Sword_pressed():
	_on_wearable_puchised(sword)

func _on_Armour_pressed():
	_on_wearable_puchised(armour)

func _on_Boots_pressed():
	_on_wearable_puchised(boots)

func _on_wearable_puchised(item: Wearable):
	PlayerStats.items.append(item)
	PlayerStats.gold -= item.price
	emit_signal("interaction_finished")
	hide()

func _on_Potion_pressed():
	PlayerStats.gold -= potion.price
	emit_signal("potion_used")
	emit_signal("interaction_finished")
	hide()


func _on_Close_pressed():
	emit_signal("interaction_finished")
	hide()
