data "opsgenie_user" "flight-commander" {
  username = "flight5252521@gmail.com"
}

resource "opsgenie_user" "flight-attendent" {
  username = "thisisasuperfakeuser1000s7@gmail.com"
  full_name = "Flight Attendant Lastname"
  role = "User"
}

resource "opsgenie_user_contact" "contact_user" {
  username = "${opsgenie_user.flight-attendent.username}"
  to = "47-98980019"
  method = "voice"
}

provider "opsgenie" {
  api_url = "api.eu.opsgenie.com" 
}

resource "opsgenie_team" "measurement_backend" {
    name = "measurement_backend"
    description = "Dette er en beskrivelse for measurement_backend"

    member {
        id = "${opsgenie_user.flight-attendent.id}"
        role = "user"
    }

    member {
        id = "${data.opsgenie_user.flight-commander.id}"
        role = "admin"
    }
}

resource "opsgenie_schedule" "measurement_backend_schedule_for_team" {
  name = "measurement_backend_schedule_for_team"
  description = "This is a for measurement_backend_team"
  timezone = "Europe/Rome"
  enabled = true
  owner_team_id = "${opsgenie_team.measurement_backend.id}"
}

resource "opsgenie_schedule_rotation" "measurement_backend_team-schedule-rotation" { 
  schedule_id = "${opsgenie_schedule.measurement_backend_schedule_for_team.id}"
  name        = "measurement_backend_team-schedule-rotation"
  start_date  = "2019-10-28T18:00:00Z"
  end_date    ="2020-10-20T18:00:00Z"
  type        ="daily"
  length      = 1

  participant {
    type = "user"
    id   = "${opsgenie_user.flight-attendent.id}"
  }

  participant {
    type = "admin"
    id   = "${data.opsgenie_user.flight-commander.id}"
  }

  time_restriction {
    type = "time-of-day"

    restriction {
      start_hour = 1
      start_min  = 1
      end_hour   = 10
      end_min    = 1
    }
  }
}
