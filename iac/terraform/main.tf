# Демонстрационный TF с типовыми smell'ами для Checkov
terraform {
  required_version = ">= 1.5.0"
}

provider "null" {}

resource "null_resource" "demo" {
  # no tags, no depends_on etc - просто болванка
  triggers = {
    always = timestamp()
  }
}
