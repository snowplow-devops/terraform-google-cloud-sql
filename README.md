[![Release][release-image]][release] [![CI][ci-image]][ci] [![License][license-image]][license] [![Registry][registry-image]][registry]

# terraform-google-cloud-sql

A Terraform module for deploying a simple CloudSQL instance.  This module only allows deployment of an internet facing database and has no out of the box support for configuring VPC Peering for a Private VPC only deployment.

It is therefore recommended to connect to deployed instances using the [Cloud SQL Proxy](https://github.com/GoogleCloudPlatform/cloudsql-proxy).

_Note_: If you intend to have many concurrent connections it is recommended to bump the `tier` to at least a `db-g1-small` if not bigger as the default `db-f1-micro` only allows for 20 concurrent connections with a Postgres database.

_Note_: The deployment of a Cloud SQL database can take upwards of 20 minutes as default - the timeouts are set to 60m for creation and deletion to allow for plenty of time.

## Usage

```hcl
module "instance" {
  source = "snowplow-devops/cloud-sql/google"

  name = "test-db-instance"

  region      = local.region
  db_name     = "snowplow"
  db_username = "snowplow"
  db_password = "$N0wPL0W"
}
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_google"></a> [google](#requirement\_google) | >= 3.44.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 3 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | >= 3.44.0 |
| <a name="provider_random"></a> [random](#provider\_random) | >= 3 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_sql_database.db](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/sql_database) | resource |
| [google_sql_database_instance.instance](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/sql_database_instance) | resource |
| [google_sql_user.user](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/sql_user) | resource |
| [random_id.db_name_suffix](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_db_name"></a> [db\_name](#input\_db\_name) | The name of the database to create | `string` | n/a | yes |
| <a name="input_db_password"></a> [db\_password](#input\_db\_password) | The password of the administration user to create | `string` | n/a | yes |
| <a name="input_db_username"></a> [db\_username](#input\_db\_username) | The name of the administration user to create | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | A name which will be pre-pended to the resources created | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | The name of the region to deploy within | `string` | n/a | yes |
| <a name="input_authorized_networks"></a> [authorized\_networks](#input\_authorized\_networks) | The list of CIDR ranges to allow access to the instance over | <pre>list(object({<br>    name  = string<br>    value = string<br>  }))</pre> | `[]` | no |
| <a name="input_database_version"></a> [database\_version](#input\_database\_version) | The database version to use (https://cloud.google.com/sql/docs/db-versions) | `string` | `"POSTGRES_9_6"` | no |
| <a name="input_deletion_protection"></a> [deletion\_protection](#input\_deletion\_protection) | Whether to protect the instance from accidental termination | `bool` | `false` | no |
| <a name="input_labels"></a> [labels](#input\_labels) | The labels to append to this resource | `map(string)` | `{}` | no |
| <a name="input_tier"></a> [tier](#input\_tier) | The tier of database to deploy | `string` | `"db-f1-micro"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_connection_name"></a> [connection\_name](#output\_connection\_name) | The connection name to be used when using things like Cloud SQL Proxy |
| <a name="output_first_ip_address"></a> [first\_ip\_address](#output\_first\_ip\_address) | The first IP Address attached to the instance |
| <a name="output_port"></a> [port](#output\_port) | The port that the instance is available over |
| <a name="output_self_link"></a> [self\_link](#output\_self\_link) | The URI of the instance |
| <a name="output_service_account_email_address"></a> [service\_account\_email\_address](#output\_service\_account\_email\_address) | The SA email address assigned to the instance |

# Copyright and license

The Terraform Google CloudSQL project is Copyright 2021-present Snowplow Analytics Ltd.

Licensed under the [Snowplow Community License](https://docs.snowplow.io/community-license-1.0). _(If you are uncertain how it applies to your use case, check our answers to [frequently asked questions](https://docs.snowplow.io/docs/contributing/community-license-faq/).)_

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

[release]: https://github.com/snowplow-devops/terraform-google-cloud-sql/releases/latest
[release-image]: https://img.shields.io/github/v/release/snowplow-devops/terraform-google-cloud-sql

[ci]: https://github.com/snowplow-devops/terraform-google-cloud-sql/actions?query=workflow%3Aci
[ci-image]: https://github.com/snowplow-devops/terraform-google-cloud-sql/workflows/ci/badge.svg

[license]: https://docs.snowplow.io/docs/contributing/community-license-faq/
[license-image]: https://img.shields.io/badge/license-Snowplow--Community-blue.svg?style=flat

[registry]: https://registry.terraform.io/modules/snowplow-devops/cloud-sql/google/latest
[registry-image]: https://img.shields.io/static/v1?label=Terraform&message=Registry&color=7B42BC&logo=terraform
