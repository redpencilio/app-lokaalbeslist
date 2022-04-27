# LokaalBeslist.be

## Running the application
The stack is built starting from [mu-project](https://github.com/mu-semtech/mu-project).

### development
```shell
docker-compose -f docker-compose.yml -f docker-compose.dev.yml up -d
```
Once started, the frontend should locally be accessible on `http://localhost:81/`
### production
We recommend specifying all deploy-configuration in a `docker-compose.override.yml` file.
```shell
docker-compose -f docker-compose.yml -f docker-compose.override.yml up -d
```
### Ingesting data
The app comes with no data because it depends on external data sources.

  *  [Mandatendatabank (sourced by loket)](https://loket.lokaalbestuur.vlaanderen.be/)
  *  [lblod-harvester](https://qa.harvesting-self-service.lblod.info/)(temporary link)

You can follow the procedure for all data sources.

The ingestion should be a one-time operation per deployment and is currently semi-automatic for various reasons (mainly related to performance)
The ingestion is disabled by default. It is recommended, for performance, to start only one initial ingest at a time.

To proceed (similar for `mandatendatabank-consumer`):
1. make sure the app is up and running. And the migrations have run.
2. In `docker-compose.override.yml` override the following parameters for `besluiten-consumer`
```
# (...)
  besluiten-consumer:
    environment:
      SYNC_BASE_URL: 'https://dev.harvesting-self-service.lblod.info/' # The endpoint of your choice (see later what to choose)
      DISABLE_INITIAL_SYNC: 'false'
      BATCH_SIZE: 100 # if virtuoso is in prod mode, you can safely beef this up to 500/1000
```
3. `docker-compose up -d besluiten-consumer` should start the ingestion.
  This might take a (long) while if you ingest production data.
4. Check the logs (`docker-compose logs -f --tail=200 besluiten-consumer`), at some point, this message should show up
  `Initial sync was success, proceeding in Normal operation mode: ingest deltas`
   or execute in the database:
   ```
   PREFIX adms: <http://www.w3.org/ns/adms#>
   PREFIX task: <http://redpencil.data.gift/vocabularies/tasks/>
   PREFIX dct: <http://purl.org/dc/terms/>
   PREFIX cogs: <http://vocab.deri.ie/cogs#>

   SELECT ?s ?status ?created WHERE {
     ?s a <http://vocab.deri.ie/cogs#Job> ;
       adms:status ?status ;
       task:operation <http://redpencil.data.gift/id/jobs/concept/JobOperation/deltas/consumer/initialSync/besluiten> ;
       dct:created ?created ;
       dct:creator <http://data.lblod.info/services/id/mandatendatabank-consumer> .
    }
    ORDER BY DESC(?created)
   ```
5. You will have to restart the ES-indexing by running the script `/bin/bash config/scripts/reset-elastic.sh`
    (Note: only for besluiten-consumer. And, again, this will take a while for production data)
6. `docker-compose restart resource cache` is still needed after the intiial sync

## Additional notes:
### Endpoints to choose for ingestion.
#### besluiten

- development dataset: `https://dev.harvesting-self-service.lblod.info`
- QA dataset: `https://qa.harvesting-self-service.lblod.info`
- production dataset: will come soon.

Note: the QA dataset is already a very significant one.

### mandatendatabank

- development dataset: `https://dev.loket.lblod.info`
- QA: `https://loket.lblod.info`
- production dataset: `https://loket.lokaalbestuur.vlaanderen.be`

### Performance
- The default virtuoso settings might be too weak if you need to ingest the production data. Hence, there is a better config, you can take over in your `docker-compose.override.yml`
```
  virtuoso:
    volumes:
      - ./data/db:/data
      - ./config/virtuoso/virtuoso-production.ini:/data/virtuoso.ini
      - ./config/virtuoso/:/opt/virtuoso-scripts
```
### deliver-email-service
Should have credentials provided, see [deliver-email-service](https://github.com/redpencilio/deliver-email-service)
The mailer needs some secret configuration to send mails; these can be set in the
`docker-compose.override.yml` as follows:

```
services:
  deliver-email-service:
    environment:
      HOST: "smtp.example.com"
      PORT: "587"
      SECURE_CONNECTION: "true"
      EMAIL_ADDRESS: "myuser"
      EMAIL_PASSWORD: "mypassword"
```
