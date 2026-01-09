# 1. VPC 생성 (가상 데이터센터 구축)
resource "aws_vpc" "this" {
  # variables.tf에서 정의한 'vpc_cidr' 구멍에서 값을 가져옵니다.
  cidr_block = var.vpc_cidr

  # EC2가 도메인 이름을 가질 수 있게 허용 (일반적으로 켜둠)
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    # Name 태그: "입력받은 접두사" + "-vpc" 형태로 이름 자동 생성
    Name = "${var.name_prefix}-vpc"
  }
}

# 2. Subnet 생성 (내부망/VLAN 생성)
resource "aws_subnet" "public" {
  # 위에서 만든 VPC ID를 자동으로 가져와서 소속시킴
  vpc_id = aws_vpc.this.id

  # variables.tf의 'subnet_cidr' 값 사용
  cidr_block = var.subnet_cidr

  # 서울 리전 A존, C존 등 위치 지정
  availability_zone = var.az

  # 서버 생성 시 공인 IP 자동 할당 (퍼블릭 서브넷 필수 옵션)
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.name_prefix}-subnet-pub"
  }
}

# 3. Internet Gateway 생성 (외부 통신용 업링크 연결)
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name = "${var.name_prefix}-igw"
  }
}

# 4. Route Table 생성 (라우팅 정책 설정)
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id

  # Default Route: 모든 트래픽(0.0.0.0/0)을 IGW로 보냄
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "${var.name_prefix}-rt-pub"
  }
}

# 5. Route Table Association (서브넷에 정책 적용)
# 만든 라우팅 테이블을 서브넷에 바인딩(Binding)
resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}