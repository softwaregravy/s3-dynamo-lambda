
resource "aws_iam_role" "segment-s3-dynamo-lambda" {
    name = "segment-s3-dynamo-lambda"
    assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "segment-s3-dynamo-lambda" {
    name = "dynamo-policy"
    role = "${aws_iam_role.segment-s3-dynamo-lambda.id}"
    policy = <<EOF
{
    "Version": "2008-10-17",
    "Statement": [
        {
            "Action": "dynamodb:*",
            "Effect": "Allow",
            "Resource": "${aws_dynamodb_table.segment-s3-dynamo.arn}",
            "Sid": ""
        }
    ]
}
EOF
}
