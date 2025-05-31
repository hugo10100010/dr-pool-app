Dr. Pool App es una aplicación móvil desarrollada en Flutter con un backend en Flask, diseñada para gestionar clases, entrenadores y usuarios en un entorno de gimnasio o centro deportivo. La aplicación permite la sincronización de datos entre el dispositivo móvil y el servidor, facilitando la gestión eficiente de las actividades y usuarios.

### Características principales
<ul>
<li>Registro y autenticación de usuarios con JWT.</li>
<li>Gestión de clases, cursos y horarios.</li>
<li>Asignación de entrenadores a clases específicas.</li>
<li>Sincronización de datos entre la aplicación móvil y el backend.</li>
<li>Interfaz intuitiva y fácil de usar.</li>
</ul>


### Tecnologías utilizadas
#### Frontend (Flutter)
<ul>
  <li>Flutter SDK</li>
  <li>Dart</li>
  <li>Provider (para gestión de estado)</li>
  <li>HTTP (para solicitudes al backend)</li>
  <li>Flutter Secure Storage, para almacenamiento de tokens</li>
  <li>Connectivity plus, para verificar si hay conexión a internet</li>
  <li>sqflite, base de datos local</li>
</ul>

#### Backend (Flask)
<ul>
  <li>Flask</li>
  <li>Flask-JWT-Extended (para autenticación)</li>
  <li>SQLAlchemy (ORM)</li>
  <li>SQLite (base de datos)</li>
  <li>Marshmallow</li>
</ul>

### Estructura del proyecto
dr-pool-app/<br>
├── BackendFlask/           # Código fuente del backend en Flask<br>
│   ├── app.py              # Archivo principal de la aplicación Flask<br>
│   ├── models/             # Modelos de la base de datos<br>
│   ├── routes/             # Rutas y controladores<br>
│   └── ...                 # Otros archivos y carpetas relevantes<br>
├── FrontendFlutter/        # Código fuente de la aplicación Flutter<br>
│   ├── lib/                # Código Dart de la aplicación<br>
│   │   ├── models/         # Modelos de datos<br>
│   │   ├── providers/      # Gestión de estado<br>
│   │   ├── services/       # Servicios para interactuar con el backend<br>
│   │   ├── screens/        # Pantallas de la aplicación<br>
│   │   └── main.dart       # Punto de entrada de la aplicación<br>
│   └── ...                 # Otros archivos y carpetas relevantes<br>
└── README.md               # Documentación del proyecto<br>

### Variables de entorno

Crea un archivo `.env` en la raíz del backend basado en el archivo `.env.example`. Debe incluir las siguientes variables:

```env
DB_USER=...
DB_PASSWORD=...
DB_HOST=...
DB_NAME=...
JWT_SECRET_KEY=...
```

### Instalación y ejecución
#### Backend (Flask)
Navega al directorio del backend:
```env
cd BackendFlask
```

Crea y activa un entorno virtual:
```env
python -m venv venv
source venv/bin/activate  # En Windows: venv\Scripts\activate
```

Instala las dependencias:
```env
pip install -r requirements.txt
```

Crea la base de datos 'proyectomovil'

Ejecuta el archivo de inicializacion de la base de datos
```env
py setup.py
```

Ejecuta el archivo de inicializacion de datos (opcional)
```env
py seed.py
```

Ejecuta la aplicación:
```env
flask --debug --app app run --host=0.0.0.0
```

#### Frontend (Flutter)

Navega al directorio del frontend:
```env
cd FrontendFlutter
```

Instala las dependencias:
```env
flutter pub get
```
En Windows, es necesario utilizar modo de desarrollador para descargar algunas dependencias:
```env
start ms-settings:developers
```

Ejecuta la aplicación en un emulador o dispositivo conectado:
```env
flutter run
```

### Autenticación y roles
La aplicación implementa autenticación basada en JWT. Existen diferentes roles de usuario:
<ul>
  <li>Administrador: Acceso completo a todas las funcionalidades.</li>
  <li>Entrenador: Gestión de clases y seguimiento de usuarios asignados.</li>
  <li>Usuario: Visualización de clases y métricas personales.</li>
</ul>

### Sincronización de datos
La aplicación permite la sincronización de datos entre el dispositivo móvil y el backend. Los datos se almacenan localmente en el dispositivo y se sincronizan con el servidor cuando hay conexión a internet, asegurando que la información esté actualizada en ambos extremos.

### Pruebas
#### Backend
Se pueden utilizar herramientas como Postman para probar los endpoints del backend. Asegúrate de incluir el token JWT en las cabeceras de las solicitudes que requieran autenticación.
#### Frontend
Flutter proporciona un marco de pruebas que permite escribir pruebas unitarias y de integración.
