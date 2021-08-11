#!/usr/bin/env bash

# Exit on error
set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

psql service=${PGSERVICE} -v ON_ERROR_STOP=1 -v SRID=$SRID -f ${DIR}/views/autres_installations.sql
psql service=${PGSERVICE} -v ON_ERROR_STOP=1 -v SRID=$SRID -f ${DIR}/views/canalisation.sql
psql service=${PGSERVICE} -v ON_ERROR_STOP=1 -v SRID=$SRID -f ${DIR}/views/captage_d_eaux_de_surface.sql
psql service=${PGSERVICE} -v ON_ERROR_STOP=1 -v SRID=$SRID -f ${DIR}/views/captage_d_eaux_souterraines.sql
psql service=${PGSERVICE} -v ON_ERROR_STOP=1 -v SRID=$SRID -f ${DIR}/views/chambre_de_captage.sql
psql service=${PGSERVICE} -v ON_ERROR_STOP=1 -v SRID=$SRID -f ${DIR}/views/installation_de_transport.sql
psql service=${PGSERVICE} -v ON_ERROR_STOP=1 -v SRID=$SRID -f ${DIR}/views/reservoir.sql
psql service=${PGSERVICE} -v ON_ERROR_STOP=1 -v SRID=$SRID -f ${DIR}/views/source.sql