CREATE OR REPLACE VIEW qwat_ch_aeptc.chambre_de_captage AS
	SELECT
		-- AEPT Attributs de base
		installation.id AS "Identificateur",
		name AS "Nom",
		chamber.qwat_ext_ch_aeptc_remarque AS "Remarque",
		chamber.qwat_ext_ch_aeptc_identificateur_de_la_partie_de_reseau AS "Identificateur_de_la_partie_de_reseau",
		node.fk_pressurezone AS "Nom_Zone_Pression",
		-- Attributs de captages
		traitement.value_fr AS "Traitement",
		st_force2d(node.geometry) AS "Geometrie",
		aept.value_fr AS "Approvisionnement_en_temps_de_crise",
		CASE
			WHEN installation.fk_watertype = 1502 THEN 'Oui'
			ELSE 'Non'
		END AS "Eau_potable",
		-- Attributs chambre de captage
		qwat_ext_ch_aeptc_rendement_min AS "Rendement_min",
		qwat_ext_ch_aeptc_rendement_moy AS "Rendement_moy",
		qwat_ext_ch_aeptc_rendement_max AS "Rendement_max",
		type_chambre_captage.value_fr AS "Type_de_captage"

	FROM qwat_od.installation installation
	LEFT JOIN qwat_od.chamber chamber on installation.id = chamber.id
	LEFT JOIN qwat_vl.aeptc_oui_non_indet aept on chamber.qwat_ext_ch_aeptc_approvisionement_crise = aept.id
	LEFT JOIN qwat_vl.aeptc_oui_non_indet traitement on chamber.qwat_ext_ch_aeptc_traitement = traitement.id
	LEFT JOIN qwat_vl.aeptc_type_chambre_captage type_chambre_captage on chamber.qwat_ext_ch_aeptc_type_chambre_captage = type_chambre_captage.id
	LEFT JOIN qwat_od.node on installation.id = node.id
	WHERE type_chambre_captage.id IS NOT NULL
	
	UNION
	
	SELECT
		-- AEPT Attributs de base
		installation.id AS "Identificateur",
		name AS "Nom",
		source.qwat_ext_ch_aeptc_remarque AS "Remarque",
		source.qwat_ext_ch_aeptc_identificateur_de_la_partie_de_reseau AS "Identificateur_de_la_partie_de_reseau",
		node.fk_pressurezone AS "Nom_Zone_Pression",
		-- Attributs de captages
		traitement.value_fr AS "Traitement",
		st_force2d(node.geometry) AS "Geometrie",
		aept.value_fr AS "Approvisionnement_en_temps_de_crise",
		CASE
			WHEN installation.fk_watertype = 1502 THEN 'Oui'
			ELSE 'Non'
		END AS "Eau_potable",
		-- Attributs chambre de captage
		flow_lowest AS "Rendement_min",
		flow_average AS "Rendement_moy",
		qwat_ext_ch_aeptc_debit_max AS "Rendement_max",
		'Chambre_captage' AS "Type_de_captage"

	FROM qwat_od.installation installation
	LEFT JOIN qwat_od.source source on installation.id = source.id
	LEFT JOIN qwat_vl.aeptc_oui_non_indet aept on source.qwat_ext_ch_aeptc_approvisionement_crise = aept.id
	LEFT JOIN qwat_vl.aeptc_oui_non_indet traitement on source.qwat_ext_ch_aeptc_traitement = traitement.id
	LEFT JOIN qwat_od.node on installation.id = node.id
	WHERE source.id IS NOT NULL and fk_source_type = 2703; -- captage eau source 
	
GRANT SELECT, REFERENCES, TRIGGER ON TABLE qwat_ch_aeptc.chambre_de_captage TO qwat_viewer;
GRANT ALL ON TABLE qwat_ch_aeptc.chambre_de_captage TO qwat_user;
GRANT ALL ON TABLE qwat_ch_aeptc.chambre_de_captage TO qwat_manager;
