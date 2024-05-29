terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.48.0"
    }
    databricks = {
      source = "databricks/databricks"
      version = "1.45.0"
    }
  }
}

provider "databricks" {
  # Configuration options
}

provider "aws" {
  region = "us-east-1"
}


resource "aws_vpc" "example" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_s3_bucket" "bucket" {
  bucket = "my-tf-test-bucket-marco-o"
  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_versioning" "vpc_flow_logs_bucket_versioning" {
  bucket = aws_s3_bucket.bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_flow_log" "flow_log" {
  log_destination = aws_s3_bucket.bucket.arn
  log_destination_type = "s3"
  traffic_type    = "ALL"
  vpc_id          = aws_vpc.example.id
    destination_options {
    file_format        = "plain-text"
    per_hour_partition = true
  }
  tags = {
    Name = "default"
  }
}

###Bucket Policy

data "aws_s3_bucket_policy" "source_policy_bucket_flow_logs" {
  bucket = aws_s3_bucket.bucket.id
  depends_on = [ aws_flow_log.flow_log ]
}


data "aws_iam_policy_document" "target_policy_bucket_flow_logs" {
  source_policy_documents = [data.aws_s3_bucket_policy.source_policy_bucket_flow_logs.policy]
  statement {
    sid    = "ccoe_customaft_s3-bucket-ssl-requests-only"

    principals {
      type        = "*"
      identifiers = ["*"]
    }

    effect = "Deny"

    actions   = ["s3:*"]
    resources = ["${aws_s3_bucket.bucket.arn}",
    "${aws_s3_bucket.bucket.arn}/*"]
    condition {
      test     = "Bool"
      variable = "aws:SecureTransport"
      values   = ["false"]
    }  
  }
}

resource "aws_s3_bucket_policy" "ccoe_customaft_policy_bucket_flow_logs" {
  bucket = aws_s3_bucket.bucket.id
  policy = data.aws_iam_policy_document.target_policy_bucket_flow_logs.json
}

resource "aws_s3_bucket_notification" "bucket_notification" {
  bucket = aws_s3_bucket.bucket.id

  queue {
    queue_arn     = aws_sqs_queue.queue.arn
    events        = ["s3:ObjectCreated:Put","s3:ObjectCreated:Post","s3:ObjectCreated:Copy","s3:ObjectCreated:CompleteMultipartUpload"]
    filter_suffix = ".json"
    filter_prefix = "config/"
  }
}

# data "aws_s3_bucket_policy" "source_policy" {
#   bucket = aws_s3_bucket.bucket.id
#   depends_on = [ aws_flow_log.flow_log ]
# }

# output "current_policy_json" {
#   value = data.aws_s3_bucket_policy.source_policy.policy
# }

# data "aws_iam_policy_document" "overraide" {
#   statement {
#     sid    = var.sid-policy-https
#     effect = "Deny"
#     principals {
#       type        = "AWS"
#       identifiers = ["*"]
#     }

#     actions = [
#       "s3:*",
#     ]

#     resources = [
#       aws_s3_bucket.bucket.arn,
#       "${aws_s3_bucket.bucket.arn}/*",
#     ]
#     condition {
#       test     = "Bool"
#       variable = "aws:SecureTransport"
#       values   = ["false"]
#     }
#   }

#    statement {
#     sid    = var.sid-policy-https-test
#     effect = "Deny"
#     principals {
#       type        = "AWS"
#       identifiers = ["*"]
#     }

#     actions = [
#       "s3:*",
#     ]

#     resources = [
#       aws_s3_bucket.bucket.arn,
#       "${aws_s3_bucket.bucket.arn}/*",
#     ]
#     condition {
#       test     = "Bool"
#       variable = "aws:SecureTransport"
#       values   = ["false"]
#     }
#   }
# }

# data "aws_iam_policy_document" "combined" {
#   source_policy_documents = [
#     data.aws_s3_bucket_policy.source_policy.policy,
#     data.aws_iam_policy_document.overraide.json
#   ]
# }

#  #count = "${strcontains(data.aws_s3_bucket_policy.source_policy.policy, "${var.sid-policy-https}") ? 0 : 1}"
#   #count = data.aws_s3_bucket_policy.source_policy == null ? 1 : "${strcontains(data.aws_s3_bucket_policy.source_policy.policy, "${var.sid-policy-https}") ? 0 : 1}"
# resource "aws_s3_bucket_policy" "allow_access_from_another_account" {
#   #count = "${strcontains(data.aws_s3_bucket_policy.source_policy.policy, "${var.sid-policy-https}") ? 0 : 1}"
#   #count = data.aws_s3_bucket_policy.source_policy == null ? 1 : 0
#   #count = data.aws_s3_bucket_policy.source_policy == null ? 1 : "${strcontains(data.aws_s3_bucket_policy.source_policy.policy, "${var.sid-policy-https}") ? 0 : 1}"
#   bucket = aws_s3_bucket.bucket.id
#   policy = data.aws_iam_policy_document.combined.json
# }

# data "aws_iam_policy_document" "combined" {
#   #count = "${strcontains(data.aws_s3_bucket_policy.source_policy.policy, "${var.sid-policy-https}") ? 0 : 1}"
#   count = data.aws_s3_bucket_policy.source_policy == null ? 1 : strcontains(data.aws_s3_bucket_policy.source_policy.policy, var.sid-policy-https) ? 0 : 1
#   source_policy_documents = [
#     data.aws_s3_bucket_policy.source_policy.policy,
#     data.aws_iam_policy_document.overraide.json,
#   ]
# }

# resource "aws_s3_bucket_policy" "allow_access_from_another_account" {
#   count = data.aws_s3_bucket_policy.source_policy == null ? 1 : strcontains(data.aws_s3_bucket_policy.source_policy.policy, var.sid-policy-https) ? 0 : 1

#   bucket = aws_s3_bucket.bucket.id
#   policy = data.aws_iam_policy_document.combined[count.index].json
# }

# locals {
#   combined_policy = jsonencode(merge(jsondecode(data.aws_s3_bucket_policy.source_policy.policy), jsondecode(data.aws_iam_policy_document.overraide.json)))
# }

# locals {
#   current_policy = jsondecode(data.aws_s3_bucket_policy.source_policy.policy)
#   new_policy     = jsondecode(data.aws_iam_policy_document.overraide.json)

#   // Controllo se il SID della nuova policy è già presente nella policy corrente
#   policy_exists = contains([for statement in local.current_policy.Statement : statement.Sid], local.new_policy.Statement[0].Sid)
# }

# // Applica la nuova policy solo se è diversa dalla policy attuale
# resource "aws_s3_bucket_policy" "bucket_policy" {
#   bucket = aws_s3_bucket.bucket.id

#   // Applica la nuova policy solo se il SID non esiste già nella policy corrente
#   policy = local.policy_exists ? data.aws_s3_bucket_policy.source_policy.policy : jsonencode(merge(local.current_policy, local.new_policy))

#   // Dipendenza dalla creazione del bucket stesso
#   depends_on = [aws_s3_bucket.bucket]
# }