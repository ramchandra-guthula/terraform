output "instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.app_server.id
}

output "instance_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.app_server.public_ip
}
output "volume_id" {
  description = "Getting volume ID"
  value       = aws_instance.app_server.root_block_device[0].volume_id
}

#output "regions" {
#  description = "Getting regions"
#  value       = data.aws_region.current.id
#}

output "ami_id" {
  description = "Getting ami ids"
  value       = data.aws_ami.web.id
}
