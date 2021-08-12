CREATE OR REPLACE VIEW qwat_ch_aeptc.autres_installations AS

	-- Chambres
	SELECT
		-- AEPT Attributs de base
		node.id AS "Identificateur",
		installation.name AS "Nom",
		chamber.qwat_ext_ch_aeptc_remarque AS "Remarque",
		pressurezone.name AS "Identificateur_de_la_partie_de_reseau",
		-- autres_installations
		'Chambre_vanne' AS "Type",
		traitement.value_fr AS "Traitement",
		st_force2d(node.geometry) AS "Geometrie"
	FROM qwat_od.installation
	LEFT JOIN qwat_od.chamber chamber on installation.id = chamber.id
	LEFT JOIN qwat_vl.aeptc_oui_non_indet traitement on chamber.qwat_ext_ch_aeptc_traitement = traitement.id
	LEFT JOIN qwat_od.node on installation.id = node.id
	LEFT JOIN qwat_od.pressurezone pressurezone on node.fk_pressurezone = pressurezone.id
	WHERE chamber.id IS NOT NULL AND chamber.qwat_ext_ch_aeptc_type_chambre_captage IS NULL

	UNION

	-- Puits
	SELECT
		-- AEPT Attributs de base
		node.id AS "Identificateur",
		installation.name AS "Nom",
		puit.qwat_ext_ch_aeptc_remarque AS "Remarque",
		pressurezone.name AS "Identificateur_de_la_partie_de_reseau",
		-- autres_installations
		puit_type.value_fr AS "Type",
		traitement.value_fr AS "Traitement",
		st_force2d(node.geometry) AS "Geometrie"
	FROM qwat_od.installation
	LEFT JOIN qwat_ch_aeptc.puit puit on installation.id = puit.id
	LEFT JOIN qwat_vl.aeptc_puit_type puit_type on puit.fk_type_puit = puit_type.id
	LEFT JOIN qwat_vl.aeptc_oui_non_indet traitement on puit.qwat_ext_ch_aeptc_traitement = traitement.id
	LEFT JOIN qwat_od.node on installation.id = node.id
	LEFT JOIN qwat_od.pressurezone pressurezone on node.fk_pressurezone = pressurezone.id
	WHERE puit.id IS NOT NULL

	UNION

	-- Soupape_regulation_pression
	SELECT
		-- AEPT Attributs de base
		node.id AS "Identificateur",
		installation.name AS "Nom",
		pressurecontrol.qwat_ext_ch_aeptc_remarque AS "Remarque",
		pressurezone.name AS "Identificateur_de_la_partie_de_reseau",
		-- autres_installations
		'Soupape_regulation_pression' AS "Type",
		traitement.value_fr AS "Traitement",
		st_force2d(node.geometry) AS "Geometrie"
	FROM qwat_od.installation
	LEFT JOIN qwat_od.pressurecontrol pressurecontrol on installation.id = pressurecontrol.id
	LEFT JOIN qwat_vl.aeptc_oui_non_indet traitement on pressurecontrol.qwat_ext_ch_aeptc_traitement = traitement.id
	LEFT JOIN qwat_od.node on installation.id = node.id
	LEFT JOIN qwat_od.pressurezone pressurezone on node.fk_pressurezone = pressurezone.id
	WHERE pressurecontrol.fk_pressurecontrol_type IN (2801, 2802);

GRANT SELECT, REFERENCES, TRIGGER ON TABLE qwat_ch_aeptc.autres_installations TO qwat_viewer;
GRANT ALL ON TABLE qwat_ch_aeptc.autres_installations TO qwat_user;
GRANT ALL ON TABLE qwat_ch_aeptc.autres_installations TO qwat_manager;
