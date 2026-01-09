# 1. VPC ID 내보내기
output "vpc_id" {
  value       = aws_vpc.this.id       # main.tf에서 만든 VPC 리소스의 실제 ID (예: vpc-0a1b2c...)
  description = "생성된 VPC ID"       # 다른 모듈(보안그룹 등)에서 참조할 때 사용
}

# 2. Subnet ID 내보내기
output "subnet_id" {
  value       = aws_subnet.public.id  # main.tf에서 만든 Subnet 리소스의 실제 ID
  description = "생성된 Subnet ID"    # EC2 인스턴스가 배치될 위치 정보
}