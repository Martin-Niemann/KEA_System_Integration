# Run SchemaSpy on the database

Run the compose file:

`PODMAN_USERNS=keep-id podman compose --file podman-compose.yml up --detach`

Note that "Others" need to have write permission on the `output` directory.

Then, spin up a webserver inside the `output` directory:

`python -m http.server 8000`
