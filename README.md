# Generate input primary_zone_map

run the following using your primary aws account to generate a map that should be assigned to the primary_zone_map 
variable

```shell
aws ec2 describe-availability-zones --region "us-east-1" | \
  jq '.AvailabilityZones|.[]|{ (.ZoneName|split("")|last(.[])) : {ZoneName: .ZoneName, ZoneID: .ZoneId}}' | \
  jq -s add
```

