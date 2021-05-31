data "aws_availability_zones" "this" {
  # Filter out Local Zones.
  filter {
    name   = "opt-in-status"
    values = ["opt-in-not-required"]
  }
}

# Cap AZs at 3. If the region doesn't have at least 3 AZs, this will
# fail, and that's OK -- we want it to, because we want to guarantee
# at least 3 AZs.
locals {
  az-names = [
    data.aws_availability_zones.this.names[0],
    data.aws_availability_zones.this.names[1],
    data.aws_availability_zones.this.names[2],
  ]
}
