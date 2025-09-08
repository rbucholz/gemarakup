# resource "aws_route53_record" "gemarakup" {
#   zone_id = "Z101482010VPWL8GYG3Y5" # move to vars.tf
#   name    = "gemarakup.com"
#   type    = "A"
#   records = [  ]
#   ttl     = "300"
# }


# resource "aws_route53_record" "gemarakup_cname" {
#     zone_id = aws_route53_record.gemarakup.zone_id
#     name    = "_092a5dd46a80686dfc0753e0e5a5126c.gemarakup.com."
#     type    = "CNAME"
#     ttl     = "300"
#     records = ["_8f3cf022213914080791fc7501d38353.xlfgrmvvlj.acm-validations.aws."]
# }

# resource "aws_route53_record" "gemarakup_www_cname" {
#     zone_id = aws_route53_record.gemarakup.zone_id
#     name    = "_092a5dd46a80686dfc0753e0e5a5126c.gemarakup.com."
#     type    = "CNAME"
#     ttl     = "300"
#     records = ["_8f3cf022213914080791fc7501d38353.xlfgrmvvlj.acm-validations.aws."]
# }