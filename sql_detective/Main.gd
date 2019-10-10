extends Node2D

const SQLite = preload("res://bin/gdsqlite.gdns")
var db_name = "res://data/test"
var db = SQLite.new()

func _ready():
	db.path = db_name
	db.verbose_mode = false#true
	db.open_db()
	db.query("""CREATE TABLE security  (
    badge_number CHAR(5) NOT NULL PRIMARY KEY,
    sign_out_date DATE,
    sign_out_time TIME,
    sign_in_time TIME
    )""")
	db.query("""CREATE TABLE employee (
    employee_id CHAR(6) NOT NULL PRIMARY KEY,
    first_name VARCHAR(20),
    last_name VARCHAR(20),
    location CHAR(6),
    manager_id CHAR(6),
    extension CHAR(4),
    gender CHAR(1),
    hair_colour CHAR(6),
    badge_number CHAR(5) REFERENCES security (badge_number),
    restricted_access CHAR(1)
    )""")
	db.query("""CREATE TABLE lobby (
    first_name VARCHAR(20),
    last_name VARCHAR(20),
    badge_number CHAR(5) NOT NULL REFERENCES security (badge_number),
    PRIMARY KEY (first_name, last_name)
    )""")
	db.query("""CREATE TABLE hardware (
    employee_id CHAR(6) PRIMARY KEY,
    location CHAR(6),
    hardware_tn CHAR(8),
    hardware_sn CHAR(8) NOT NULL,
    FOREIGN KEY (employee_id) REFERENCES employee(employee_id)
    )""")
	print("There are ", db.query_result)
	load_data(db)
	db.close_db()

func load_data(db) -> void:
	var file = File.new()
	file.open("res://data/employee.del", file.READ)
	while !file.eof_reached():
		var csv: PoolStringArray = file.get_csv_line("|")
		if csv.size() == 1:
			continue
		print(csv.size())
		var inser_command: String = "INSERT INTO employee VALUES (\"" + csv[0] + "\",\""  + csv[1] + "\",\""  + csv[2] + "\",\""  + csv[3] + "\",\""  + csv[4] + "\",\""  + csv[5] + "\",\""  + csv[6] + "\",\""  + csv[7] + "\",\""  + csv[8] + "\",\""  + csv[9] + "\")"
		db.query(inser_command)

	file.open("res://data/hardware.del", file.READ)
	while !file.eof_reached():
		var csv: PoolStringArray = file.get_csv_line("|")
		if csv.size() == 1:
			continue
		var inser_command: String = "INSERT INTO hardware VALUES (\"" + csv[0] + "\",\""  + csv[1] + "\",\""  + csv[2] + "\",\""  + csv[3] + "\")"
		db.query(inser_command)

	file.open("res://data/lobby.del", file.READ)
	while !file.eof_reached():
		var csv: PoolStringArray = file.get_csv_line("|")
		if csv.size() == 1:
			continue
		var inser_command: String = "INSERT INTO hardware VALUES (\"" + csv[0] + "\",\""  + csv[1] + "\",\""  + csv[2] + "\")"
		db.query(inser_command)

	file.open("res://data/security.del", file.READ)
	while !file.eof_reached():
		var csv: PoolStringArray = file.get_csv_line("|")
		if csv.size() == 1:
			continue
		var inser_command: String = "INSERT INTO hardware VALUES (\"" + csv[0] + "\",\""  + csv[1] + "\",\""  + csv[2] + "\",\""  + csv[3] + "\""
		db.query(inser_command)

func _on_SubmitButton_pressed():
	var text: String = $TextEdit.text
	db.open_db()
	db.query(text)
	$Output.text = String(db.query_result)
	db.close_db()