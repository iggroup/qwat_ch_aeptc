CREATE OR REPLACE VIEW qwat_ch_aeptc.reservoir AS
	SELECT
		-- AEPT Attributs de base
		installation.id AS "Identificateur",
		name AS "Nom",
		tank.qwat_ext_ch_aeptc_remarque AS "Remarque",
		tank.qwat_ext_ch_aeptc_identificateur_de_la_partie_de_reseau AS "Identificateur_de_la_partie_de_reseau",
		node.fk_pressurezone AS "Nom_Zone_Pression",
		-- Attributs de Reservoir
		alimentation.value_fr AS "Alimentation_electrique_de_secours",
		traitement.value_fr AS "Traitement",
		storage_supply AS "Reserve_d_utilisation",
		st_force2d(node.geometry) AS "Geometrie",
		storage_fire AS "Reserve_d_extinction",
		altitude_overflow AS "Niveau_max_de_la_surface_de_l_eau"
	FROM qwat_od.installation installation
	LEFT JOIN qwat_od.tank tank on installation.id = tank.id
	LEFT JOIN qwat_vl.aeptc_alimentation_electrique_alternative alimentation on tank.qwat_ext_ch_aeptc_alimentation_electrique_de_secours = alimentation.id
	LEFT JOIN qwat_vl.aeptc_oui_non_indet traitement on tank.qwat_ext_ch_aeptc_traitement = traitement.id
	LEFT JOIN qwat_od.node on installation.id = node.id
	WHERE tank.id IS NOT NULL;
	
GRANT SELECT, REFERENCES, TRIGGER ON TABLE qwat_ch_aeptc.reservoir TO qwat_viewer;
GRANT ALL ON TABLE qwat_ch_aeptc.reservoir TO qwat_user;
GRANT ALL ON TABLE qwat_ch_aeptc.reservoir TO qwat_manager;
