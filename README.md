# TALLER APP WEB DESPLEGADA AUTOMATICAMENTE EN AWS

### Requerimientos previos
1. Instalar docker.
2. Instalar Git.
3. Instalar mvn.
4. Instalar AWS-Cli.

### Componentes de la aplicación
#### Front y Appi Rest
En el repositorio se ecuentra el front y el Api REST que corre con Java Y Spring Boot.
```
puerto: 80
```
### Configuracion incial
1. Clonar este repositorio con git mediante el siguiente comando:
    ```
    git clone https://github.com/LauraMilenaRB/AppAutomaticallyDeployedAWS.git
    ```
2. Desde la raiz **AppAutomaticallyDeployedAWS** ejecutar el archivo docker-compose.yml con el siguiente comando:
   ```
   docker-compose up -d 
   ```
3. Compruebe de manera local que se este ejecutando de manera correcta.
![img.png](imagenes/img.png)

4. Se despliega la imagen en dockerhub con el usuario personal. lauramilenarb/AppDeployedAWS
    ```
      docker tag _AppDeployedAWS:latest lauramilenarb/AppDeployedAWS:latest
      docker push lauramilenarb/AppDeployedAWS:latest
   ```
### Desplegando imagenes en AWS
   1. Primero se configura AWS-Cli. 

      Para crear una nueva configuración ejecute el siguiente comando:
      ```
      aws configure
      ```
      Luego cambie los valores corrrespondientes en *'{...}'* deacuerdo a sus configuraciones y preferencias:
      ```
      AWS Access Key ID [None]: {accesskey}
      AWS Secret Access Key [None]: {secretkey}
      Default region name [None]: {us-west-2}
      Default output format [None]:
      ```
   2. Luego se ejecuta el *'ScriptDespliegueAtomaticoAWS.sh'* para correrlo con la consola bash y que realiza las siguientes acciones:
      1. Crea la llave .pem para generar la conexión. 
      2. Crea el grupo de seguridad.
      3. Añade los permisos al grupo de seguridad para recibir conexiones y peticiones sobre los puertos 22 y 8080.
      4. Crea las 3 instancias EC2.
      5. Consulta la informacion de las instacias creadas y escribe la salida en un archivo json llamado **'infoinstancias.json'**
      6. Por cada instancia se busca el dns en el archivo generado en el paso anterior.
      7. Luego se conecta por ssh a cada instancia, para descargar, iniciar, y ejecutar la imagen desplegada en dockerhub.	
   3. Por ultimo se verifica  que las instancias se esten ejecutando de manera correcta.

