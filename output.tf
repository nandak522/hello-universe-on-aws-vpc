output "vpc" {
    value = module.vpc.vpc_id
}
output "public_subnet" {
    value = module.vpc.public_subnets.0
}
output "security_group" {
    value = module.hello_universe_security_group.security_group_id
}
output "ec2_instance" {
    value = module.ec2_instance.public_ip
}
