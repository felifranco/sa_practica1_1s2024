# Práctica 1 para el curso Software Avanzado. Primer Semestre 2024.

## Objetivos Específicos
* Comprender el uso de Terraform para aprovisionar infraestructura en la nube.
* Aprender a automatizar la configuración de servidores con Ansible.
* Implementar monitoreo y logs para mantener un entorno de despliegue saludable.

## Descripción
En esta práctica se solicitará la creación de una pequeña página web estática que mostrará información específica del alumno, como:
* Número de carne,
* Nombres y apellidos,
* Hora y fecha actual.

La página deberá tener un diseño simple pero estilizado, haciendo uso de CSS o una librería de estilos.
El objetivo principal es subir esta página web a un proveedor de nube (se recomienda AWS o GCP, pero se permite elegir otro proveedor). Para lograr esto, se utilizará **Terraform** para la creación y configuración de instancias virtuales en las que funcionará el servidor.
Posteriormente, mediante el uso de **Ansible**, se instalará y configurará Nginx, un servidor de entrega de contenido web, que permitirá desplegar la página web.

## Sitio Web
Se creó un sitio web con ReactJS y Vite, los detalles se pueden encontrar en el archivo [Site.md](Site.md).

## Terraform
Se utilizó Terraform para crear la infraestructura de la práctica, los detalles de la instalación y los archivos de configuración se pueden encontrar en [Terraform.md](Terraform.md).

## Ansible
Para generar el archivo `*.yml` final, se utilizó Docker y el equipo local, cuando ya se tenía una versión funcional del archivo local se hicieron unas pequeñas modificaciones para que pudiera ser utilizado en EC2 y la nueva infraestructura. Más detalles en [Ansible.md](Ansible.md).

## Docker
Docker fue fundamental en la realización de ésta práctica, se utilizó para emular el funcionamiento de EC2 tanto para `Ansible` como para `Terraform`. Se puede encontrar la documentación en [Docker.md](Docker.md) y en el archivo [terraform_docker/local.tf](terraform_docker/local.tf).
