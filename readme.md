# README

## Miljøvariabler

For å sette opp denne infrastrukturen er det nødt til å settes miljøvariabler. 


Disse miljøvariablene må settes:

* AWS_ACCESS_KEY_ID
* AWS_SECRET_ACCESS_KEY
* HEROKU_EMAIL
* OPSGENIE_API_KEY
* STATUSCAKE_USERNAME
* STATUSCAKE_APIKEY
* TF_VAR_logzio_token
* TF_VAR_logzio_url

Det kan gjøres ved å bruke travis encrypt for hver enkelt slik:

```bash
 travis encrypt AWS_ACCESS_KEY_ID=<verdi> --add env.global
```

For å sette api key for Heroku deploy:
```bash
travis encrypt $(heroku auth:token) --add deploy.api_key
```



#### Terraform Dependency Graph

![Terraform Graph](/documentation/graph.png)

