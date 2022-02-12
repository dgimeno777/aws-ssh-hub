data "http" "ip" {
  url = "https://ipv4.icanhazip.com/"
}

locals {
  my_public_ip = chomp(data.http.ip.body)
}
