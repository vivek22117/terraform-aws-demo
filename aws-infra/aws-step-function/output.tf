# URL to invoke the API
output "url" {
  value = "${aws_api_gateway_deployment.reminders-api-dev-deployment.invoke_url}"
}

output "s3_bucket_website_endpoint" {
  value       = "${aws_s3_bucket.website_bucket.website_endpoint}"
  description = "The website endpoint URL"
}

output "sns_arn" {
  value       = "${aws_cloudformation_stack.sns_reminder_stack.outputs["SNSARN"]}"
  description = "Email SNS topic ARN"
}
