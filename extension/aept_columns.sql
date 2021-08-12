
-- AEPT reservoir
-----------------
ALTER TABLE qwat_od.tank ADD COLUMN qwat_ext_ch_aeptc_alimentation_electrique_de_secours integer references qwat_vl.aeptc_alimentation_electrique_alternative(id);
-- attributs communs aux installations QWAT
ALTER TABLE qwat_od.tank ADD COLUMN qwat_ext_ch_aeptc_traitement integer references qwat_vl.aeptc_oui_non_indet(id);
ALTER TABLE qwat_od.tank ADD COLUMN qwat_ext_ch_aeptc_remarque varchar(1000);

-- AEPT Autres_installations
----------------------------

-- attributs communs aux installations QWAT
ALTER TABLE qwat_ch_aeptc.puit ADD COLUMN qwat_ext_ch_aeptc_traitement integer references qwat_vl.aeptc_oui_non_indet(id);
ALTER TABLE qwat_ch_aeptc.puit ADD COLUMN qwat_ext_ch_aeptc_remarque varchar(1000);

ALTER TABLE qwat_od.pressurecontrol ADD COLUMN qwat_ext_ch_aeptc_traitement integer references qwat_vl.aeptc_oui_non_indet(id);
ALTER TABLE qwat_od.pressurecontrol ADD COLUMN qwat_ext_ch_aeptc_remarque varchar(1000);

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