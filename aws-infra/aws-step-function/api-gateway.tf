# API Gateway REST API
resource "aws_api_gateway_rest_api" "reminders_api" {
  # The name of the REST API
  name = "ReminderAPI"

  # An optional description of the REST API
  description = "A Prototype REST API to execute Step Function for reminder"

  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

# API Gateway resource, which is a certain path inside the REST API
resource "aws_api_gateway_resource" "reminders_api_resource" {
  # The id of the associated REST API and parent API resource are required
  rest_api_id = aws_api_gateway_rest_api.reminders_api.id
  parent_id   = aws_api_gateway_rest_api.reminders_api.root_resource_id

  # The last segment of the URL path for this API resource
  path_part = var.api_gateway_reminder_path
}

# HTTP method to a API Gateway resource (REST endpoint)
resource "aws_api_gateway_method" "reminders_api_method" {
  # The ID of the REST API and the resource at which the API is invoked
  rest_api_id = aws_api_gateway_rest_api.reminders_api.id
  resource_id = aws_api_gateway_resource.reminders_api_resource.id

  # The verb of the HTTP request
  http_method = "POST"

  # Whether any authentication is needed to call this endpoint
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "reminders_api_integration" {
  # The ID of the REST API and the endpoint at which to integrate a Lambda function
  rest_api_id = aws_api_gateway_rest_api.reminders_api.id
  resource_id = aws_api_gateway_resource.reminders_api_resource.id

  # The HTTP method to integrate with the Lambda function
  http_method = aws_api_gateway_method.reminders_api_method.http_method

  # AWS is used for Lambda proxy integration when you want to use a Velocity template
  type = "AWS"

  # The URI at which the API is invoked
  uri = aws_lambda_function.sf_executor.invoke_arn

  # Lambda functions can only be invoked via HTTP POST
  integration_http_method = "POST"
}

# API Gateway deployment
resource "aws_api_gateway_deployment" "reminders-api-dev-deployment" {
  rest_api_id = aws_api_gateway_rest_api.reminders_api.id

  # development stage
  stage_name = "dev"

  # Deployment should always occur after lambda integration
  depends_on = [aws_api_gateway_integration.reminders_api_integration]
}

