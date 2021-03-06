
/**
 * The S3 bucket for uploading to our
 */

resource "aws_s3_bucket" "segment-s3-dynamo-bucket" {
	bucket = "${var.bucket_name}"
	depends_on = ["aws_iam_role.segment-s3-dynamo-lambda", "aws_dynamodb_table.segment-s3-dynamo"]
	policy = <<EOF
{
	"Version": "2008-10-17",
	"Id": "Policy1425281770533",
	"Statement": [
		{
			"Sid": "Stmt1425281765688",
			"Effect": "Allow",
			"Principal": {
				"AWS": "arn:aws:iam::107630771604:user/s3-copy"
			},
			"Action": "s3:*",
			"Resource": "arn:aws:s3:::${var.bucket_name}/segment-logs/*"
		},
		{
			"Sid": "Stmt1425281765688",
			"Effect": "Allow",
			"Principal": {
				"AWS": "${aws_iam_role.segment-s3-dynamo-lambda.arn}"
			},
			"Action": ["s3:Get*", "s3:List*"],
			"Resource": "arn:aws:s3:::${var.bucket_name}/segment-logs/*"
		}
	]
}
EOF
}

