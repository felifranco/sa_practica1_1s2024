# Instalación
La instalación de Terraform se hará en **Fedora Linux 39 (Workstation Edition)** con la versión de kernel **Linux 6.6.13-200.fc39.x86_64**, por lo que desde la documentación oficial buscaremos el apartado correcto.

Comandos de instalación:
```
sudo dnf install -y dnf-plugins-core
sudo dnf config-manager --add-repo https://rpm.releases.hashicorp.com/fedora/hashicorp.repo
sudo dnf -y install terraform
```
La versión instalada fue:

```
feli@fedora:~$ terraform --version
Terraform v1.7.2
on linux_amd64
```

```
```
