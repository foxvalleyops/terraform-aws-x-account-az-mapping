/**
 * # X Account Availability Zone Map
 *
 * provides the mapping from the primary aws to sync up availability zones to avoid cross zone transit costs
 *
 * ## Shell Helper
 * run the following using your primary aws account to generate a map that should be assigned to the primary_zone_map
 * variable
 *
 * ```shell
 * aws ec2 describe-availability-zones --region "us-east-1" | \
 *   jq '.AvailabilityZones|.[]|{ (.ZoneName|split("")|last(.[])) : {ZoneName: .ZoneName, ZoneID: .ZoneId}}' | \
 *   jq -s add
 * ```
 *
 * primary_zone_map variable example
 * ```hcl
 * default = {
 *   "a" = { "ZoneName" = "us-east-1a", "ZoneID" = "use1-az1" },
 *   "b" = { "ZoneName" = "us-east-1b", "ZoneID" = "use1-az2" },
 *   "c" = { "ZoneName" = "us-east-1c", "ZoneID" = "use1-az4" },
 *   "d" = { "ZoneName" = "us-east-1d", "ZoneID" = "use1-az6" },
 *   "e" = { "ZoneName" = "us-east-1e", "ZoneID" = "use1-az3" },
 *   "f" = { "ZoneName" = "us-east-1f", "ZoneID" = "use1-az5" }
 * }
 * ```
 */
variable "primary_zone_map" {
  type = object({
    zone = object({
      ZoneName = string
      ZoneID   = string
  }) })

  description = "Map of zones from the primary aws account to sync availability zones between aws accounts for cost optimizations"
}

locals {
  account_zone_map = {
    for zone in data.aws_availability_zones.ou_zones.zone_ids :
    zone => element(data.aws_availability_zones.ou_zones.names, index(data.aws_availability_zones.ou_zones.zone_ids, zone))
  }
}
