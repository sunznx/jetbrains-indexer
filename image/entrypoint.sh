#/bin/sh

echo_format() {
    echo "============================================================"
    echo "$1"
    echo "============================================================"
}

# Generate indexes
echo_format "Generating indexes"
./ij-shared-indexes-tool-cli/bin/ij-shared-indexes-tool-cli indexes \
		--ij ./ide \
		--project "${PROJECT_DIR}" \
		--data-directory "${SHARED_INDEX_BASE}/"

# Generate config file for project (your-project/intellij.yaml)
echo_format "Creating intellij.yaml file"
config_yaml=<<<EOF
sharedIndex:
  project:
    - url: ${INDEXES_CDN_UR}
  consents:
    - kind: project
      decision: allowed
EOF

# Check if intellij.yaml already exists in project, if not create one
touch "$PROJECT_DIR/intellij.yaml"
echo "$config_yaml" > "$PROJECT_DIR/intellij.yaml"
echo "Wrote the following to intellij.yaml:\n"
echo "$config_yaml"
echo "Be sure to commit this file to source control so others can use it."
