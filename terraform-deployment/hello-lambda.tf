data "aws_iam_policy_document" "lambda_assume_role_policy" {
    statement {
        effect = "Allow"
        actions = ["sts:AssumeRole"]
        principals {
            type        = "Service"
            identifiers = ["lambda.amazonaws.com"]
        }
    }
}

resource "aws_iam_role" "lambda_role" {
    name               = "lambda_role"
    assume_role_policy = data.aws_iam_policy_document.lambda_assume_role_policy.json
}

resource "aws_iam_role_policy_attachment" "lambda_policy_attachment" {
    role       = aws_iam_role.lambda_role.name
    policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}
data "archive_file" "hello_lambda" {
    type        = "zip"
    source_file = "${path.module}/../src/function.js"
    output_path = "${path.module}/../src/function.zip"
}

resource "aws_s3_object" "hello_lambda" {
    bucket = aws_s3_bucket.lambda_bucket.id
    key    = "function.zip"
    source = data.archive_file.hello_lambda.output_path

    etag = filemd5(data.archive_file.hello_lambda.output_path)
}

resource "aws_lambda_function" "hello_lambda" {
    function_name = "hello_lambda"

    s3_bucket = aws_s3_bucket.lambda_bucket.id
    s3_key    = aws_s3_object.hello_lambda.key
    
    # runtime       = "python3.8"
    # handler       = "hello_lambda.lambda_handler"
    runtime = "nodejs18.x"
    handler       = "function.handler"

    source_code_hash = data.archive_file.hello_lambda.output_base64sha256

    # filename      = "hello_lambda.zip"
    role          = aws_iam_role.lambda_role.arn
  
}

resource "aws_cloudwatch_log_group" "hello_lambda" {
    name = "/aws/lambda/${aws_lambda_function.hello_lambda.function_name}"
  
    # retention_in_days = 30
    retention_in_days = 14
}
