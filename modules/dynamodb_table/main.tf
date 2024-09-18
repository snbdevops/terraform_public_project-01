# resource "aws_dynamodb_table" "state_lock" {
#   name           = var.table_name
#   hash_key       = "LockID"
#   read_capacity  = 5
#   write_capacity = 5
#   attribute {
#     name = "LockID"
#     type = "S"
#   }
# }