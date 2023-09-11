
-- Listage des données de la table test2.addon_account : ~23 rows (environ)
INSERT INTO `addon_account` (`name`, `label`, `shared`) VALUES
	('society_cayobar', 'cayobar', 1);




-- Listage des données de la table test2.addon_account_data : ~24 rows (environ)
INSERT INTO `addon_account_data` (`id`, `account_name`, `money`, `owner`) VALUES
	(46546456, 'society_cayobar', 10000, NULL);



-- Listage des données de la table test2.addon_inventory : ~21 rows (environ)
INSERT INTO `addon_inventory` (`name`, `label`, `shared`) VALUES
	('society_cayobar', 'cayobar', 1);


-- Listage des données de la table test2.jobs : ~19 rows (environ)
INSERT INTO `jobs` (`name`, `label`) VALUES
	('cayobar', 'cayobar');



-- Listage des données de la table test2.job_grades : ~60 rows (environ)
INSERT INTO `job_grades` (`id`, `job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES
	(6456067, 'cayobar', 0, 'crew', 'Employé', 40, '{}', '{}'),
	(60786468, 'cayobar', 1, 'boss', 'Patron(e)', 40, '{}', '{}');
