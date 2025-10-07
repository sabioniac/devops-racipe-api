######################################################################
# Create IAM Users and policy for Continuous deployment (CD) Account #
######################################################################

resource "aws_iam_user" "CD" {
   name = "devops-cicd"
}

resource "aws_iam_access_key" "CD" {
    user = aws_iam_user.cd.name
}

###########################################################
# Policy for Terraform backend to S3 and Dynamo DB Access #
###########################################################

data "aws_iam_policy_document" "tf_backend"{
    statement {
        effect = "Allow"
        actions = ["s3:ListBucket"]
        resources =  ["arn:aws:s3:::${var.tf_state_bucket}"]
    }

    statement {
        effect = "Allow"
        actions = ["s3:GetObject", "s3:PutObject", "s3:DeleteObject"]
        resources = [
            "arn:aws:s3:::${var.tf_state_bucket}/devops-tf-state-deploy/*",
            "arn:aws:s3:::${var.tf_state_bucket}/tf-state-deploy-env/*"
        ]
    }

    statement {
        effect = "Allow"
        actions= [
            "dynamodb:DescribeTable",
            "dynamodb:GetItem",
            "dynamodb:PutItem",
            "dynamodb:DeleteItem"
        ]
        resources = "arn:aws:dyanmodb:*:*:table/${var.tf_state_lock_table}"
    }
}

resource "aws_iam_policy" "tf_backend" {
    name = "${aws_iam_user.cd.name}-tf-s3-dyanmodb"
    description = "allow user to use S3 and DynamoDB for TF backend resources"
    policy = data.aws_iam_policy_document.tf_backend.json
}

resource "aws_iam_user_policy_attachment" "tf_backend" {
    user = aws_iam_user.cd.name
    policy_arn = aws_iam_policy.tf_backend.arn
}


