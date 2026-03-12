extends Panel
class_name InventorySlot

signal slot_clicked(slot: InventorySlot)

var slot_index: int = 0
var item: Item = null
var quantity: int = 0

@onready var item_icon: TextureRect = $ItemIcon
@onready var quantity_label: Label = $QuantityLabel
@onready var button: Button = $Button

var is_selected: bool = false

var normal_style: StyleBoxFlat
var selected_style: StyleBoxFlat

func _ready() -> void:

	if button:
		button.pressed.connect(_on_button_pressed)
	
	clear_slot()

func set_item(slot_data: Dictionary) -> void:
	if slot_data.has("item"):
		item = slot_data["item"]
		quantity = slot_data["quantity"]
		if item.icon:
			item_icon.texture = item.icon
			item_icon.show()
		else:
			# Show placeholder or hide
			item_icon.hide()
		
		if quantity_label:
			if quantity > 1:
				quantity_label.text = str(quantity)
				quantity_label.show()
			else:
				quantity_label.hide()
	else:
		clear_slot()

func clear_slot() -> void:
	item = null
	quantity = 0
	
	if item_icon:
		item_icon.texture = null
		item_icon.hide()
	
	if quantity_label:
		quantity_label.hide()

func set_selected(selected: bool) -> void:
	is_selected = selected
	if selected:
		add_theme_stylebox_override("panel", selected_style)
	else:
		add_theme_stylebox_override("panel", normal_style)

func _on_button_pressed() -> void:
	emit_signal("slot_clicked", self)
