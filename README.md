# meetup_2018_09_12_devops_denver

## CircleCI
In order for the pipeline to function, you will need to set up a context called `meetup-demo` with the following variables:
- `GOOGLE_SA_KEY` - The output of your service account key
- `TF_VAR_admin_email` - The email address of the gsuite admin (for gsuite integration)
- `TF_VAR_organization_id` - The GCP organization id
- `TF_VAR_billing_account` - The GCP billing account
- `TF_VAR_group_name` - The gsuite group name to grant appropriate permissions
For more information on CircleCI Environment variables, see [Using Environment Variables](https://circleci.com/docs/2.0/env-vars/)
