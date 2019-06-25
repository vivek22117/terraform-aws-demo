// Security Group for Jenkins Master
resource "aws_security_group" "jenkins_master_sg" {
  name        = "jenkins-master-sg"
  description = "Allow traffic from port 8080 and enable SSH"
  vpc_id      = "${data.terraform_remote_state.vpc.vpc_id}"

  lifecycle {
    create_before_destroy = true
  }

  tags = "${local.common_tags}"
}

resource "aws_security_group_rule" "allow_traffic_from_lb" {
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  security_group_id        = "${aws_security_group.jenkins_master_sg.id}"
  source_security_group_id = "${aws_security_group.lb_sg.id}"
}

resource "aws_security_group_rule" "allow_ssh_traffic" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  security_group_id        = "${aws_security_group.jenkins_master_sg.id}"
  source_security_group_id = "${data.terraform_remote_state.vpc.bastion_sg}"
}

resource "aws_security_group_rule" "master_outbound_rule" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  security_group_id = "${aws_security_group.jenkins_master_sg.id}"
  cidr_blocks       = ["0.0.0.0/0"]
}

//Security Group for Jenkins Slaves
resource "aws_security_group" "jenkins_slaves_sg" {
  name        = "jenkin-slaves-sg"
  description = "Allow traffic on port 22 from Jenkins Master"
  vpc_id      = "${data.terraform_remote_state.vpc.vpc_id}"

  tags = "${local.common_tags}"
}

resource "aws_security_group_rule" "allow_ssh_traffic_for_slaves" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  security_group_id        = "${aws_security_group.jenkins_slaves_sg.id}"
  source_security_group_id = "${aws_security_group.jenkins_master_sg.id}"
}

resource "aws_security_group_rule" "allow_ssh_traffic_from_bastion" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  security_group_id        = "${aws_security_group.jenkins_slaves_sg.id}"
  source_security_group_id = "${data.terraform_remote_state.vpc.bastion_sg}"
}

resource "aws_security_group_rule" "allow_outbound_traffic" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.jenkins_slaves_sg.id}"
}

// Security Group for Elastic Load Balancer
resource "aws_security_group" "lb_sg" {
  name        = "jenkins-lb-sg"
  description = "load balancer security group"
  vpc_id      = "${data.terraform_remote_state.vpc.vpc_id}"

  tags = "${local.common_tags}"
}

resource "aws_security_group_rule" "allow_http" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  security_group_id = "${aws_security_group.lb_sg.id}"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "allow_outbound_traffic_lb" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.lb_sg.id}"
}

/*resource "aws_security_group_rule" "allow_https" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  security_group_id = "${aws_security_group.lb_sg.id}"
  cidr_blocks       = ["0.0.0.0/0"]
}*/

