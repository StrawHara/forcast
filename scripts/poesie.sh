\#!/bin/sh

### Project-specific variables ###
PROJ_DIR=$(dirname $0)/../Forcast
LOCALIZABLE_EN="$PROJ_DIR/Resources/Base.lproj/Localizable.strings"
LOCALIZABLE_FR="$PROJ_DIR/Resources/fr.lproj/Localizable.strings"

# Fill the following with values from https://poeditor.com/account/api
API_TOKEN="0a95bbf3d117e071bfadded8b0863701"
PROJECT_ID="218001"

### Run the Scripts ###

poesie -t "$API_TOKEN" -p "$PROJECT_ID" -l fr -i "$LOCALIZABLE_FR"
poesie -t "$API_TOKEN" -p "$PROJECT_ID" -l en -i "$LOCALIZABLE_EN"
