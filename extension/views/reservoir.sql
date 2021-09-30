CREATE OR REPLACE VIEW qwat_ch_aeptc.reservoir AS
	SELECT
		-- AEPT Attributs de base
		installation.id AS "Identificateur",
		installation.name AS "Nom",
		tank.qwat_ext_ch_aeptc_remarque AS "Remarque",
		pressurezone.name AS "Identificateur_de_la_partie_de_reseau",
		-- Attributs de Reservoir
		COALESCE(alimentation.value_fr, 'Autre') AS "Alimentation_electrique_de_secours",
		COALESCE(traitement.value_fr, 'Indetermine') AS "Traitement",
		COALESCE(storage_supply, -1) AS "Reserve_d_utilisation",
		st_force2d(node.geometry) AS "Geometrie",
		COALESCE(storage_fire, -1) AS "Reserve_d_extinction",
		COALESCE(altitude_overflow, -1) AS "Niveau_max_de_la_surface_de_l_eau"
	FROM qwat_od.installation installation
	LEFT JOIN qwat_od.tank tank on installation.id = tank.id
	LEFT JOIN qwat_vl.aeptc_alimentation_electrique_alternative alimentation on tank.qwat_ext_ch_aeptc_alimentation_electrique_de_secours = alimentation.id
	LEFT JOIN qwat_vl.aeptc_oui_non_indet traitement on tank.qwat_ext_ch_aeptc_traitement = traitement.id
	LEFT JOIN qwat_od.node on installation.id = node.id
	LEFT JOIN qwat_od.network_element network_element on installation.id = network_element.id
	LEFT JOIN qwat_od.pressurezone pressurezone on node.fk_pressurezone = pressurezone.id
	WHERE tank.id IS NOT NULL
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
	) AND fk_watertype = 1502;
	
GRANT SELECT, REFERENCES, TRIGGER ON TABLE qwat_ch_aeptc.reservoir TO qwat_viewer;
GRANT ALL ON TABLE qwat_ch_aeptc.reservoir TO qwat_user;
GRANT ALL ON TABLE qwat_ch_aeptc.reservoir TO qwat_manager;
