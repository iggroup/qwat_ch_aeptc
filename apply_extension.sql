CREATE SCHEMA IF NOT EXISTS qwat_ch_aeptc;

-- add new value lists
ALTER TABLE qwat_vl.value_list_base ADD COLUMN short_de varchar(10) ;
ALTER TABLE qwat_vl.value_list_base ADD COLUMN value_de varchar(50) ;
ALTER TABLE qwat_vl.value_list_base ADD COLUMN description_de text ;

-- aeptc_oui_non_indet 
CREATE TABLE qwat_vl.aeptc_oui_non_indet 
(
    CONSTRAINT aeptc_oui_non_indet_pk PRIMARY KEY (id)
)
INHERITS (qwat_vl.value_list_base);
INSERT INTO qwat_vl.aeptc_oui_non_indet (id, value_fr, description_fr, value_de, description_de) VALUES 
(0, 'Oui', 'Oui', 'ja', 'ja'),
(1, 'Non', 'Non', 'nein', 'nein'),
(2, 'Indetermine', 'Indetermine', 'unbestimmt', 'unbestimmt');

-- aeptc_oui_non
CREATE TABLE qwat_vl.aeptc_oui_non
(
    CONSTRAINT aeptc_oui_non_pk PRIMARY KEY (id)
)
INHERITS (qwat_vl.value_list_base);
INSERT INTO qwat_vl.aeptc_oui_non (id, short_fr, value_fr, description_fr, short_de, value_de, description_de) VALUES 
(0,'Oui', 'Oui', 'Oui', 'ja', 'ja', 'ja'),
(1,'Non', 'Non', 'Non', 'nein', 'nein', 'nein');

-- aeptc_utilisation
CREATE TABLE qwat_vl.aeptc_utilisation
(
    CONSTRAINT aeptc_utilisation_pk PRIMARY KEY (id)
)
INHERITS (qwat_vl.value_list_base);
INSERT INTO qwat_vl.aeptc_utilisation (id, value_fr, description_fr, value_de, description_de) VALUES 
(0, 'Utilise', 'Utilise', 'genutzt', 'genutzt'),
(1, 'Pas_utilise', 'Pas_utilise', 'ungenutzt', 'ungenutzt'),
(2, 'Supprime', 'Supprime', 'aufgehoben', 'aufgehoben'),
(3, 'Indetermine', 'Indetermine', 'unbestimmt', 'unbestimmt'); 

-- aeptc_alimentation_electrique_alternative
CREATE TABLE qwat_vl.aeptc_alimentation_electrique_alternative
(
    CONSTRAINT aeptc_alimentation_electrique_alternative_pk PRIMARY KEY (id)
)
INHERITS (qwat_vl.value_list_base);
INSERT INTO qwat_vl.aeptc_alimentation_electrique_alternative (id, value_fr, description_fr, value_de, description_de) VALUES 
(0, 'Pas_d_alimentation_de_secours', 'Pas_d_alimentation_de_secours', 'keine', 'keine'),
(1, 'Generateur', 'Generateur', 'Generator', 'Generator'),
(2, 'Raccordement_de_secours', 'Raccordement_de_secours', 'Notstromanschluss', 'Notstromanschluss'),
(3, 'Autre', 'Autre', 'andere', 'andere');

-- AEPT reservoir
-----------------

-- AEPT Autres_installations
----------------------------
CREATE TABLE qwat_vl.aeptc_puit_type 
(
    CONSTRAINT aeptc_puit_type_pk PRIMARY KEY (id)
)
INHERITS (qwat_vl.value_list_base);
INSERT INTO qwat_vl.aeptc_puit_type (id, value_fr, description_fr, value_de, description_de) VALUES 
(0, 'Puit_eau_potable_raccorde_reseau_canalisation', 'Puit_eau_potable_raccorde_reseau_canalisation', 'Trinkwasserbrunnen_an_Leitungsnetz', 'Trinkwasserbrunnen_an_Leitungsnetz'),
(1, 'Puit_eau_potable_independant', 'Puit_eau_potable_independant', 'Trinkwasserbrunnen_unabhaengig', 'Trinkwasserbrunnen_unabhaengig'),
(2, 'Puit_eau_non_potable_independant', 'Puit_eau_non_potable_independant', 'Brunnen_unabh_o_TWQualitaet', 'Brunnen_unabh_o_TWQualitaet'),
(3, 'Puit_eau_non_determinee_independant', 'Puit_eau_non_determinee_independant', 'Brunnen_unabh_TWQualitaet_unbest', 'Brunnen_unabh_TWQualitaet_unbest'),
(4, 'Puit_decompression', 'Puit_decompression', 'Druckbrecherschacht', 'Druckbrecherschacht');

CREATE TABLE  qwat_ch_aeptc.puit
(
    id integer PRIMARY KEY REFERENCES qwat_od.installation(id),
    fk_type_puit integer references qwat_vl.aeptc_puit_type(id)
);

-- AEPT Sources
---------------
CREATE TABLE qwat_vl.aeptc_captage_type
(
    CONSTRAINT aeptc_captage_type_pk PRIMARY KEY (id)
)
INHERITS (qwat_vl.value_list_base);
INSERT INTO qwat_vl.aeptc_captage_type (id, value_fr, description_fr, value_de, description_de) VALUES 
(0, 'Pas_captee', 'Pas_captee', 'ungefasst', 'ungefasst'),
(1, 'Captee.Direct', 'Captee.Direct', 'gefasst.direkt', 'gefasst.direkt'),
(2, 'Captee.Drain_de_captage', 'Captee.Drain_de_captage', 'gefasst.Fassungsstrang', 'gefasst.Fassungsstrang'),
(3, 'Captee.Galerie_de_captage', 'Captee.Galerie_de_captage', 'gefasst.Fassungsstollen', 'gefasst.Fassungsstollen'), 
(4, 'Captee.Indetermine', 'Captee.Indetermine', 'gefasst.unbestimmt', 'gefasst.unbestimmt');

CREATE TABLE qwat_vl.aeptc_aquifere_type
(
    CONSTRAINT aeptc_aquifere_type_pk PRIMARY KEY (id)
)
INHERITS (qwat_vl.value_list_base);
INSERT INTO qwat_vl.aeptc_aquifere_type (id, value_fr, description_fr, value_de, description_de) VALUES 
(0, 'Roches_meubles', 'Roches_meubles', 'Lockergestein', 'Lockergestein'),
(1, 'Fissure', 'Fissure', 'Kluft', 'Kluft'),
(2, 'Karstique', 'Karstique', 'Karst', 'Karst'),
(3, 'Mixte', 'Mixte', 'gemischt', 'gemischt'), 
(4, 'Indetermine', 'Indetermine', 'unbestimmt', 'unbestimmt');


-- AEPT Captage d'eaux souterraines
-----------------------------------
CREATE TABLE qwat_vl.aeptc_type_captage_souterrain
(
    CONSTRAINT aeptc_type_captage_souterrain_pk PRIMARY KEY (id)
)
INHERITS (qwat_vl.value_list_base);
INSERT INTO qwat_vl.aeptc_type_captage_souterrain (id, value_fr, description_fr, value_de, description_de) VALUES 
(0, 'Puit_forage_filtrant_vertical', 'Puit_forage_filtrant_vertical', 'Vertikalfilterbrunnen', 'Vertikalfilterbrunnen'),
(1, 'Puit_forage_drains_rayonnants', 'Puit_forage_drains_rayonnants', 'Horizontalfilterbrunnen', 'Horizontalfilterbrunnen'),
(2, 'Puit_artisanal', 'Puit_artisanal', 'Sod_Schachtbrunnen',  'Sod_Schachtbrunnen'),
(3, 'Autre', 'Autre', 'andere', 'andere');


-- AEPT Captage d'eaux de surfaces
-- Pas d'ajout d'attributs

-- AEPT Chambre de captage
--------------------------
CREATE TABLE qwat_vl.aeptc_type_chambre_captage
(
    CONSTRAINT aeptc_type_chambre_captage_pk PRIMARY KEY (id)
)
INHERITS (qwat_vl.value_list_base);
INSERT INTO qwat_vl.aeptc_type_chambre_captage (id, value_fr, description_fr, value_de, description_de) VALUES 
(0, 'Chambre_captage', 'Chambre_captage', 'Brunnenstube', 'Brunnenstube'),
(1, 'Puit_de_captage', 'Puit_de_captage', 'Quellschacht', 'Quellschacht'),
(2, 'Puit_collecteur', 'Puit_collecteur', 'Sammelschacht', 'Sammelschacht'),
(3, 'Indetermine', 'Indetermine', 'unbestimmt', 'unbestimmt');

-- AEPT Installations de transport
----------------------------------
CREATE TABLE qwat_vl.aeptc_installation_transport_type
(
    CONSTRAINT aeptc_installation_transport_type_pk PRIMARY KEY (id)
)
INHERITS (qwat_vl.value_list_base);
INSERT INTO qwat_vl.aeptc_installation_transport_type (id, value_fr, description_fr, value_de, description_de) VALUES 
(0, 'Station_de_pompage', 'Station_de_pompage', 'Pumpwerk', 'Pumpwerk'),
(1, 'Pompe_a_etages', 'Pompe_a_etages', 'Stufenpumpwerk', 'Stufenpumpwerk'),
(2, 'Pompe_a_etage_avec_reservoir', 'Pompe_a_etage_avec_reservoir', 'Stufenpumpwerk_mit_Behaelter', 'Stufenpumpwerk_mit_Behaelter'),
(3, 'Station_de_pompage_a_augementation_de_pression', 'Station_de_pompage_a_augementation_de_pression', 'Druckerhoehungspumpwerk', 'Druckerhoehungspumpwerk'),
(4, 'Belier_hydraulique', 'Belier_hydraulique', 'hydraulischer_Widder', 'hydraulischer_Widder'),
(5, 'Siphon', 'Siphon', 'Heberanlage', 'Heberanlage'),
(6, 'Indetermine', 'Indetermine', 'unbestimmt', 'unbestimmt');


-- AEPT reservoir
-----------------
ALTER TABLE qwat_od.tank ADD COLUMN qwat_ext_ch_aeptc_alimentation_electrique_de_secours integer references qwat_vl.aeptc_alimentation_electrique_alternative(id);
-- attributs communs aux installations QWAT
ALTER TABLE qwat_od.tank ADD COLUMN qwat_ext_ch_aeptc_traitement integer references qwat_vl.aeptc_oui_non_indet(id);
ALTER TABLE qwat_od.tank ADD COLUMN qwat_ext_ch_aeptc_remarque varchar(1000);
ALTER TABLE qwat_od.tank ADD COLUMN qwat_ext_ch_aeptc_identificateur_de_la_partie_de_reseau varchar(50);

-- AEPT Autres_installations
----------------------------

-- attributs communs aux installations QWAT
ALTER TABLE qwat_ch_aeptc.puit ADD COLUMN qwat_ext_ch_aeptc_traitement integer references qwat_vl.aeptc_oui_non_indet(id);
ALTER TABLE qwat_ch_aeptc.puit ADD COLUMN qwat_ext_ch_aeptc_remarque varchar(1000);
ALTER TABLE qwat_ch_aeptc.puit ADD COLUMN qwat_ext_ch_aeptc_identificateur_de_la_partie_de_reseau varchar(50);

ALTER TABLE qwat_od.pressurecontrol ADD COLUMN qwat_ext_ch_aeptc_traitement integer references qwat_vl.aeptc_oui_non_indet(id);
ALTER TABLE qwat_od.pressurecontrol ADD COLUMN qwat_ext_ch_aeptc_remarque varchar(1000);
ALTER TABLE qwat_od.pressurecontrol ADD COLUMN qwat_ext_ch_aeptc_identificateur_de_la_partie_de_reseau varchar(50);

-- AEPT Sources
---------------
ALTER TABLE qwat_od.source ADD COLUMN qwat_ext_ch_aeptc_type_captage integer REFERENCES qwat_vl.aeptc_captage_type(id);
ALTER TABLE qwat_od.source ADD COLUMN qwat_ext_ch_aeptc_type_aquifere integer REFERENCES qwat_vl.aeptc_aquifere_type(id);
ALTER TABLE qwat_od.source ADD COLUMN qwat_ext_ch_aeptc_approvisionement_crise integer REFERENCES qwat_vl.aeptc_oui_non_indet(id);
ALTER TABLE qwat_od.source ADD COLUMN qwat_ext_ch_aeptc_utilisation integer REFERENCES qwat_vl.aeptc_utilisation(id);
ALTER TABLE qwat_od.source ADD COLUMN qwat_ext_ch_aeptc_interet_public integer REFERENCES qwat_vl.aeptc_oui_non_indet(id);
ALTER TABLE qwat_od.source ADD COLUMN qwat_ext_ch_aeptc_type_source varchar(255);
ALTER TABLE qwat_od.source ADD COLUMN qwat_ext_ch_aeptc_debit_max real;
-- attributs communs aux installations QWAT
ALTER TABLE qwat_od.source ADD COLUMN qwat_ext_ch_aeptc_traitement integer references qwat_vl.aeptc_oui_non_indet(id);
ALTER TABLE qwat_od.source ADD COLUMN qwat_ext_ch_aeptc_remarque varchar(1000);
ALTER TABLE qwat_od.source ADD COLUMN qwat_ext_ch_aeptc_identificateur_de_la_partie_de_reseau varchar(50);

-- AEPT Captage d'eaux souterraines
-----------------------------------
ALTER TABLE qwat_od.source ADD COLUMN qwat_ext_ch_aeptc_souterrain_diametre integer;
ALTER TABLE qwat_od.source ADD COLUMN qwat_ext_ch_aeptc_type_captage_souterrain integer REFERENCES qwat_vl.aeptc_type_captage_souterrain(id);


-- AEPT Captage d'eaux de surfaces
-- Pas d'ajout d'attributs

-- AEPT Chambre de captage
--------------------------

ALTER TABLE qwat_od.chamber ADD COLUMN qwat_ext_ch_aeptc_approvisionement_crise integer REFERENCES qwat_vl.aeptc_oui_non_indet(id);
ALTER TABLE qwat_od.chamber ADD COLUMN qwat_ext_ch_aeptc_rendement_min real;
ALTER TABLE qwat_od.chamber ADD COLUMN qwat_ext_ch_aeptc_rendement_moy real;
ALTER TABLE qwat_od.chamber ADD COLUMN qwat_ext_ch_aeptc_rendement_max real;
ALTER TABLE qwat_od.chamber ADD COLUMN qwat_ext_ch_aeptc_type_chambre_captage integer references qwat_vl.aeptc_type_chambre_captage(id);
-- attributs communs aux installations QWAT
ALTER TABLE qwat_od.chamber ADD COLUMN qwat_ext_ch_aeptc_traitement integer references qwat_vl.aeptc_oui_non_indet(id);
ALTER TABLE qwat_od.chamber ADD COLUMN qwat_ext_ch_aeptc_remarque varchar(1000);
ALTER TABLE qwat_od.chamber ADD COLUMN qwat_ext_ch_aeptc_identificateur_de_la_partie_de_reseau varchar(50);

-- AEPT Installations de transport
----------------------------------
ALTER TABLE qwat_od.pump ADD COLUMN qwat_ext_ch_aeptc_alimentation_electrique_de_secours integer references qwat_vl.aeptc_alimentation_electrique_alternative(id);
ALTER TABLE qwat_od.pump ADD COLUMN qwat_ext_ch_type_installation_transport integer REFERENCES qwat_vl.aeptc_installation_transport_type(id);
ALTER TABLE qwat_od.pump ADD COLUMN qwat_ext_ch_aeptc_puissance_continue real;
ALTER TABLE qwat_od.pump ADD COLUMN qwat_ext_ch_aeptc_puissance_max real;
ALTER TABLE qwat_od.pump ADD COLUMN qwat_ext_ch_aeptc_descriptif_pompe varchar(255);
-- attributs communs aux installations QWAT
ALTER TABLE qwat_od.pump ADD COLUMN qwat_ext_ch_aeptc_traitement integer references qwat_vl.aeptc_oui_non_indet(id);
ALTER TABLE qwat_od.pump ADD COLUMN qwat_ext_ch_aeptc_remarque varchar(1000);
ALTER TABLE qwat_od.pump ADD COLUMN qwat_ext_ch_aeptc_identificateur_de_la_partie_de_reseau varchar(50);


-- AEPT canalisation
ALTER TABLE qwat_od.pipe ADD COLUMN qwat_ext_ch_aeptc_identificateur_de_la_partie_de_reseau varchar(50);

CREATE OR REPLACE VIEW qwat_ch_aeptc.autres_installations AS

	-- Chambres
	SELECT
		-- AEPT Attributs de base
		node.id AS "Identificateur",
		name AS "Nom",
		chamber.qwat_ext_ch_aeptc_remarque AS "Remarque",
		chamber.qwat_ext_ch_aeptc_identificateur_de_la_partie_de_reseau AS "Identificateur_de_la_partie_de_reseau",
		node.fk_pressurezone AS "Nom_Zone_Pression",
		-- autres_installations
		'Chambre_vanne' AS "Type",
		traitement.value_fr AS "Traitement",
		st_force2d(node.geometry) AS "Geometrie"
	FROM qwat_od.installation
	LEFT JOIN qwat_od.chamber chamber on installation.id = chamber.id
	LEFT JOIN qwat_vl.aeptc_oui_non_indet traitement on chamber.qwat_ext_ch_aeptc_traitement = traitement.id
	LEFT JOIN qwat_od.node on installation.id = node.id
	WHERE chamber.id IS NOT NULL AND chamber.qwat_ext_ch_aeptc_type_chambre_captage IS NULL

	UNION

	-- Puits
	SELECT
		-- AEPT Attributs de base
		node.id AS "Identificateur",
		name AS "Nom",
		puit.qwat_ext_ch_aeptc_remarque AS "Remarque",
		puit.qwat_ext_ch_aeptc_identificateur_de_la_partie_de_reseau AS "Identificateur_de_la_partie_de_reseau",
		node.fk_pressurezone AS "Nom_Zone_Pression",
		-- autres_installations
		puit_type.value_fr AS "Type",
		traitement.value_fr AS "Traitement",
		st_force2d(node.geometry) AS "Geometrie"
	FROM qwat_od.installation
	LEFT JOIN qwat_ch_aeptc.puit puit on installation.id = puit.id
	LEFT JOIN qwat_vl.aeptc_puit_type puit_type on puit.fk_type_puit = puit_type.id
	LEFT JOIN qwat_vl.aeptc_oui_non traitement on puit.qwat_ext_ch_aeptc_traitement = traitement.id
	LEFT JOIN qwat_od.node on installation.id = node.id
	WHERE puit.id IS NOT NULL

	UNION

	-- Soupape_regulation_pression
	SELECT
		-- AEPT Attributs de base
		node.id AS "Identificateur",
		name AS "Nom",
		pressurecontrol.qwat_ext_ch_aeptc_remarque AS "Remarque",
		pressurecontrol.qwat_ext_ch_aeptc_identificateur_de_la_partie_de_reseau AS "Identificateur_de_la_partie_de_reseau",
		node.fk_pressurezone AS "Nom_Zone_Pression",
		-- autres_installations
		'Soupape_regulation_pression' AS "Type",
		traitement.value_fr AS "Traitement",
		st_force2d(node.geometry) AS "Geometrie"
	FROM qwat_od.installation
	LEFT JOIN qwat_od.pressurecontrol pressurecontrol on installation.id = pressurecontrol.id
	LEFT JOIN qwat_vl.aeptc_oui_non traitement on pressurecontrol.qwat_ext_ch_aeptc_traitement = traitement.id
	LEFT JOIN qwat_od.node on installation.id = node.id
	WHERE pressurecontrol.fk_pressurecontrol_type IN (2801, 2802);

GRANT SELECT, REFERENCES, TRIGGER ON TABLE qwat_ch_aeptc.autres_installations TO qwat_viewer;
GRANT ALL ON TABLE qwat_ch_aeptc.autres_installations TO qwat_user;
GRANT ALL ON TABLE qwat_ch_aeptc.autres_installations TO qwat_manager;


CREATE OR REPLACE VIEW qwat_ch_aeptc.canalisation AS
	SELECT
		--  AEPT Attributs de base
		pipe.id AS "Identificateur",
		pipe.id AS "Nom",
		remark AS "Remarque",
		pipe.qwat_ext_ch_aeptc_identificateur_de_la_partie_de_reseau AS "Identificateur_de_la_partie_de_reseau",
		pipe.fk_pressurezone  AS "Nom_Zone_Pression",
		--  Attributs de Canalisation
		st_force2d(geometry) AS "Geometrie",
		CASE
			WHEN pipe_material.diameter_nominal IS NOT NULL THEN pipe_material.diameter_nominal
			ELSE -1
		END AS "Largeur_nominale" --  en mm
	FROM qwat_od.pipe pipe
	LEFT JOIN qwat_vl.pipe_material pipe_material on pipe.fk_material = pipe_material.id
	WHERE fk_function IN (
		--101,-- "autre"
		--102,--  "inconnu"
		--103,--  "à déterminer"
		4101,--  "Conduite de transport"
		--4102,--  "Conduite d'hydrant"
		--4103,--  "Conduite de vidange"
		4104,--  "Conduite d'adduction"
		4105,--  "Conduite de distribution"
		--4106,--  "Branchement commun"
		4107,--  "By-pass"
		--4108,--  "Branchement privé"
		4109,--  "Conduite de haute pression"
		4110--  "Drain captant"
		--4111,--  "Trop plein"
		--4112,--  "Ventilation"
	) AND fk_status IN (
		--101, -- "autre"
		--102, -- "inconnu"
		--103, -- "à déterminer"
		1301 -- "en service"
		--1302, -- "hors service"
		--1303, -- "désaffecté"
		--1304, -- "abandonné"
		--1305, -- "détruit"
		--1306, -- "projet"
		--1307, -- "fictif"
	);

GRANT SELECT, REFERENCES, TRIGGER ON TABLE qwat_ch_aeptc.canalisation TO qwat_viewer;
GRANT ALL ON TABLE qwat_ch_aeptc.canalisation TO qwat_user;
GRANT ALL ON TABLE qwat_ch_aeptc.canalisation TO qwat_manager;

CREATE OR REPLACE VIEW qwat_ch_aeptc.captage_d_eaux_de_surface AS
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
	WHERE source.fk_source_type = 2701 --captage lac
	OR source.fk_source_type = 2704; --captage cours eau

GRANT SELECT, REFERENCES, TRIGGER ON TABLE qwat_ch_aeptc.captage_d_eaux_de_surface TO qwat_viewer;
GRANT ALL ON TABLE qwat_ch_aeptc.captage_d_eaux_de_surface TO qwat_user;
GRANT ALL ON TABLE qwat_ch_aeptc.captage_d_eaux_de_surface TO qwat_manager;


CREATE OR REPLACE VIEW qwat_ch_aeptc.captage_d_eaux_souterraines AS
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
	WHERE source.fk_source_type = 2702 --captage eau nappe

GRANT SELECT, REFERENCES, TRIGGER ON TABLE qwat_ch_aeptc.captage_d_eaux_souterraines TO qwat_viewer;
GRANT ALL ON TABLE qwat_ch_aeptc.captage_d_eaux_souterraines TO qwat_user;
GRANT ALL ON TABLE qwat_ch_aeptc.captage_d_eaux_souterraines TO qwat_manager;

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
	
GRANT SELECT, REFERENCES, TRIGGER ON TABLE qwat_ch_aeptc.chambre_de_captage TO qwat_viewer;
GRANT ALL ON TABLE qwat_ch_aeptc.chambre_de_captage TO qwat_user;
GRANT ALL ON TABLE qwat_ch_aeptc.chambre_de_captage TO qwat_manager;


CREATE OR REPLACE VIEW qwat_ch_aeptc.installation_de_transport AS
	SELECT
		-- AEPT Attributs de base
		installation.id AS "Identificateur",
		name AS "Nom",
		installation_transport.qwat_ext_ch_aeptc_remarque AS "Remarque",
		installation_transport.qwat_ext_ch_aeptc_identificateur_de_la_partie_de_reseau AS "Identificateur_de_la_partie_de_reseau",
		node.fk_pressurezone AS "Nom_Zone_Pression",
		-- Attributs de Installation_de_transport
		alimentation.value_fr AS "Alimentation_electrique_de_secours",
		type.value_fr AS "Type",
		traitement.value_fr AS "Traitement",
		qwat_ext_ch_aeptc_puissance_continue AS "Puissance_continue",
		rejected_flow AS "Volume_transporte",
		st_force2d(node.geometry) AS "Geometrie",
		qwat_ext_ch_aeptc_puissance_max AS "Puissance_max",
		no_pumps AS "Nbre_de_pompes",
		qwat_ext_ch_aeptc_descriptif_pompe AS "Descriptif_pompe"
	FROM qwat_od.installation installation
	LEFT JOIN qwat_od.pump installation_transport on installation.id = installation_transport.id
	LEFT JOIN qwat_vl.aeptc_alimentation_electrique_alternative alimentation on installation_transport.qwat_ext_ch_aeptc_alimentation_electrique_de_secours = alimentation.id
	LEFT JOIN qwat_vl.aeptc_installation_transport_type type on installation_transport.qwat_ext_ch_type_installation_transport = type.id
	LEFT JOIN qwat_vl.aeptc_oui_non traitement on installation_transport.qwat_ext_ch_aeptc_traitement = traitement.id
	LEFT JOIN qwat_od.node on installation.id = node.id
	WHERE installation_transport.id IS NOT NULL;

GRANT SELECT, REFERENCES, TRIGGER ON TABLE qwat_ch_aeptc.installation_de_transport TO qwat_viewer;
GRANT ALL ON TABLE qwat_ch_aeptc.installation_de_transport TO qwat_user;
GRANT ALL ON TABLE qwat_ch_aeptc.installation_de_transport TO qwat_manager;

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
	LEFT JOIN qwat_vl.aeptc_oui_non traitement on tank.qwat_ext_ch_aeptc_traitement = traitement.id
	LEFT JOIN qwat_od.node on installation.id = node.id
	WHERE tank.id IS NOT NULL;
	
GRANT SELECT, REFERENCES, TRIGGER ON TABLE qwat_ch_aeptc.reservoir TO qwat_viewer;
GRANT ALL ON TABLE qwat_ch_aeptc.reservoir TO qwat_user;
GRANT ALL ON TABLE qwat_ch_aeptc.reservoir TO qwat_manager;

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
