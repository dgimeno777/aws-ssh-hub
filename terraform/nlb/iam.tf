resource "aws_iam_policy" "hub_s3" {
  name = "ssh-hub-${local.resource_name_suffix}"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:ListBucket"
        ]
        Resource = [
          aws_s3_bucket.hub.arn
        ]
      },
      {
        Effect = "Allow"
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:DeleteObject"
        ]
        Resource = [
          "${aws_s3_bucket.hub.arn}/*"
        ]
      },
      {
        # For testing VPC Endpoint from private EC2
        Effect   = "Allow",
        Action   = "ec2:DescribePrefixLists",
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role" "hub" {
  name = "ssh-hub-${local.resource_name_suffix}"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "hub_s3" {
  policy_arn = aws_iam_policy.hub_s3.arn
  role       = aws_iam_role.hub.name
}

resource "aws_iam_instance_profile" "hub" {
  name = "ssh-hub-${local.resource_name_suffix}"
  role = aws_iam_role.hub.name
}
