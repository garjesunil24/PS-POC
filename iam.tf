# IAM Policy to allow restarting nginx via SSM
resource "aws_iam_policy" "restart_nginx" {
  name        = "RestartNginxSSMPolicy"
  description = "Allow restarting nginx via SSM SendCommand"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid    = "AllowSSMSendCommand",
        Effect = "Allow",
        Action = [
          "ssm:SendCommand",
          "ssm:GetCommandInvocation",
          "ssm:ListCommandInvocations"
        ],
        Resource = "*"
      },
      {
        Sid    = "AllowInstanceAndSSMDescribe",
        Effect = "Allow",
        Action = [
          "ec2:DescribeInstances",
          "ssm:DescribeInstanceInformation"
        ],
        Resource = "*"
      }
    ]
  })
}

# IAM User
resource "aws_iam_user" "nginx_admin" {
  name = "nginx-admin"
}

# Attach policy to the user
resource "aws_iam_user_policy_attachment" "attach_restart_policy" {
  user       = aws_iam_user.nginx_admin.name
  policy_arn = aws_iam_policy.restart_nginx.arn
}

####ssm command to restart nginx
####aws ssm send-command \
  #--document-name "AWS-RunShellScript" \
  #--targets "Key=instanceIds,Values=<INSTANCE_ID>" \
  #--comment "Restart nginx" \
  #--parameters commands=["sudo systemctl restart nginx"] \
  #--region us-east-1
