variable "vpc_cidr" {
  description = "VPC 생성을 위한 CIDR Block" # 예: 10.0.0.0/16
  type        = string
}

variable "subnet_cidr" {
  description = "Public Subnet 생성을 위한 CIDR Block" # 예: 10.0.1.0/24
  type        = string
}

variable "az" {
  description = "리소스가 생성될 가용 영역 (Availability Zone)" # 예: ap-northeast-2a
  type        = string
}

variable "name_prefix" {
  description = "리소스 태그(Name) 생성을 위한 접두사" # 예: dev-server
  type        = string
}