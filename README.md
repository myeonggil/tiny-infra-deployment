# Tiny Infra Deployment

## Rules of definition
```text
1. variables.tf
 - Input parameter in cli
 - This is used in cloud resource
2. output.tf
 - It will print what you want to see in console
 - And you can share resource id each resource
```

## What will you do?
- You need to create main.tf like this
```
module "remote" {
  source = "git::https://github.com/myeonggil/tiny-infra-deployment.git//infra"
  tiny-infra-deployment/infra"
  region = "ap-northeast-2"
  instance_type = "t3.medium"
  vpc_cidr = "10.0.0.0/16"
  service_name = "tiny"
}
```

## 운영 시나리오(DevOps 팀)
1. 리소스를 생성해주세요(DB, EC2, Secret Manager,...)
2. 사용자는 콘솔로 관리하자
3. 리소스를 삭제해주세요
