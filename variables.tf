variable "primary_zone_map" {
  type = map
//  default = {
//    "a" = { "ZoneName" = "us-east-1a", "ZoneID" = "use1-az1" },
//    "b" = { "ZoneName" = "us-east-1b", "ZoneID" = "use1-az2" },
//    "c" = { "ZoneName" = "us-east-1c", "ZoneID" = "use1-az4" },
//    "d" = { "ZoneName" = "us-east-1d", "ZoneID" = "use1-az6" },
//    "e" = { "ZoneName" = "us-east-1e", "ZoneID" = "use1-az3" },
//    "f" = { "ZoneName" = "us-east-1f", "ZoneID" = "use1-az5" }
//  }
}

locals {
  account_zone_map = { for zone in data.aws_availability_zones.ou_zones.zone_ids : zone => element( data.aws_availability_zones.ou_zones.names ,index(data.aws_availability_zones.ou_zones.zone_ids, zone)) }
}
