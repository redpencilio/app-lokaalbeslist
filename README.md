# Participatie App

## Running the application

```shell
docker-compose -f docker-compose.yml -f docker-compose.override.yml up -d
```

or for development

```shell
docker-compose -f docker-compose.yml -f docker-compose.override.yml -f docker-compose.dev.yml up -d
```

The stack is built starting from [mu-project](https://github.com/mu-semtech/mu-project).

### Seed data

For development the database is seeded automatically with the data from `./data/db/toLoad/`. This data is a dump from the [Linked Open Data Challenge](https://openbelgium-2021.lblod.info/sparql) (similar to [Centrale Vindplaats](https://centrale-vindplaats.lblod.info/sparql)) from the end of march 2021. There is a migration `20210421115200-add-uuids-to-resources.sparql` that was added to add uuids to many of these resources since they were missing them.

TODO: For deployment we should find another scheme for this, e.g. optionally copying or symlinking the files in a dev-setup.

## Mailer secrets

The mailer needs some secret configuration to send mails, these are stored in
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
