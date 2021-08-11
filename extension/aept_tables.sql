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
