variable "input_vpc_cidr" {
  description = "VPC 생성을 위한 CIDR" # 전체 IP 대역을 받는 변수 (예: 10.0.0.0/16)
  type        = string
}

variable "input_subnet_cidr" {
  description = "Subnet 생성을 위한 CIDR" # 서브넷 IP 대역을 받는 변수 (예: 10.0.1.0/24)
  type        = string
}

variable "input_az" {
  description = "사용할 가용 영역 (AZ)" # 리소스가 배치될 물리적 위치 (예: ap-northeast-2a)
  type        = string
}

variable "input_name_prefix" {
  description = "프로젝트 이름 접두사" # 리소스 이름(Tag) 앞에 붙을 식별자 (예: my-test)
  type        = string
}

variable "input_region" {
  description = "리소스가 생성될 AWS 리전" # AWS 리전 코드 (예: ap-northeast-2)
  type        = string
}