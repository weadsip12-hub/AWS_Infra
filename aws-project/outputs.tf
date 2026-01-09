output "check_vpc_id" {
  description = "생성된 VPC ID 확인" # 결과 확인용 설명
  value       = module.network.vpc_id # 모듈이 반환한 VPC ID를 화면에 출력 (예: vpc-12345)
}

output "check_subnet_id" {
  description = "생성된 Subnet ID 확인" # 결과 확인용 설명
  value       = module.network.subnet_id # 모듈이 반환한 Subnet ID를 화면에 출력 (예: subnet-67890)
}