profile = "doubledigit"
environment = "dev"

sms-reminder-lambda = "SMSReminderLambda"
email-reminder-lambda = "EmailReminderLambda"
step-function-name = "StepFunctionExecutorLambda"
memory-size = "384"
time-out = "120"

allowed_ips = "0.0.0.0/0"
versioning_enabled = "true"
lifecycle_rule_enabled = "true"
noncurrent_version_expiration_days = 2

api_gateway_reminder_path = "reminders"
prefix = "deploy/"

sns_stack_name = "sns-reminder-cft-stack"
display_name = "ReminderSNSTopic"
