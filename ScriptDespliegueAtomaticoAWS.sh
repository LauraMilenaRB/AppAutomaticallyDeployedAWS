#!/bin/bash
  #1. Crea la llave .pem para generar la conexión.
	aws ec2 create-key-pair --key-name claveAppWebAWS --key-type rsa --query 'KeyMaterial' --output text > claveAppWebAWS.pem
	chmod 400 claveAppWebAWS.pem
	#2. Crea el grupo de seguridad.
	aws ec2 create-security-group --group-name sg-AppWebAWS --description "Security Group AppWebAWS" --vpc-id vpc-061ecbba81df61159
	#3. Añade los permisos al grupo de seguridad para recibir conexiones y peticiones sobre los puertos 22 y 8080.
	aws ec2 authorize-security-group-ingress --group-name sg-AppWebAWS --protocol tcp --port 8080 --cidr 0.0.0.0/0
	aws ec2 authorize-security-group-ingress --group-name sg-AppWebAWS --protocol tcp --port 22 --cidr 0.0.0.0/0
	#4. Crea las 3 instancias EC2.
	aws ec2 run-instances --image-id ami-032930428bf1abbff --count 3 --instance-type t2.micro --key-name claveAppWebAWS --security-groups sg-AppWebAWS
	sleep 100
	#5. Consulta la informacion de las instacias creadas y escribe la salida en un archivo json llamado 'infoinstancias.json'
	aws ec2 describe-instances --filters "Name=instance.group-name,Values=sg-AppWebAWS" --query "Reservations[].Instances[]" > infoinstancias.json
	for (( numinstance=0; numinstance<3; numinstance++ ))
    do
      #6. Por cada instancia se busca el dns en el archivo generado en el paso anterior.
      dns=$(./jq-win64.exe -r '.['$numinstance'].PublicDnsName' infoinstancias.json)
      #7. Se conecta por ssh a cada instancia, para descargar, iniciar, y ejecutar la imagen desplegada en dockerhub.
      ssh -o StrictHostKeyChecking=no -i "claveAppWebAWS.pem" ec2-user@$dns "sudo yum update -y"
      ssh -i "claveAppWebAWS.pem" ec2-user@$dns "sudo yum install -y docker"
      ssh -i "claveAppWebAWS.pem" ec2-user@$dns "sudo usermod -a -G docker ec2-user"
      ssh -i "claveAppWebAWS.pem" ec2-user@$dns "sudo service docker start"
      ssh -i "claveAppWebAWS.pem" ec2-user@$dns "docker run -d -p 8080:8080 --name appdeployed_aws lauramilenarb/appdeployed_aws"
    done
