resource "aws_route_table_association" "public_assoc" {
  count = length(local.AZ)
  subnet_id = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private_assoc" {
  count = length(local.AZ)
  subnet_id = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private.id
}