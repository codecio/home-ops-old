data "http" "ipv4" {
  url = "http://ipv4.icanhazip.com"
}

resource "cloudflare_record" "apex_ipv4" {
  name    = "ipv4"
  zone_id = lookup(data.cloudflare_zones.domain.zones[0], "id")
  value   = chomp(data.http.ipv4.body)
  proxied = true
  type    = "A"
  ttl     = 1
}

resource "cloudflare_record" "cname_root" {
  name    = data.sops_file.cloudflare_secrets.data["cloudflare_domain"]
  zone_id = lookup(data.cloudflare_zones.domain.zones[0], "id")
  value   = "ipv4.${data.sops_file.cloudflare_secrets.data["cloudflare_domain"]}"
  proxied = true
  type    = "CNAME"
  ttl     = 1
}

resource "cloudflare_record" "cname_www" {
  name    = "www"
  zone_id = lookup(data.cloudflare_zones.domain.zones[0], "id")
  value   = "ipv4.${data.sops_file.cloudflare_secrets.data["cloudflare_domain"]}"
  proxied = true
  type    = "CNAME"
  ttl     = 1
}

resource "cloudflare_record" "txt_spf" {
  name    = data.sops_file.cloudflare_secrets.data["cloudflare_domain"]
  zone_id = lookup(data.cloudflare_zones.domain.zones[0], "id")
  value   = "v=spf1 -all"
  proxied = false
  type    = "TXT"
  ttl     = 1
}

resource "cloudflare_record" "hajimari" {
  name    = "hajimari"
  zone_id = lookup(data.cloudflare_zones.domain.zones[0], "id")
  value   = data.sops_file.cloudflare_secrets.data["cloudflare_lb_nip"]
  proxied = false
  type    = "CNAME"
  ttl     = 1
}
