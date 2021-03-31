output "zones" {
  value = {
    for zone in keys(var.primary_zone_map) : zone => {
      name = local.account_zone_map[var.primary_zone_map[zone]["ZoneID"]]
      id   = var.primary_zone_map[zone]["ZoneID"]
    }
  }
}