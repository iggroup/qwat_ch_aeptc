CREATE OR REPLACE VIEW qwat_ch_aeptc.source AS
	SELECT
		-- AEPT Attributs de base
		installation.id AS "Identificateur",
		installation.name AS "Nom",
		source.qwat_ext_ch_aeptc_remarque AS "Remarque",
		pressurezone.name AS "Identificateur_de_la_partie_de_reseau",
		-- sources
		COALESCE(type_captage.value_fr, 'Captee.Indetermine') AS "Type_de_captage",
		COALESCE(type_aquifere.value_fr, 'Indetermine') AS "Type_d_aquifere",
		CASE
			WHEN type_captage.value_fr = 'Pas_captee' THEN NULL
			ELSE aept.value_fr 
		END AS "Approvisionnement_en_temps_de_crise",
		CASE 
			WHEN type_captage.value_fr = 'Pas_captee' THEN NULL
			ELSE utilisation.value_fr 
		END AS "Utilisation",
		CASE
			WHEN type_captage.value_fr = 'Pas_captee' THEN NULL
			ELSE interet_public.value_fr 
		END AS "Interet_public",
		qwat_ext_ch_aeptc_type_source AS "Type_de_source", --type de source considéré (exsurgence, puits artésien, etc.) ou son mode de fonctionnement (source pérenne,intermittente, périodique, etc.).
		COALESCE(flow_lowest, -1) AS "Debit_min",
		flow_average  AS "Debit_moy",
		qwat_ext_ch_aeptc_debit_max AS "Debit_max",
		CASE
			WHEN type_captage.value_fr = 'Pas_captee' THEN NULL
			ELSE 
				CASE 
					WHEN installation.fk_watertype = 1502 THEN 'Oui'
					ELSE 'Non'
				END
		END AS "Eau_potable",
		CASE
			WHEN type_captage.value_fr = 'Pas_captee' THEN NULL
			ELSE watertype.value_fr 
		END AS "Utilisation_visee", -- eau potable, eau d’usage industriel, arrosage, utilisation thermique, etc.
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
	LEFT JOIN qwat_od.network_element network_element on installation.id = network_element.id
	LEFT JOIN qwat_od.pressurezone pressurezone on node.fk_pressurezone = pressurezone.id
	WHERE source.id IS NOT NULL
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
	);

GRANT SELECT, REFERENCES, TRIGGER ON TABLE qwat_ch_aeptc.source TO qwat_viewer;
GRANT ALL ON TABLE qwat_ch_aeptc.source TO qwat_user;
GRANT ALL ON TABLE qwat_ch_aeptc.source TO qwat_manager;
