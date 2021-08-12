CREATE OR REPLACE VIEW qwat_ch_aeptc.reservoir AS
	SELECT
		-- AEPT Attributs de base
		installation.id AS "Identificateur",
		installation.name AS "Nom",
		tank.qwat_ext_ch_aeptc_remarque AS "Remarque",
		pressurezone.name AS "Identificateur_de_la_partie_de_reseau",
		-- Attributs de Reservoir
		alimentation.value_fr AS "Alimentation_electrique_de_secours",
		traitement.value_fr AS "Traitement",
		CASE 
			WHEN storage_supply IS NULL THEN -1 
			ELSE storage_supply
		END AS "Reserve_d_utilisation",
		st_force2d(node.geometry) AS "Geometrie",
		CASE 
			WHEN storage_fire IS NULL THEN -1
			ELSE storage_fire
		END AS "Reserve_d_extinction",
		CASE 
			WHEN altitude_overflow IS NULL THEN -1
			ELSE altitude_overflow
		END AS "Niveau_max_de_la_surface_de_l_eau"
	FROM qwat_od.installation installation
	LEFT JOIN qwat_od.tank tank on installation.id = tank.id
	LEFT JOIN qwat_vl.aeptc_alimentation_electrique_alternative alimentation on tank.qwat_ext_ch_aeptc_alimentation_electrique_de_secours = alimentation.id
	LEFT JOIN qwat_vl.aeptc_oui_non_indet traitement on tank.qwat_ext_ch_aeptc_traitement = traitement.id
	LEFT JOIN qwat_od.node on installation.id = node.id
	LEFT JOIN qwat_od.pressurezone pressurezone on node.fk_pressurezone = pressurezone.id
	WHERE tank.id IS NOT NULL;
	
GRANT SELECT, REFERENCES, TRIGGER ON TABLE qwat_ch_aeptc.reservoir TO qwat_viewer;
GRANT ALL ON TABLE qwat_ch_aeptc.reservoir TO qwat_user;
GRANT ALL ON TABLE qwat_ch_aeptc.reservoir TO qwat_manager;
