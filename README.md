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
puerto: 8080
```
### Configuracion incial
1. Clonar este repositorio con git mediante el siguiente comando:
    ```
    git clone https://github.com/LauraMilenaRB/AppAutomaticallyDeployedAWS.git
    ```
2. Ubicado en la carpeta raiz AppAutomaticallyDeployedAWS construir el ejecutable mediante los siguientes comandos:
    ```
    cd AppAutomaticallyDeployedAWS
    mvn package
    ```
3. Desde la raiz **AppAutomaticallyDeployedAWS** ejecutar el archivo docker-compose.yml con el siguiente comando:
   ```
   docker-compose up -d 
   ```
4. Compruebe de manera local que se este ejecutando de manera correcta.
   ![img.png](imagenes/img.png)

5. Luego despliegue la imagen en dockerhub con el usuario personal. En este caso con lauramilenarb/AppDeployedAWS
   ```
   docker tag appautomaticallydeployedaws_appdeployed_aws:latest lauramilenarb/appdeployed_aws:latest
   docker push lauramilenarb/appdeployed_aws:latest
   ```
   ![img2.png](imagenes/img2.png)
### Desplegando instancias automaticas en AWS
   1. Primero se configura AWS-Cli. 

      Para crear una nueva configuración ejecute el siguiente comando:
      ```
      aws configure
      ```
      Luego cambie los valores corrrespondientes en *'{...}'* deacuerdo a sus configuraciones y preferencias:
      ```
      AWS Access Key ID [None]: {accesskey}
      AWS Secret Access Key [None]: {secretkey}
      Default region name [None]: {us-east-1}
      Default output format [None]:
      ```
      Para mi cuenta estudiantil los datos requeridos se ven de la siguiente manera:
      ![img3.png](imagenes/img3.png)  
   2. Luego se ejecuta el *'ScriptDespliegueAtomaticoAWS.sh'* para correrlo con la consola bash ejecute el siguiente comando:
      ```
      ./ScriptDespliegueAtomaticoAWS.sh
      ```
      El script realiza las siguientes acciones:
      ![img1.png](imagenes/img1.png)

   3. Por ultimo se verifique  que las instancias se esten ejecutando de manera correcta.
      ![img4.png](imagenes/img4.png)
      ![img5.png](imagenes/img5.png)

