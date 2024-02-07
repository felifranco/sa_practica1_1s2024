# Ubuntu 22.04.3 LTS
```
$ docker pull ubuntu

$ docker run -it -p 5173:5173 --name ubuntu_test ubuntu /bin/bash

$ docker start ubuntu_test && docker exec -it ubuntu_test /bin/bash

$ apt-get update

$ apt-get install git

$ apt-get install curl

$ curl -fsSL https://deb.nodesource.com/setup_20.x | bash - &&\
apt-get install -y nodejs

$ git clone https://github.com/felifranco/sa_practica1_1s2024.git

$ cd sa_practica1_1s2024/react-vite-sa-pra1/

$ npm i

$ npm run dev
```


/home/git_tmp/sa_practica1_1s2024/react-vite-sa-pra1


http://localhost:5173/


------
## NGINX

```
$ docker run -it --name ubuntu_nginx -p 8080:80 ubuntu

$ apt-get update

$ apt-get install -y nginx

$ docker cp -a /home/feli/Documentos/docker_volumes/dist/. ubuntu_nginx:/var/www/sa_practica1

Crear un nuevo archivo en /etc/nginx/sites-enabled
$ cd /etc/nginx/sites-enabled
```

contenido
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

reinicio
```
$ service nginx restart
```

---

# AWS

## EC2
```
$ apt-get update

$ apt-get install -y nginx

$ ssh -i "sa_pra1_ubuntu_keypair.pem" ubuntu@ec2-54-82-126-186.compute-1.amazonaws.com

$ sftp -i sa_pra1_ubuntu_keypair.pem ubuntu@ec2-54-82-126-186.compute-1.amazonaws.com
```

## Fuentes:
1. [Curso de AWS Desde Cero | Amazon Web Services](https://www.youtube.com/watch?v=zQyrhjEAqLs)