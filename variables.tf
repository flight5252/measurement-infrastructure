variable "app_prefix" {
  default = "measurement"
}

variable "pipeline_name" {
  default = "measurement-pipeline"
}

variable "logzio_url" {
  type = "string"
  description = "url to logz-io found in config"
}

variable "logzio_token" {
  type = "string"
  description = "logzio token found in your logz.io account config"
}