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

```
$ terraform init
```
Folders

Formatear los archivos
```
$ terraform fmt
```

Plan
```
$ terraform plan
```

Aplicar

```
$ terraform apply
```
o también se puede utilizar
```
$ terraform apply -auto-approve
```
esto provoca que se solicite una aprovación para continuar
```
Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: _
```

Destroy
```
$ terraform destroy
```
Al igual que en *apply*, esto permite ejecutar el comando previamente autorizado
```
$ terraform destroy -auto-approve
```

## [Variables](https://developer.hashicorp.com/terraform/language/values/variables)

se utilizó un archivo `*.tfvars` para cargar las variables. 


### Fuentes:
1. [Qué es Infrastructure as Code? Whiteboarding - IaC Series, Parte 1](https://www.youtube.com/watch?v=7IPeCZAZxjM&t=198s)
2. [Aprendé Terraform en minutos: Explicado más simple, imposible! - IaC Series, Parte 2](https://www.youtube.com/watch?v=e8ke3pi1ROI)
3. [Curso Completo De Terraform | De Principiante A Profesional. Aprende Infraestructura Como Código IaC](https://www.youtube.com/watch?v=Z94DYoF5ufg)
4. [Docs overview | hashicorp/aws | Terraform | Terraform Registry](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
5. [aws_instance | Resources | hashicorp/aws | Terraform | Terraform Registry](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance)
6. [Input Variables - Configuration Language | Terraform | HashiCorp Developer](https://developer.hashicorp.com/terraform/language/values/variables)