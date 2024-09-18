output "web_route_table_ids" {
  value = aws_route_table.web.id
}

output "app_route_table_ids" {
  value = aws_route_table.app.id
}

output "db_route_table_ids" {
  value = aws_route_table.db.id
}