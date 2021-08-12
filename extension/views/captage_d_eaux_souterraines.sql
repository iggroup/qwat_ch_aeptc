CREATE OR REPLACE VIEW qwat_ch_aeptc.captage_d_eaux_souterraines AS
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
		-- Attributs captages souterrain
		source.qwat_ext_ch_aeptc_souterrain_diametre AS "Diametre",
		type_captage.value_fr AS "Type_de_captage",
		utilisation.value_fr AS "Utilisation",
		flow_concession AS "Debit_de_concession"

	FROM qwat_od.installation installation
	LEFT JOIN qwat_od.source source on installation.id = source.id
	LEFT JOIN qwat_vl.aeptc_type_captage_souterrain type_captage on source.qwat_ext_ch_aeptc_type_captage_souterrain = type_captage.id
	LEFT JOIN qwat_vl.aeptc_oui_non_indet aept on source.qwat_ext_ch_aeptc_approvisionement_crise = aept.id
	LEFT JOIN qwat_vl.aeptc_oui_non_indet traitement on source.qwat_ext_ch_aeptc_traitement = traitement.id
	LEFT JOIN qwat_vl.aeptc_utilisation utilisation on source.qwat_ext_ch_aeptc_utilisation = utilisation.id
	LEFT JOIN qwat_od.node on installation.id = node.id
	LEFT JOIN qwat_od.pressurezone pressurezone on node.fk_pressurezone = pressurezone.id
	WHERE source.fk_source_type = 2702; --captage eau nappe

GRANT SELECT, REFERENCES, TRIGGER ON TABLE qwat_ch_aeptc.captage_d_eaux_souterraines TO qwat_viewer;
GRANT ALL ON TABLE qwat_ch_aeptc.captage_d_eaux_souterraines TO qwat_user;
GRANT ALL ON TABLE qwat_ch_aeptc.captage_d_eaux_souterraines TO qwat_manager;
