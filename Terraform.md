# Instalación
La instalación de Terraform se hará en **Fedora Linux 39 (Workstation Edition)** con la versión de kernel **Linux 6.6.13-200.fc39.x86_64**, por lo que desde la documentación oficial buscaremos el apartado correcto.
Fuente: [Install | Terraform | HashiCorp Developer](https://developer.hashicorp.com/terraform/install?product_intent=terraform#Linux).



Install dnf config-manager to manage your repositories.
```
$ sudo dnf install -y dnf-plugins-core
```

Use `dnf config-manager` to add the official HashiCorp Linux repository.

```
$ sudo dnf config-manager --add-repo https://rpm.releases.hashicorp.com/fedora/hashicorp.repo
```

Install Terraform from the new repository.

```
$ sudo dnf -y install terraform
```

Show installed version

```
$ terraform --version
Terraform v1.7.2
on linux_amd64
```

# Configuración


### Fuentes:
1. [Qué es Infrastructure as Code? Whiteboarding - IaC Series, Parte 1](https://www.youtube.com/watch?v=7IPeCZAZxjM&t=198s)
2. [Aprendé Terraform en minutos: Explicado más simple, imposible! - IaC Series, Parte 2](https://www.youtube.com/watch?v=e8ke3pi1ROI)
3. [Curso Completo De Terraform | De Principiante A Profesional. Aprende Infraestructura Como Código IaC](https://www.youtube.com/watch?v=Z94DYoF5ufg)
4.