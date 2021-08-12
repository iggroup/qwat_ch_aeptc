CREATE OR REPLACE VIEW qwat_ch_aeptc.canalisation AS
	SELECT
		--  AEPT Attributs de base
		pipe.id AS "Identificateur",
		pipe.id AS "Nom",
		remark AS "Remarque",
		pressurezone.name AS "Identificateur_de_la_partie_de_reseau",
		--  Attributs de Canalisation
		st_force2d(pipe.geometry) AS "Geometrie",
		CASE
			WHEN pipe_material.diameter_nominal IS NOT NULL THEN pipe_material.diameter_nominal
			ELSE -1
		END AS "Largeur_nominale" --  en mm
	FROM qwat_od.pipe pipe
	LEFT JOIN qwat_vl.pipe_material pipe_material on pipe.fk_material = pipe_material.id
	LEFT JOIN qwat_od.pressurezone pressurezone on pipe.fk_pressurezone = pressurezone.id
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
