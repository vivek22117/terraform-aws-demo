// Jenkins slaves resource template
data "template_file" "user_data_slave" {
  template = "${file("scripts/join-cluster.tpl")}"

  vars {
    jenkins_url            = "http://${aws_elb.jenkins_elb.dns_name}"
    jenkins_username       = "${var.jenkins_username}"
    jenkins_password       = "${var.jenkins_password}"
    jenkins_credentials_id = "${var.jenkins_credentials_id}"
    environment            = "${var.environment}"
  }
}

// Jenkins slaves launch configuration
resource "aws_launch_configuration" "jenkins_slave_launch_conf" {
  name_prefix = "jenkins-slave-"

  image_id        = "${data.aws_ami.jenkins-slave-ami.id}"
  instance_type   = "${var.environment == "prod" ? "t2.small" : "t2.micro"}"
  key_name        = "${aws_key_pair.jenkins_slaves.key_name}"
  security_groups = ["${aws_security_group.jenkins_slaves_sg.id}"]

  user_data            = "${data.template_file.user_data_slave.rendered}"
  iam_instance_profile = "${aws_iam_instance_profile.jenkins_profile.arn}"
  associate_public_ip_address = false

  root_block_device {
    volume_type           = "gp2"
    volume_size           = 10
    delete_on_termination = true
  }

  lifecycle {
    create_before_destroy = true
  }
}

// ASG Jenkins slaves
resource "aws_autoscaling_group" "jenkins_slaves_asg" {
  name_prefix = "${aws_launch_configuration.jenkins_slave_launch_conf.name}-asg"

  max_size             = 3
  min_size             = "${var.environment == "prod" ? 2 : 1}"
  desired_capacity     = "${var.environment == "prod" ? 2 : 1}"
  vpc_zone_identifier  = ["${data.terraform_remote_state.vpc.private_subnets}"]
  launch_configuration = "${aws_launch_configuration.jenkins_slave_launch_conf.name}"

  health_check_grace_period = 100
  health_check_type         = "EC2"

  //depends_on = ["aws_instance.jenkins_master", "aws_elb.jenkins_elb"]

  lifecycle {
    create_before_destroy = true
  }
  tag {
    key                 = "Name"
    value               = "jenkins-slave"
    propagate_at_launch = true
  }
  tag {
    key                 = "Author"
    value               = "vivek"
    propagate_at_launch = true
  }
  tag {
    key                 = "Tool"
    value               = "Terraform"
    propagate_at_launch = true
  }
}

// Scale out
resource "aws_cloudwatch_metric_alarm" "high-cpu-jenkins-slaves-alarm" {
  alarm_name          = "high-cpu-jenkins-slaves-alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "80"

  dimensions {
    AutoScalingGroupName = "${aws_autoscaling_group.jenkins_slaves_asg.name}"
  }

  alarm_description = "This metric monitors ec2 cpu utilization"
  alarm_actions     = ["${aws_autoscaling_policy.scale-out.arn}"]
}

resource "aws_autoscaling_policy" "scale-out" {
  name                   = "scale-out-jenkins-slaves"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = "${aws_autoscaling_group.jenkins_slaves_asg.name}"
}

// Scale In
resource "aws_cloudwatch_metric_alarm" "low-cpu-jenkins-slaves-alarm" {
  alarm_name          = "low-cpu-jenkins-slaves-alarm"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "50"

  dimensions {
    AutoScalingGroupName = "${aws_autoscaling_group.jenkins_slaves_asg.name}"
  }

  alarm_description = "This metric monitors ec2 cpu utilization"
  alarm_actions     = ["${aws_autoscaling_policy.scale-in.arn}"]
}

resource "aws_autoscaling_policy" "scale-in" {
  name                   = "scale-in-jenkins-slaves"
  scaling_adjustment     = -1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = "${aws_autoscaling_group.jenkins_slaves_asg.name}"
}
