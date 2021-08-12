CREATE OR REPLACE VIEW qwat_ch_aeptc.installation_de_transport AS
	SELECT
		-- AEPT Attributs de base
		installation.id AS "Identificateur",
		installation.name AS "Nom",
		installation_transport.qwat_ext_ch_aeptc_remarque AS "Remarque",
		pressurezone.name AS "Identificateur_de_la_partie_de_reseau",
		-- Attributs de Installation_de_transport
		alimentation.value_fr AS "Alimentation_electrique_de_secours",
		type.value_fr AS "Type",
		traitement.value_fr AS "Traitement",
		qwat_ext_ch_aeptc_puissance_continue AS "Puissance_continue",
		CASE 
			WHEN rejected_flow IS NULL THEN -1 
			ELSE -rejected_flow 
		END AS "Volume_transporte",
		st_force2d(node.geometry) AS "Geometrie",
		qwat_ext_ch_aeptc_puissance_max AS "Puissance_max",
		no_pumps AS "Nbre_de_pompes",
		qwat_ext_ch_aeptc_descriptif_pompe AS "Descriptif_pompe"
	FROM qwat_od.installation installation
	LEFT JOIN qwat_od.pump installation_transport on installation.id = installation_transport.id
	LEFT JOIN qwat_vl.aeptc_alimentation_electrique_alternative alimentation on installation_transport.qwat_ext_ch_aeptc_alimentation_electrique_de_secours = alimentation.id
	LEFT JOIN qwat_vl.aeptc_installation_transport_type type on installation_transport.qwat_ext_ch_type_installation_transport = type.id
	LEFT JOIN qwat_vl.aeptc_oui_non_indet traitement on installation_transport.qwat_ext_ch_aeptc_traitement = traitement.id
	LEFT JOIN qwat_od.node on installation.id = node.id
	LEFT JOIN qwat_od.pressurezone pressurezone on node.fk_pressurezone = pressurezone.id
	WHERE installation_transport.id IS NOT NULL;

GRANT SELECT, REFERENCES, TRIGGER ON TABLE qwat_ch_aeptc.installation_de_transport TO qwat_viewer;
GRANT ALL ON TABLE qwat_ch_aeptc.installation_de_transport TO qwat_user;
GRANT ALL ON TABLE qwat_ch_aeptc.installation_de_transport TO qwat_manager;
