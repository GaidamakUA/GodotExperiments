extends VBoxContainer

onready var radius_spinner = $HBoxContainer/RadiusSpinner
onready var frequency_spinner = $HBoxContainer2/FrequencySpinner
onready var displacement_picker = $HBoxContainer3/DisplacementPicker

var _current_term: FourierTerm
var is_listening = true

func _ready():
	_set_editable(false)
	
func _set_editable(editable: bool):
	radius_spinner.editable = editable
	frequency_spinner.editable = editable
	displacement_picker.editable = editable

func _on_FourierTermsList_term_selected(term: FourierTerm):
	_set_editable(true)
	is_listening = false
	
	_current_term = term
	var coefficient = term.radius
	var displacement = term.displacement
	var frequency = term.frequency
	radius_spinner.value = coefficient
	frequency_spinner.value = frequency
	displacement_picker.value = displacement
	
	is_listening = true

func _on_DisplacementPicker_value_changed(value: float):
	if is_listening:
		_current_term.displacement = value


func _on_FrequencySpinner_value_changed(value: float):
	if is_listening:
		_current_term.frequency = int(value)


func _on_RadiusSpinner_value_changed(value: float):
	if is_listening:
		_current_term.radius = value
