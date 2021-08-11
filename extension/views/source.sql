CREATE OR REPLACE VIEW qwat_ch_aeptc.source AS
	SELECT
		-- AEPT Attributs de base
		installation.id AS "Identificateur",
		name AS "Nom",
		source.qwat_ext_ch_aeptc_remarque AS "Remarque",
		source.qwat_ext_ch_aeptc_identificateur_de_la_partie_de_reseau AS "Identificateur_de_la_partie_de_reseau",
		node.fk_pressurezone AS "Nom_Zone_Pression",
		-- sources
		type_captage.value_fr AS "Type_de_captage",
		type_aquifere.value_fr AS "Type_d_aquifere",
		aept.value_fr AS "Approvisionnement_en_temps_de_crise",
		utilisation.value_fr AS "Utilisation",
		interet_public.value_fr AS "Interet_public",
		qwat_ext_ch_aeptc_type_source AS "Type_de_source", --type de source considéré (exsurgence, puits artésien, etc.) ou son mode de fonctionnement (source pérenne,intermittente, périodique, etc.).
		flow_lowest AS "Debit_min",
		flow_average AS "Debit_moy",
		qwat_ext_ch_aeptc_debit_max AS "Debit_max",
		CASE
			WHEN installation.fk_watertype = 1502 THEN 'Oui'
			ELSE 'Non'
		END AS "Eau_potable",
		watertype.value_fr AS "Utilisation_visee", -- eau potable, eau d’usage industriel, arrosage, utilisation thermique, etc.
		st_force2d(node.geometry) AS "Geometrie"
	FROM qwat_od.installation installation
	LEFT JOIN qwat_od.source source on installation.id = source.id
	LEFT JOIN qwat_vl.aeptc_captage_type type_captage on source.qwat_ext_ch_aeptc_type_captage = type_captage.id
	LEFT JOIN qwat_vl.aeptc_aquifere_type type_aquifere on source.qwat_ext_ch_aeptc_type_aquifere = type_aquifere.id
	LEFT JOIN qwat_vl.aeptc_oui_non_indet aept on source.qwat_ext_ch_aeptc_approvisionement_crise = aept.id
	LEFT JOIN qwat_vl.aeptc_utilisation utilisation on source.qwat_ext_ch_aeptc_utilisation = utilisation.id
	LEFT JOIN qwat_vl.aeptc_oui_non_indet interet_public on source.qwat_ext_ch_aeptc_interet_public = interet_public.id
	LEFT JOIN qwat_vl.watertype watertype ON installation.fk_watertype = watertype.id
	LEFT JOIN qwat_od.node on installation.id = node.id
	WHERE source.id IS NOT NULL;

GRANT SELECT, REFERENCES, TRIGGER ON TABLE qwat_ch_aeptc.source TO qwat_viewer;
GRANT ALL ON TABLE qwat_ch_aeptc.source TO qwat_user;
GRANT ALL ON TABLE qwat_ch_aeptc.source TO qwat_manager;
