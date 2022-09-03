INSERT INTO `addon_account` (name, label, shared) VALUES
	('society_fbi', 'fbi', 1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES
	('society_fbi', 'fbi', 1)
;

INSERT INTO `datastore` (name, label, shared) VALUES
	('society_fbi', 'fbi', 1)
;

INSERT INTO `jobs` (name, label) VALUES
	('fbi', 'fbi')
;

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
	('fbi',0,'recrue','Recrue',12,'{}','{}'),
	('fbi',1,'medium',"Medium",24,'{}','{}'),
	('fbi',2,'co','chef Operation',36,'{}','{}'),
	('fbi',3,'boss',"Patron",48,'{}','{}')
;



INSERT INTO `items` (`name`, `label`, `limit`) VALUES
	('kevlar', 'Gilet Pare Balles', 20),
	('oblivionPill', 'Pilule oubli', 5),
	('thermalvision', 'Vision thermique', 1)
;
