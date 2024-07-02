<a name="readme-top"></a>

<!-- TABLE OF CONTENTS -->

# 📗 Table of Contents

- [📖 Link del Frontend](#frontend-link)
- [📖 Acerca del Projecto](#about-project)
  - [🛠 Built With](#built-with)
    - [Tech Stack](#tech-stack)
    - [Características Principales ](#key-features)
- [💻 Para empezar](#getting-started)
  - [Instalacion](#install)
  - [Uso](#usage)
- [👥 Autor](#authors)

<!-- FRONTEND LINK -->

# 📖 Link del Frontend <a name="frontend-link"></a>

- [**Link del Frontend**](https://github.com/IsmaelMastronardi/nala-frontend)

<!-- PROJECT DESCRIPTION -->

# 📖 Api de Ausencias <a name="about-project"></a>

**Api de Ausencias** 

## 🛠 Construido con <a name="built-with"></a>

### Tech Stack <a name="tech-stack"></a>

<details>
  <summary>Server</summary>
  <ul>
    <li><a href="https://rubyonrails.org/">Ruby on Rails</a></li>
  </ul>
</details>

<details>
<summary>Database</summary>
  <ul>
    <li><a href="https://www.postgresql.org/">PostgreSQL</a></li>
  </ul>
</details>

<!-- Features -->

### Características Principales   <a name="key-features"></a>

- **Autenticacion de usuario con JWT**
- **Permite añadir empleados y pedidos de ausencia**
- **Permite saber la cantidad de dias de vacaciones que se ha tomado un empleado**

<p align="right">(<a href="#readme-top">back to top</a>)</p>


<!-- GETTING STARTED -->

## 💻 Getting Started <a name="getting-started"></a>

Para una copia local del projecto, debes:

### Install <a name="install"></a>

1. Instalar con:

```sh
  bundle install
  npm install
```

2. Borrar credentials.yml.enc

3. Generar una secret key, usando:

```sh
  bundle exec rake secret
```

o usando:
```sh
  rails secret
```

4. Generar una nuevas credenciales y master key usando:

```sh
  EDITOR='code --wait' rails credentials:edit
```

5. Añadir 'devise_jwt_secret_key:' con el valor de la secret key

6. Cerrar la ventana para guardar la nueva configuracion
### Usage <a name="usage"></a>

Para correr el projecto:
```sh
  rails db:create
```

```sh
  rails db:migrate
```

Para inicial el servidor:

```sh
  rails s
```

<!-- AUTHORS -->

## 👥 Autor <a name="authors"></a>

👤 **Ismael Mastronardi**

- GitHub: [IsmaelMastronardi](https://github.com/IsmaelMastronardi)
- LinkedIn: [Ismael Mastronardi](https://www.linkedin.com/in/ismael-mastronardi-361873271/)

<p align="right">(<a href="#readme-top">back to top</a>)</p>
