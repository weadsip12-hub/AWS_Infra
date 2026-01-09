# 1. VPC 생성 (가상 데이터센터 구축)
resource "aws_vpc" "this" {
  cidr_block           = var.vpc_cidr               # variables.tf의 'vpc_cidr' 값 사용
  enable_dns_hostnames = true                       # EC2 도메인 이름 허용 (일반적으로 On)
  enable_dns_support   = true                       # DNS 해석 지원 활성화

  tags = {
    Name = "${var.name_prefix}-vpc"                 # 예: "dev-server-vpc" 자동 생성
  }
}

# 2. Subnet 생성 (내부망/VLAN 생성)
resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.this.id         # 위에서 만든 VPC ID 자동 참조
  cidr_block              = var.subnet_cidr         # variables.tf의 'subnet_cidr' 값 사용
  availability_zone       = var.az                  # 리전 위치 지정 (예: ap-northeast-2a)
  map_public_ip_on_launch = true                    # 인스턴스에 공인 IP 자동 할당 (필수)

  tags = {
    Name = "${var.name_prefix}-subnet-pub"
  }
}

# 3. Internet Gateway 생성 (외부 통신용 업링크 연결)
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.this.id                          # 해당 VPC에 게이트웨이 장착

  tags = {
    Name = "${var.name_prefix}-igw"
  }
}

# 4. Route Table 생성 (라우팅 정책 설정)
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"                        # Default Route (모든 트래픽)
    gateway_id = aws_internet_gateway.igw.id        # 타겟: 위에서 만든 IGW로 전송
  }

  tags = {
    Name = "${var.name_prefix}-rt-pub"
  }
}

# 5. Route Table Association (서브넷에 정책 적용/바인딩)
resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id             # 적용할 타겟 서브넷 (Interface)
  route_table_id = aws_route_table.public.id        # 적용할 라우팅 정책 (Table)
}