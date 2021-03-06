resource "aws_route53_zone" "innovation_toplevel" {
  name = "innovation.gov"

  tags {
    Project = "dns"
  }
}

resource "aws_route53_record" "innovation_gov_apex" {
  zone_id = "${aws_route53_zone.innovation_toplevel.zone_id}"
  name = "innovation.gov."
  type = "A"

  alias {
    name = "d2ntl68ywjm643.cloudfront.net."
    zone_id = "${local.cloudfront_zone_id}"
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "innovation_gov_www" {
  zone_id = "${aws_route53_zone.innovation_toplevel.zone_id}"
  name = "www.innovation.gov."
  type = "A"

  alias {
    name = "d2ntl68ywjm643.cloudfront.net."
    zone_id = "${local.cloudfront_zone_id}"
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "demo_innovation_gov_a" {
  zone_id = "${aws_route53_zone.innovation_toplevel.zone_id}"
  name = "demo.innovation.gov."
  type = "A"

  alias {
    name = "d3am9l7wwd0yie.cloudfront.net."
    zone_id = "${local.cloudfront_zone_id}"
    evaluate_target_health = false
  }
}

# BOD
resource "aws_route53_record" "innovation_gov_dmarc_innovation_gov_txt" {
  zone_id = "${aws_route53_zone.innovation_toplevel.zone_id}"
  name = "innovation.gov."
  type = "TXT"
  ttl = 300
  records = ["${local.spf_no_mail}"]
}

resource "aws_route53_record" "innovation_gov__dmarc_innovation_gov_txt" {
  zone_id = "${aws_route53_zone.innovation_toplevel.zone_id}"
  name = "_dmarc.innovation.gov."
  type = "TXT"
  ttl = 300
  records = ["${local.dmarc_reject}"]
}

output "innovation_ns" {
  value="${aws_route53_zone.innovation_toplevel.name_servers}"
}
