#!/bin/bash
	aws ec2 create-key-pair --key-name claveAppWebAWS --query 'KeyMaterial' --output text > claveAppWebAWS.pem
	chmod 400 claveAppWebAWS.pem
	aws ec2 create-security-group --group-name sg-AppWebAWS --description "Security Group AppWebAWS" --vpc-id vpc-2c361a56
	aws ec2 authorize-security-group-ingress --group-name sg-AppWebAWS --protocol tcp --port 8080 --cidr 0.0.0.0/0
	aws ec2 authorize-security-group-ingress --group-name sg-AppWebAWS --protocol tcp --port 22 --cidr 0.0.0.0/0
	aws ec2 run-instances --image-id ami-032930428bf1abbff --count 3 --instance-type t2.micro --key-name claveAppWebAWS --security-groups sg-cli-AppWebAWS
	sleep 90
	aws ec2 describe-instances --filters "Name=instance.group-name,Values=sg-AppWebAWS" --query "Reservations[].Instances[]" > infoinstancias.json
	for (( numinstance=0; numinstance<3; numinstance++ ))
    do
      dns=$(./jq-win64.exe -r '.['$numinstance'].PublicDnsName' infoinstancias.json)
      ssh -o StrictHostKeyChecking=no -i "claveAppWebAWS.pem" ec2-user@$dns "sudo yum update -y"
      ssh -i "claveAppWebAWS.pem" ec2-user@$dns "sudo yum install -y docker"
      ssh -i "claveAppWebAWS.pem" ec2-user@$dns "sudo usermod -a -G docker ec2-user"
      ssh -i "claveAppWebAWS.pem" ec2-user@$dns "sudo service docker start"
      ssh -i "claveAppWebAWS.pem" ec2-user@$dns "docker run -d -p 8080:8080 --name AppDeployedAWS lauramilenarb/AppDeployedAWS"
    done