CREATE OR REPLACE VIEW qwat_ch_aeptc.autres_installations AS

	-- Chambres
	SELECT
		-- AEPT Attributs de base
		COALESCE(network_element.identification, installation.id::character varying) AS "Identificateur",
		installation.name AS "Nom",
		chamber.qwat_ext_ch_aeptc_remarque AS "Remarque",
		pressurezone.name AS "Identificateur_de_la_partie_de_reseau",
		-- autres_installations
		'Chambre_vanne' AS "Type",
		COALESCE(traitement.value_fr, 'Indetermine') AS "Traitement",
		st_force2d(node.geometry) AS "Geometrie"
	FROM qwat_od.installation
	LEFT JOIN qwat_od.chamber chamber on installation.id = chamber.id
	LEFT JOIN qwat_vl.aeptc_oui_non_indet traitement on chamber.qwat_ext_ch_aeptc_traitement = traitement.id
	LEFT JOIN qwat_od.node on installation.id = node.id
	LEFT JOIN qwat_od.network_element network_element on installation.id = network_element.id
	LEFT JOIN qwat_od.pressurezone pressurezone on node.fk_pressurezone = pressurezone.id
	WHERE chamber.id IS NOT NULL AND chamber.qwat_ext_ch_aeptc_type_chambre_captage IS NULL
	AND fk_status IN (
		--101, -- "autre"
		102, -- "inconnu"
		103, -- "à déterminer"
		1301 -- "en service"
		--1302, -- "hors service"
		--1303, -- "désaffecté"
		--1304, -- "abandonné"
		--1305, -- "détruit"
		--1306, -- "projet"
		--1307, -- "fictif"
	) AND fk_watertype = 1502

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
		COALESCE(traitement.value_fr, 'Indetermine') AS "Traitement",
		st_force2d(node.geometry) AS "Geometrie"
	FROM qwat_od.installation
	LEFT JOIN qwat_ch_aeptc.puit puit on installation.id = puit.id
	LEFT JOIN qwat_vl.aeptc_puit_type puit_type on puit.fk_type_puit = puit_type.id
	LEFT JOIN qwat_vl.aeptc_oui_non_indet traitement on puit.qwat_ext_ch_aeptc_traitement = traitement.id
	LEFT JOIN qwat_od.node on installation.id = node.id
	LEFT JOIN qwat_od.network_element network_element on installation.id = network_element.id
	LEFT JOIN qwat_od.pressurezone pressurezone on node.fk_pressurezone = pressurezone.id
	WHERE puit.id IS NOT NULL
	AND fk_status IN (
		--101, -- "autre"
		102, -- "inconnu"
		103, -- "à déterminer"
		1301 -- "en service"
		--1302, -- "hors service"
		--1303, -- "désaffecté"
		--1304, -- "abandonné"
		--1305, -- "détruit"
		--1306, -- "projet"
		--1307, -- "fictif"
	) AND fk_watertype = 1502

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
		COALESCE(traitement.value_fr, 'Indetermine') AS "Traitement",
		st_force2d(node.geometry) AS "Geometrie"
	FROM qwat_od.installation
	LEFT JOIN qwat_od.pressurecontrol pressurecontrol on installation.id = pressurecontrol.id
	LEFT JOIN qwat_vl.aeptc_oui_non_indet traitement on pressurecontrol.qwat_ext_ch_aeptc_traitement = traitement.id
	LEFT JOIN qwat_od.node on installation.id = node.id
	LEFT JOIN qwat_od.network_element network_element on installation.id = network_element.id
	LEFT JOIN qwat_od.pressurezone pressurezone on node.fk_pressurezone = pressurezone.id
	WHERE pressurecontrol.fk_pressurecontrol_type IN (2801, 2802)
	AND fk_status IN (
		--101, -- "autre"
		102, -- "inconnu"
		103, -- "à déterminer"
		1301 -- "en service"
		--1302, -- "hors service"
		--1303, -- "désaffecté"
		--1304, -- "abandonné"
		--1305, -- "détruit"
		--1306, -- "projet"
		--1307, -- "fictif"
	) AND fk_watertype = 1502
UNION
	SELECT COALESCE(network_element.identification, installation.id::character varying) AS "Identificateur",
	installation.name AS "Nom",
	'Installation de traitement' AS "Remarque",
	pressurezone.name AS "Identificateur_de_la_partie_de_reseau",
	'Autre'::character varying AS "Type",
	'Oui' AS "Traitement",
	st_force2d(node.geometry) AS "Geometrie"
	FROM qwat_od.installation
	LEFT JOIN qwat_od.treatment treatment ON installation.id = treatment.id
	LEFT JOIN qwat_od.node ON installation.id = node.id
	LEFT JOIN qwat_od.network_element network_element ON installation.id = network_element.id
	LEFT JOIN qwat_od.pressurezone pressurezone ON node.fk_pressurezone = pressurezone.id
	WHERE treatment.id is not null 
	AND network_element.fk_status = IN (
		--101, -- "autre"
		102, -- "inconnu"
		103, -- "à déterminer"
		1301 -- "en service"
		--1302, -- "hors service"
		--1303, -- "désaffecté"
		--1304, -- "abandonné"
		--1305, -- "détruit"
		--1306, -- "projet"
		--1307, -- "fictif"
	) AND installation.fk_watertype = 1502;

GRANT SELECT, REFERENCES, TRIGGER ON TABLE qwat_ch_aeptc.autres_installations TO qwat_viewer;
GRANT ALL ON TABLE qwat_ch_aeptc.autres_installations TO qwat_user;
GRANT ALL ON TABLE qwat_ch_aeptc.autres_installations TO qwat_manager;
