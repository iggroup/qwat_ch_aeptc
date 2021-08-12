CREATE OR REPLACE VIEW qwat_ch_aeptc.captage_d_eaux_de_surface AS
	SELECT
		-- AEPT Attributs de base
		installation.id AS "Identificateur",
		installation.name AS "Nom",
		source.qwat_ext_ch_aeptc_remarque AS "Remarque",
		pressurezone.name AS "Identificateur_de_la_partie_de_reseau",
		-- Attributs de captages
		traitement.value_fr AS "Traitement",
		st_force2d(node.geometry) AS "Geometrie",
		aept.value_fr AS "Approvisionnement_en_temps_de_crise",
		CASE
			WHEN installation.fk_watertype = 1502 THEN 'Oui'
			ELSE 'Non'
		END AS "Eau_potable",
		-- Attributs captages surface
		CASE
			WHEN source.fk_source_type = 2701 THEN 'Captage_lac'
			WHEN source.fk_source_type = 2704 THEN 'Captage_cours_d_eau'
		END AS "Type_de_captage",
		utilistation.value_fr AS "Utilisation",
		flow_concession AS "Debit_de_concession"

	FROM qwat_od.installation installation
	LEFT JOIN qwat_od.source source on installation.id = source.id
	LEFT JOIN qwat_vl.aeptc_oui_non_indet aept on source.qwat_ext_ch_aeptc_approvisionement_crise = aept.id
	LEFT JOIN qwat_vl.aeptc_oui_non_indet traitement on source.qwat_ext_ch_aeptc_traitement = traitement.id
	LEFT JOIN qwat_vl.aeptc_utilisation utilistation on source.qwat_ext_ch_aeptc_utilisation = utilistation.id
	LEFT JOIN qwat_od.node on installation.id = node.id
	LEFT JOIN qwat_od.pressurezone pressurezone on node.fk_pressurezone = pressurezone.id
	WHERE source.fk_source_type = 2701 --captage lac
	OR source.fk_source_type = 2704; --captage cours eau

GRANT SELECT, REFERENCES, TRIGGER ON TABLE qwat_ch_aeptc.captage_d_eaux_de_surface TO qwat_viewer;
GRANT ALL ON TABLE qwat_ch_aeptc.captage_d_eaux_de_surface TO qwat_user;
GRANT ALL ON TABLE qwat_ch_aeptc.captage_d_eaux_de_surface TO qwat_manager;
