resource "aws_key_pair" "jenkins_slaves" {
  key_name = "jenkins-slaves"
  public_key = "${var.public_key}"
}


resource "aws_launch_configuration" "jenkins_master" {
  # Launch Configurations cannot be updated after creation with the AWS API.
  # In order to update a Launch Configuration, Terraform will destroy the
  # existing resource and create a replacement.
  #
  # We're only setting the name_prefix here,
  # Terraform will add a random string at the end to keep it unique.

  name_prefix          = "jenkins-"
  image_id             = "${data.aws_ami.jenkins-master-ami.id}"
  instance_type        = "${var.environment == "dev" ? "t2.micro" : "t2.small"}"
  iam_instance_profile = "${aws_iam_instance_profile.jenkins_profile.id}"
  key_name             = "${aws_key_pair.jenkins_slaves.key_name}"
  security_groups      = ["${aws_security_group.jenkins_master_sg.id}"]

  associate_public_ip_address = false
  enable_monitoring = false

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "jenkins_master_asg" {
  name                    = "${aws_launch_configuration.jenkins_master.name}-asg"

  vpc_zone_identifier       = ["${data.terraform_remote_state.vpc.private_subnets}"]
  max_size                  = 3
  min_size                  = "${var.environment == "prod" ? 2 : 1}"
  desired_capacity =  "${var.environment == "prod" ? 2 : 1}"
  launch_configuration      = "${aws_launch_configuration.jenkins_master.id}"

  target_group_arns = ["${aws_lb_target_group.lb_target_group.arn}"]

  lifecycle {
    create_before_destroy = true
  }

  tag {
    key                 = "Name"
    value               = "jenkins_slave"
    propagate_at_launch = true
  }

  tag {
    key                 = "Owner"
    value               = "vivek"
    propagate_at_launch = true
  }

  tag {
    key                 = "Environment"
    value               = "dev"
    propagate_at_launch = true
  }
}

resource "aws_lb" "jenkins_master_lb" {
  name               = "jenkins-master-alb"
  internal           = false
  load_balancer_type = "application"

  subnets            = ["${data.terraform_remote_state.vpc.public_subnets}"]
  security_groups    = ["${aws_security_group.lb_sg.id}"]


  tags {
    Name        = "jenkins-server"
    Environment = "dev"
    Owner = "vivek"
  }
}

resource "aws_lb_target_group" "lb_target_group" {
  name        = "jenkins-targetGroup"
  port        = 8080
  protocol    = "HTTP"
  vpc_id      = "${data.terraform_remote_state.vpc.vpc_id}"
  target_type = "instance"

  health_check {
    interval            = 30
    path                = "/"
    port                = 8080
    healthy_threshold   = 5
    unhealthy_threshold = 2
    timeout             = 5
    protocol            = "HTTP"
    matcher             = "200,202"
  }
}

resource "aws_lb_listener" "CF2TF-ALB-Listener" {
  load_balancer_arn = "${aws_lb.jenkins_master_lb.arn}"
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${aws_lb_target_group.lb_target_group.arn}"
    type             = "forward"
  }
}