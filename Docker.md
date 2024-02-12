# Docker

## Crear contenedor con sitio web
Descargamos la última imagen de Ubuntu
```
$ docker pull ubuntu
```

Creamos un contenedor utilizando la imagen descargada. El puerto 5173 es el que utilizará Vite para levantar el sitio web.
```
$ docker run -it -p 5173:5173 --name ubuntu_test ubuntu /bin/bash
```

Encendemos el contenedor
```
$ docker start ubuntu_test && docker exec -it ubuntu_test /bin/bash
```

Dentro del contenedor ejecutamos los siguientes comandos. Aquí se descarga el código fuente de la página, se instala git y se compila con Vite

Actualizamos repositorios locales
```
$ apt-get update
```

Instalamos Git
```
$ apt-get install git
```

Instalar NodeJS
```
$ apt-get install curl

$ curl -fsSL https://deb.nodesource.com/setup_20.x | bash - &&\
apt-get install -y nodejs
```

Descargar el repositorio desde GitHub
```
$ git clone https://github.com/felifranco/sa_practica1_1s2024.git
```

Ingresar al código fuente
```
$ cd sa_practica1_1s2024/react-vite-sa-pra1/
```

Instalar los paquetes del proyecto con npm
```
$ npm i
```

Ejecutar con Vite:
```
$ npm run dev
```

## Instalar Nginx

Crear un nuevo contenedor
```
$ docker run -it --name ubuntu_nginx -p 8080:80 ubuntu
```

Dentro del contenedoe ejecutar los siguientes comandos para instalar Nginx:
```
$ apt-get update

$ apt-get install -y nginx
```

Copiar el empaquetado final del sitio web hacia el contenedor
```
$ docker cp -a /home/feli/Documentos/docker_volumes/dist/. ubuntu_nginx:/var/www/sa_practica1
```

Crear un nuevo archivo en /etc/nginx/sites-enabled
```
$ cd /etc/nginx/sites-enabled
```

contenido del archivo
```
server {
       listen 80;
       listen [::]:80;

       #server_name example.ubuntu.com;

       root /var/www/sa_practica1;
       index index.html;

       location / {
               try_files $uri $uri/ =404;
       }
}
```

Reiniciar el servicio de Nginx
```
$ service nginx restart
```
# AWS
Crear un equipo en EC2 y probar los comandos

## EC2
```
$ apt-get update

$ apt-get install -y nginx
```

Conectarse al equipo remoto
```
$ ssh -i "sa_pra1_ubuntu_keypair.pem" ubuntu@ec2-54-82-126-186.compute-1.amazonaws.com

$ sftp -i sa_pra1_ubuntu_keypair.pem ubuntu@ec2-54-82-126-186.compute-1.amazonaws.com
```

## Fuentes AWS:
1. [Curso de AWS Desde Cero | Amazon Web Services](https://www.youtube.com/watch?v=zQyrhjEAqLs)