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

output "availability_zones" {
  description = "Getting AZ's"
  value       = data.aws_availability_zones.available
}

output "ami_id" {
  description = "Getting ami ids"
  value       = data.aws_ami.ami_id.id
}


