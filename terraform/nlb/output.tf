output "s3_bucket" {
  value = aws_s3_bucket.hub.bucket
}

output "instance_1_ssh_command" {
  value = module.instance_1.ssh_command
}
