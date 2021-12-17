CREATE OR REPLACE VIEW qwat_ch_aeptc.chambre_de_captage AS
	SELECT
		-- AEPT Attributs de base
		COALESCE(network_element.identification, installation.id::character varying) AS "Identificateur",
		installation.name AS "Nom",
		chamber.qwat_ext_ch_aeptc_remarque AS "Remarque",
		pressurezone.name AS "Identificateur_de_la_partie_de_reseau",
		-- Attributs de captages
		COALESCE(traitement.value_fr, 'Indetermine') AS "Traitement",
		st_force2d(node.geometry) AS "Geometrie",
		COALESCE(aept.value_fr, 'Indetermine') AS "Approvisionnement_en_temps_de_crise",
		CASE
			WHEN installation.fk_watertype = 1502 THEN 'Oui'
			ELSE 'Non'
		END AS "Eau_potable",
		-- Attributs chambre de captage
		COALESCE(qwat_ext_ch_aeptc_rendement_min, -1) AS "Rendement_min",
		qwat_ext_ch_aeptc_rendement_moy AS "Rendement_moy",
		qwat_ext_ch_aeptc_rendement_max AS "Rendement_max",
		COALESCE(type_chambre_captage.value_fr, 'Indetermine') AS "Type_de_captage"

	FROM qwat_od.installation installation
	LEFT JOIN qwat_od.chamber chamber on installation.id = chamber.id
	LEFT JOIN qwat_vl.aeptc_oui_non_indet aept on chamber.qwat_ext_ch_aeptc_approvisionement_crise = aept.id
	LEFT JOIN qwat_vl.aeptc_oui_non_indet traitement on chamber.qwat_ext_ch_aeptc_traitement = traitement.id
	LEFT JOIN qwat_vl.aeptc_type_chambre_captage type_chambre_captage on chamber.qwat_ext_ch_aeptc_type_chambre_captage = type_chambre_captage.id
	LEFT JOIN qwat_od.node on installation.id = node.id
	LEFT JOIN qwat_od.network_element network_element on installation.id = network_element.id
	LEFT JOIN qwat_od.pressurezone pressurezone on node.fk_pressurezone = pressurezone.id
	WHERE type_chambre_captage.id IS NOT NULL
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
	
	
GRANT SELECT, REFERENCES, TRIGGER ON TABLE qwat_ch_aeptc.chambre_de_captage TO qwat_viewer;
GRANT ALL ON TABLE qwat_ch_aeptc.chambre_de_captage TO qwat_user;
GRANT ALL ON TABLE qwat_ch_aeptc.chambre_de_captage TO qwat_manager;
