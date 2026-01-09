# variables.tf
variable "aws_access_key" {
  description = "AWS Access Key"
  type        = string
  sensitive   = true  # 테라폼 로그에 키값이 노출되지 않게 막음
}

variable "aws_secret_key" {
  description = "AWS Secret Key"
  type        = string
  sensitive   = true
}

variable "aws_region" {
  default = "ap-northeast-2"
}