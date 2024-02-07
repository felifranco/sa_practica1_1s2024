# Instalación

To install the full ansible package run:
```
$ sudo dnf install ansible
```

To install the minimal ansible-core package run:
```
$ sudo dnf install ansible-core
```

Verificar la instalación de los paquetes
```
$ ansible --version
ansible [core 2.16.2]
  config file = /etc/ansible/ansible.cfg
  configured module search path = ['/home/feli/.ansible/plugins/modules', '/usr/share/ansible/plugins/modules']
  ansible python module location = /usr/lib/python3.12/site-packages/ansible
  ansible collection location = /home/feli/.ansible/collections:/usr/share/ansible/collections
  executable location = /usr/bin/ansible
  python version = 3.12.1 (main, Dec 18 2023, 00:00:00) [GCC 13.2.1 20231205 (Red Hat 13.2.1-6)] (/usr/bin/python3)
  jinja version = 3.1.3
  libyaml = True 
```

# Configuración

## [Inventario](https://docs.ansible.com/ansible/latest/inventory_guide/intro_inventory.html)

Ver el inventario global
```
$ cat /etc/ansible/hosts
```

Ejecutamos el `módulo (-m)` ping  para verificar. *Comando ad-hoc*.
```
$ ansible localhost -m ping
```

### Hosts locales
Creamos un archivo `hosts`
```
$ touch hosts
```
Agregamos el contenido al archivo en formato `INI`
```
localhost
192.168.0.9
```

Utilizamos el módulo ping con el argumento `-m para módulos`. *Comando ad-hoc*.
```
$ ansible 192.168.0.9 -m ping -i hosts
```

Ejecutar el comando literal, es decir, ad-hoc, en el servidor. Cuando no se coloca el argumento **-m** en la instrucción, ansible ejecuta el módulo predeterminado [Shell](https://docs.ansible.com/ansible/2.9/modules/shell_module.html#shell-module).
```
$ ansible localhost -a 'echo hola'

$ ansible localhost -a 'ls /'

$ ansible localhost -a 'uname'
```

Si se quisiera instalar **vim** en una distribución que utilice paquetería **apt** entonces la siguiente instrucción se podría utilizar en ansible
```
$ ansible localhost -m apt -a 'name= vim state=present' -b -K
```
el parámetro `-b` indica que se utilizará el usuario **root* y `-K` es para que solicite la contraseña en la terminal

### Playbooks

creamos un archivo con extensión `*.yml` con un contenido similar al siguiente:
```
---

- hosts: all
  become: true
  tasks:
  - name: instala vim
    apt: name=vim state=present
  - name: saluda  
    shell: echo hola
```

el parámetro **become** indica que se utilizará *super usuario* para ejecutar las tasks. El atributo become puede ir dentro de una task únicamente, como por ejemplo:
```
---

- hosts: all
  tasks:
  - name: instala vim
    apt: name=vim state=present
    become: true
  - name: saluda  
    shell: echo hola
```

Para ejecutar el nuevo archivo se puede utilizar `ansible-playbook`
```
$ ansible-playbook archivo.yml -K
```

### Módulo [Service](https://docs.ansible.com/ansible/2.9/modules/service_module.html#service-module)

Con éste comando se pueden iniciar/reiniciar/detener servicios desde ansible, entre otros
```
---

- hosts: all
  become: true
  tasks:
  - name: Detener nginx  
    service: name=nginx state=stopped
```
Sería similar a ejecutar el siguiente comando dentro del servidor:
```
$ service nginx stop
```



## Docker
[How to setup SSH on Docker Container to access it remotely](https://www.youtube.com/watch?v=GicWz2OF0sk)
Crear un contenedor nuevo

Creamos el nuevo contenedor con dos puertos abiertos y corriendo en background.
```
$ docker run -it --name ubuntu_ssh -p 8080:80 -p 2200:22 -d ubuntu
```

Accedemos al nuevo contenedor
```
$ docker exec -it ubuntu_ssh bash
```

Actualizamos los repositorios
```
# apt update
```

Instalamos el servidor OpenSSH
```
# apt install openssh-server
```

Verificamos el estado de los servicios, especialmente el del SSH.
```
# service --status-all
```
Notamos que el servicio se encuentra apagado inicialmente, antes de encenderlo se debe cambiar la contraseña del `root` del contenedor para que se pueda acceder desde SSH. Para este ejemplo utilizaremos el valor _"pass"_ como contraseña:
```
# passwd root 
```

También hay que editar el documento de acceso de SSH para que se pueda acceder con `root`. Se puede instalar _nano_ en el contenedor para editar el documento, se asumirá que ya está instalado:
```
# nano /etc/ssh/sshd_config
```

En el archivo buscar la sección `Authentication`, en esa sección buscar el parámetro `PermitRootLogin`, colocar el valor `Yes` para que se pueda iniciar sesión SSH con el usuario root. Se recomienda agregar una nueva línea debajo de la que está comentada en caso que se desee regresar al valor predeterminado:
```
# Authentication:

#PermitRootLogin prohibit-password
PermitRootLogin Yes
```

Ahora sí encender el servicio SSH:
```
# service ssh start
```

Verificamos nuevamente el estado de los servicios y notamos que SSH se encuentra encendido.
```
# service --status-all
```

Desde otra consola probar conexión:
```
ssh root@localhost -p 2200
```

**Error en cambio de huella**. Es posible que al ejecutar el anterior comando en la terminal aparezca un _warning_ con el siguiente mensaje: `WARNING: REMOTE HOST IDENTIFICATION HAS CHANGED!`. Esto ocurre porque el host(contenedor) que se está usando es distinto al que tiene registrado SSH. Se corrige con el siguiente comando que elimina las entradas de ese [host:puerto] del archivo .ssh/known_hosts:
```
$ ssh-keygen -R [localhost]:2200
o
$ ssh-keygen -R 172.17.0.2
```

Aceptamos el fingerprint y listo.

En este punto nuestro contenedor puede ser accedido desde un cliente SSH, eso quiere decir que podríamos ejecutar un comando Ansible y obtendríamos una respuesta. Antes debemos agregar la IP de nuestro contenedor al archivo de hosts global o local.

Para obtener la IP de nuestro contenedor se puede utilizar el siguiente comando, si queremos toda la información se debe retirar el argument `-f` y el formato entre comillas.
```
$ docker inspect -f "{{ .NetworkSettings.IPAddress }}" [container-name-or-id]
```

Archivo de hosts global o inventario global
```
nano /etc/ansible/hosts
```

Utilizaremos un inventario(hosts) local para ejecutar nuestras instrucciones Ansible, para eso creamos el archivo `hosts` y le agregamos la IP de nuestro contenedor en formato `INI`
```
ubuntu_ssh_i ansible_host=172.17.0.2 ansible_connection=ssh ansible_user=root ansible_password=pass
```
Donde `ubuntu_ssh_i` (alias de inventario) y las demás variables servirán para la autenticación SSH.

Ejecutar un comando ad-hoc de ansible
```
$ ansible ubuntu_ssh_i -m ping -i hosts
```
El parámetro `-i` hace referencia a _Inventory_ (hosts). El comando ad-hoc de Ansible fue ejecutado correctamente

### Archivo de automatización
Crearemos el `playbook` en el archivo `nginx_website.yml` con el siguiente contenido inicial para pruebas:
```
---
- hosts: ubuntu_ssh_i
  tasks:
  - name: Actualizar repositorios -> "apt update"
    apt: 
        update-cache: yes
  - name: Saludar
    shell: echo hola
...
```
Se utiliza el estándar opcional para archivos YAML en el que todos los archivos empiezan por tres guiones "---" y terminan en tres puntos "...". Se indica el `host` que se utilizará de nuestro archivo de hosts locales. Se agregaron solo 2 task para la prueba de ejecución.

Ejecutar el playbook
```
$ ansible-playbook nginx_website.yml -i hosts
```

Una vez que la prueba haya finalizado correctamente se modificará el archivo y se creará un playbook completo. El siguiente es un ejemplo de contenido:
```
```



### Fuentes
1. [ANSIBLE: LA REINA DE LA AUTOMATIZACIÓN](https://www.youtube.com/watch?v=yB7oWJbMd3A)
2. [Curso Ansible desde CERO en 5 minutos| Montar una web en 5 minutos Español gratis.](https://www.youtube.com/watch?v=sIysgB2fCjw)
3. [Ansible: Prepara tus servidores con un comando](https://www.youtube.com/watch?v=KOtagN2fRTM)
4. [Installing Ansible on specific operating systems — Ansible Documentation - Fedora Linux](https://docs.ansible.com/ansible/latest/installation_guide/installation_distros.html#installing-ansible-on-fedora-linux)
5. [Ansible – 1. ¿Qué es Ansible?](https://www.youtube.com/watch?v=slNIwBPeQvE&list=PLTd5ehIj0goP2RSCvTiz3-Cko8U6SQV1P)
6. [Ansible – 2. Instalación de Ansible](https://www.youtube.com/watch?v=Zimn-UCbQ0A&list=PLTd5ehIj0goP2RSCvTiz3-Cko8U6SQV1P&index=2)
7. [Ansible – 3. Inventario](https://www.youtube.com/watch?v=VgnidinNlkQ&list=PLTd5ehIj0goP2RSCvTiz3-Cko8U6SQV1P&index=4)
8. [Ansible – 4. Comandos básicos ad-hoc](https://www.youtube.com/watch?v=83DBL6CGNmY&list=PLTd5ehIj0goP2RSCvTiz3-Cko8U6SQV1P&index=5)
9. [Ansible – 5. Comandos ad-hoc para controlar módulos](https://www.youtube.com/watch?v=-MuOmvN1tgY&list=PLTd5ehIj0goP2RSCvTiz3-Cko8U6SQV1P&index=5)
10. [Module Index — Ansible Documentation](https://docs.ansible.com/ansible/2.9/modules/modules_by_category.html)
11. [Ansible – 6. Redactando un playbook](https://www.youtube.com/watch?v=Wuv0ZPOMLf0&list=PLTd5ehIj0goP2RSCvTiz3-Cko8U6SQV1P&index=6)
12. [service – Manage services — Ansible Documentation](https://docs.ansible.com/ansible/2.9/modules/service_module.html#service-module)
13. [Ansible – 7. Conectarse como otro usuario (inciso)](https://www.youtube.com/watch?v=ggTS32i2JmA&list=PLTd5ehIj0goP2RSCvTiz3-Cko8U6SQV1P&index=7)
14. [Ansible – 8. Handlers](https://www.youtube.com/watch?v=G97sqHIG38w&list=PLTd5ehIj0goP2RSCvTiz3-Cko8U6SQV1P&index=9)
15. [Configuring Ansible — Ansible Documentation](https://docs.ansible.com/ansible/latest/installation_guide/intro_configuration.html)
16. [How to build your inventory — Ansible Documentation](https://docs.ansible.com/ansible/latest/inventory_guide/intro_inventory.html)