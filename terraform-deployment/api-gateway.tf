# resource "aws_apigatewayv2_api" "main" {
#     name          = "main"
#     protocol_type = "HTTP"
# }
# resource "aws_apigatewayv2_stage" "dev" {
#     api_id = aws_apigatewayv2_api.main.id
    
#     name   = "dev"

#     auto_deploy = true

#     access_log_settings {
#         destination_arn = aws_cloudwatch_log_group.api_gw.arn

#         format = jsonencode({
#             requestId               = "$context.requestId"
#             sourceIp                = "$context.identity.sourceIp"
#             httpMethod              = "$context.httpMethod"
#             resourcePath            = "$context.resourcePath"
#             routeKey                = "$context.routeKey"
#             status                  = "$context.status"
#             responseLength          = "$context.responseLength"
#             integrationErrorMessage = "$context.integrationErrorMessage"
#             }
#         )
#     }
# }
