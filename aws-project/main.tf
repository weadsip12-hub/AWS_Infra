# 1. AWS 공급자 설정
provider "aws" {
  region = var.input_region # tfvars에서 입력받은 리전 변수 적용
}

# 2. 네트워크 모듈 호출
module "network" {
  source = "./modules/network" # modules 폴더 내의 network 코드를 가져옴

  # [왼쪽: 모듈 변수] = [오른쪽: 루트 입력값]
  vpc_cidr    = var.input_vpc_cidr # 입력받은 VPC IP를 모듈로 전달
  subnet_cidr = var.input_subnet_cidr # 입력받은 서브넷 IP를 모듈로 전달
  az          = var.input_az # 입력받은 AZ 정보를 모듈로 전달
  name_prefix = var.input_name_prefix # 입력받은 이름을 모듈로 전달
}