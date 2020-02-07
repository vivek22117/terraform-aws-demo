profile        = "admin"
environment    = "dev"
default_region = "us-east-1"

role_name   = "JenkinAccessRole"
policy_name = "JenkinsAccessPolicy"
policy_path = "${path.module}/policy-scripts/administrator-policy.json"

team      = "DoubleDigitTeam"
component = "jenkins-cluster"

policy_vars = {
  service = "ec2.amazonaws.com"
}