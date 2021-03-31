# X Account Availability Zone Map

provides the mapping from the primary aws to sync up availability zones to avoid cross zone transit costs

## Shell Helper
run the following using your primary aws account to generate a map that should be assigned to the primary\_zone\_map
variable

```shell
aws ec2 describe-availability-zones --region "us-east-1" | \
  jq '.AvailabilityZones|.[]|{ (.ZoneName|split("")|last(.[])) : {ZoneName: .ZoneName, ZoneID: .ZoneId}}' | \
  jq -s add
```

primary\_zone\_map variable example
```hcl
default = {
  "a" = { "ZoneName" = "us-east-1a", "ZoneID" = "use1-az1" },
  "b" = { "ZoneName" = "us-east-1b", "ZoneID" = "use1-az2" },
  "c" = { "ZoneName" = "us-east-1c", "ZoneID" = "use1-az4" },
  "d" = { "ZoneName" = "us-east-1d", "ZoneID" = "use1-az6" },
  "e" = { "ZoneName" = "us-east-1e", "ZoneID" = "use1-az3" },
  "f" = { "ZoneName" = "us-east-1f", "ZoneID" = "use1-az5" }
}
```

## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_availability_zones.ou_zones](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_primary_zone_map"></a> [primary\_zone\_map](#input\_primary\_zone\_map) | Map of zones from the primary aws account to sync availability zones between aws accounts for cost optimizations | <pre>object({<br>    zone = object({<br>      ZoneName = string<br>      ZoneID = string<br>    })})</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_zones"></a> [zones](#output\_zones) | n/a |
