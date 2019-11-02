resource "heroku_app" "ci" {
  name   = "${var.app_prefix}-app-ci"
  region = "eu"

  config_vars = {
    SPRING_PROFILES_ACTIVE = "heroku"
    LOGZ_URL = "${var.logzio_url}"
    LOGZ_TOKEN = "${var.logzio_token}"
  }
}

resource "heroku_app" "staging" {
  name   = "${var.app_prefix}-app-staging"
  region = "eu"

  config_vars = {
    SPRING_PROFILES_ACTIVE = "heroku"
    LOGZ_URL = "${var.logzio_url}"
    LOGZ_TOKEN = "${var.logzio_token}"
  }
}

resource "heroku_app" "production" {
  name   = "${var.app_prefix}-app-prod"
  region = "eu"

  config_vars = {
    SPRING_PROFILES_ACTIVE = "heroku"
    LOGZ_URL = "${var.logzio_url}"
    LOGZ_TOKEN = "${var.logzio_token}"
  }
}

resource "heroku_pipeline" "measurement-app-pipeline" {
  name = "${var.pipeline_name}"
}

resource "heroku_pipeline_coupling" "ci" {
  app      = "${heroku_app.ci.name}"
  pipeline = "${heroku_pipeline.measurement-app-pipeline.id}"
  stage    = "development"
}

resource "heroku_pipeline_coupling" "staging" {
  app      = "${heroku_app.staging.name}"
  pipeline = "${heroku_pipeline.measurement-app-pipeline.id}"
  stage    = "staging"
}

resource "heroku_pipeline_coupling" "production" {
  app      = "${heroku_app.production.name}"
  pipeline = "${heroku_pipeline.measurement-app-pipeline.id}"
  stage    = "production"
}
