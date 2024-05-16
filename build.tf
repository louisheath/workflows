terraform {
  required_providers {
    incident = {
      source  = "incident-io/incident"
      version = "3.0.0"
    }
  }
}

provider "incident" {}

resource "incident_workflow" "assign_follow_up_to_incident_reporter" {
  name    = "Assign follow up to incident reporter"
  trigger = "follow-up.updated"
  expressions = [
  ]
  condition_groups = [
    {
      conditions = [
        {
          # "Follow-up → Owner"
          subject   = "followup.assignee"
          operation = "is_not_set"
          param_bindings = [
          ]
        },
      ]
    },
  ]
  steps = [
    {
      # "Assign the incident follow-up to a user"
      id   = "01HWMQXT2X5RESVAF1FNGBV1FC"
      name = "follow_up.assign"
      param_bindings = [
        {
          value = {
            # "Follow-up"
            reference = "followup"
          }
        },
        {
          value = {
            # "Incident → Reporter"
            reference = "incident.reporter"
          }
        },
      ]
    },
  ]
  once_for = [
    # "Follow-up"
    "followup",
  ]
  include_private_incidents = false
  continue_on_step_error    = false
  delay = {
    for_seconds = 0
    conditions_apply_over_delay = false
  }
  runs_on_incidents = "newly_created_and_active"
  runs_on_incident_modes = [
    "standard",
  ]
  state = "active"
}