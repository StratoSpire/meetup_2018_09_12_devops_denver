# Denver DevOps Meetup September 12, 2018

## Used Modules
- [`terraform-google-project-factory`](https://github.com/terraform-google-modules/terraform-google-project-factory)
- [`terraform-google-network`](https://github.com/terraform-google-modules/terraform-google-network)
- [`terraform-kubernetes-engine`](https://github.com/terraform-google-modules/terraform-google-kubernetes-engine)

## CircleCI
See [Using Environment Variables](https://circleci.com/docs/2.0/env-vars/) for creating a new context called `meetup-demo` with the following variables:
- `GOOGLE_SA_KEY` - The output of your service account key
- `TF_VAR_admin_email` - The email address of the gsuite admin (for gsuite integration)
- `TF_VAR_organization_id` - The GCP organization id
- `TF_VAR_billing_account` - The GCP billing account
- `TF_VAR_group_name` - The gsuite group name to grant appropriate permissions

## Asciinema Recording
[![asciicast](https://asciinema.org/a/FygCQHk8YHhAjaHpFU4de5o0s.png)](https://asciinema.org/a/FygCQHk8YHhAjaHpFU4de5o0s)
To play back in your local terminal run `asciinema play https://asciinema.org/a/FygCQHk8YHhAjaHpFU4de5o0s`
