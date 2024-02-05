# Proyecto Vite + React
Crear un proyecto Vite, si el paquete de Vite no se encuentra instalado pedirá que se instale antes. Se colocará el nombre `react-vite-sa-pra1` al proyecto
```
$ npm init vite@latest
✔ Project name: … react-vite-sa-pra1
✔ Select a framework: › React
✔ Select a variant: › JavaScript

Scaffolding project in /home/feli/Documentos/Repos/GitHub/sa_practica1_1s2024/react-vite-sa-pra1...

Done. Now run:

  cd react-vite-sa-pra1
  npm install
  npm run dev
```

Ingresar a la carpeta recién creada e instalar los paquetes iniciales del proyecto
```
$ cd react-vite-sa-pra1
$ npm i
```

Realizamos las modificaciones necesarias a las páginas `*.jsx` del proyecto para agregar los datos que solicita la práctica 1.

Al finalizar los cambios ejecutaremos el proyecto con el script `dev` de vite.
```
$ npm run dev
```

Para hacer un lanzamiento a *producción* o un empaquetado final y óptimo de la solución se debe de generar el recurso:
```
$ npm run build
```

y luego se puede dar una vista previa del recurso generado

```
$ npm run preview
```

### Fuentes
1. [¿QUÉ hace VITE en REACT? ⚡¿Cómo funciona un DEV SERVER? 🔵 Curso de React desde cero #3](https://www.youtube.com/watch?v=J_ZmtP9xNg8) 