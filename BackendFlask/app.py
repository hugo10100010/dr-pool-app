from io import BytesIO
from flask import Flask, abort, jsonify, request, send_file
from flask_jwt_extended import (
    JWTManager, create_access_token, create_refresh_token, get_jwt,
    jwt_required, get_jwt_identity
)
#from flask_cors import CORS
from flask_sqlalchemy import SQLAlchemy
from flask_migrate import Migrate
from datetime import datetime, timedelta
from werkzeug.security import check_password_hash, generate_password_hash
import bcrypt
#from flask import Response
from dotenv import load_dotenv
import os
#import json
#from MySQLdb.cursors import DictCursor

load_dotenv()

db = SQLAlchemy()
migrate = Migrate()

def create_app():
    app = Flask(__name__)

    app.config['SQLALCHEMY_DATABASE_URI'] = f"mysql://{os.getenv('DB_USER')}:{os.getenv('DB_PASSWORD')}@{os.getenv('DB_HOST')}/{os.getenv('DB_NAME')}"
    app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
    app.config['JWT_SECRET_KEY'] = os.getenv('JWT_SECRET_KEY')
    app.config['JWT_ACCESS_TOKEN_EXPIRES'] = timedelta(minutes=20)
    app.config['JWT_REFRESH_TOKEN_EXPIRES'] = timedelta(days=7)

    db.init_app(app)
    migrate.init_app(app,db)
    
    from models import (
        Personales, Cuenta, Metricas, Domicilio, Usuario, 
        Paquete, Subscripcion, Horario, Casillahorario, Clase, Historial
    )

    return app

from models import (
        Personales, Cuenta, Metricas, Domicilio, Usuario, 
        Paquete, Subscripcion, Horario, Casillahorario, Clase, Historial, Curso
    )

from schemas import (
    PersonalesSchema, CuentaSchema, MetricasSchema, DomicilioSchema, UsuarioSchema,
    PaqueteSchema, SubscripcionSchema, HorarioSchema, CasillahorarioSchema, ClaseSchema, HistorialSchema, CursoSchema
)

app = create_app()    

jwt = JWTManager(app)

@app.route("/")
def hello_world():
    return("Hello, world!")

@app.route('/ping', methods=['GET'])
def ping():
    return jsonify({"message": "pong"}), 200

@app.route("/api/login", methods=['POST'])
def login():
    data = request.get_json()
    username = data.get('username')
    password = data.get('password')

    usuario = Usuario.get_usuario_by_nombreusu(username=username)
    schema = UsuarioSchema()

    #print("Entered password:", password)
    #print("Stored hash:", usuario.cuenta.password_hashed)
    #print("Password match:", check_password_hash(usuario.cuenta.password_hashed, password))

    if usuario and bcrypt.checkpw(password.encode(), usuario.cuenta.password_hashed.encode()):
        access_token = create_access_token(identity=str(usuario.id), additional_claims={"rol": usuario.tipousuario})
        refresh_token = create_refresh_token(identity=str(usuario.id), additional_claims={"rol": usuario.tipousuario})
        return jsonify({
            "success": True,
            "message": "Login exitoso",
            "data": {
                "access_token": access_token,
                "refresh_token": refresh_token,
                "data": schema.dump(usuario)
            }
        }), 200

    return jsonify({
        "success":False,
        "message":"Invalid credentials",
        "data": {}
    }),401

@app.route('/api/refresh',methods=['POST'])
@jwt_required(refresh=True)
def refresh():
    identity = get_jwt_identity()
    claims = get_jwt()
    rol = claims.get('rol')
    new_access_token = create_access_token(identity=identity, additional_claims={"rol": rol})

    return jsonify({
        "success": True,
        "message": "Token actualizado",
        "data": {
            "access_token": new_access_token
        }
    }),200

@app.route('/api/usuario/get/<int:id>',methods=['GET'])
@jwt_required()
def get_usuario(id):
    identity = get_jwt_identity()
    claims = get_jwt()
    rol = claims.get('rol')
    if(rol!=1):
        return jsonify({
            "success": False,
            "message": "Forbidden",
        }),403

    usuario = Usuario.query.get_or_404(id)
    identity = get_jwt_identity()
    claims = get_jwt()
    rol = claims.get('rol')
    if identity != str(usuario.id) and rol!=1:
        return jsonify({"message": "Sin autorización."}),403
    
    schema = UsuarioSchema()
    return jsonify({
        "success": True,
        "message": "Usuario recuperado",
        "data": schema.dump(usuario)
    }),200

@app.route('/api/usuario/registrar',methods=['POST'])
def registrar_usuario():
    data = request.get_json()
    
    personales1 = Personales(
        nombre=data['personales']['nombre'],
        apellidop=data['personales']['apellidop'],
        apellidom=data['personales']['apellidom'],
        email=data['personales']['email'],
        telefono=data['personales']['telefono'],
        tipodocumento=data['personales']['tipodocumento'],
        documento=data['personales']['documento']
    )

    cuenta1 = Cuenta(
        nombreusu=data['cuenta']['nombreusu'],
        password_hashed=bcrypt.hashpw(data['cuenta']['password'].encode(), bcrypt.gensalt()).decode()
    )

    metricas1 = Metricas()

    domicilio1 = Domicilio()

    db.session.add(personales1)
    db.session.add(cuenta1)
    db.session.add(metricas1)
    db.session.add(domicilio1)
    db.session.commit()

    usuario1 = Usuario(
        idpersonales=personales1.id,
        idcuenta=cuenta1.id,
        idmetricas=metricas1.id,
        iddomicilio=domicilio1.id,
        tipousuario=2
    )
    db.session.add(usuario1)
    db.session.commit()

    subscripcion1 = Subscripcion(
        idusuario=usuario1.id,
        estado="Inactiva",
        fechaini=datetime.now(),
        fechafin=datetime.now(),
        renovarauto=False,
    )

    db.session.add(subscripcion1)
    db.session.commit()

    return jsonify({
        "success":True,
        "message":"Usuario agregado."
    }),200


@app.route('/api/usuario/agregar',methods=['POST'])
@jwt_required()
def agregar_usuario():
    identity = get_jwt_identity()
    claims = get_jwt()
    rol = claims.get('rol')
    if(rol==1):
        data = request.get_json()
    else:
        return jsonify({
            "success": False,
            "message": "Forbidden",
        }),403

    personales1 = Personales(
        nombre=data['personales']['nombre'],
        apellidop=data['personales']['apellidop'],
        apellidom=data['personales']['apellidom'],
        email=data['personales']['email'],
        telefono=data['personales']['telefono'],
        tipodocumento=data['personales']['tipodocumento'],
        documento=data['personales']['documento']
    )

    cuenta1 = Cuenta(
        nombreusu=data['cuenta']['nombreusu'],
        password_hashed=bcrypt.hashpw(data['cuenta']['password'].encode(), bcrypt.gensalt()).decode()
    )

    metricas1 = Metricas()

    domicilio1 = Domicilio(
        calle=data['domicilio']['calle'],
        numext=data['domicilio']['numext'],
        numint=data['domicilio']['numint'],
        asentamiento=data['domicilio']['asentamiento'],
        codigop=data['domicilio']['codigop']
    )

    db.session.add(personales1)
    db.session.add(cuenta1)
    db.session.add(metricas1)
    db.session.add(domicilio1)
    db.session.commit()

    usuario1 = Usuario(
        idpersonales=personales1.id,
        idcuenta=cuenta1.id,
        idmetricas=metricas1.id,
        iddomicilio=domicilio1.id,
        tipousuario=data['tipousuario']
    )
    db.session.add(usuario1)
    db.session.commit()
    
    if(usuario1.tipousuario==2):
        subscripcion1 = Subscripcion(
            idusuario=usuario1.id,
            estado="Inactiva",
            fechaini=datetime.now(),
            fechafin=datetime.now(),
            renovarauto=False,
        )
        db.session.add(subscripcion1)
        db.session.commit()
    
    schema = UsuarioSchema()

    return jsonify({
        "success":True,
        "data": schema.dump(usuario1),
        "message":"Usuario agregado."
    }),200

@app.route('/api/usuario/getall',methods=['GET'])
@jwt_required()
def get_usuarios():
    identity = get_jwt_identity()
    claims = get_jwt()
    rol = claims.get('rol')

    if(rol==1):
        usuarios = Usuario.query.all()
        schema = UsuarioSchema(many=True)
    elif(rol==3):
        usuarios = Usuario.query\
        .join(Horario, Usuario.id == Horario.idusuario)\
        .join(Clase, Clase.id == Horario.idclase)\
        .filter(Clase.idcoach == identity)\
        .distinct()\
        .all()
        schema = UsuarioSchema(many=True, only=("id","idpersonales","personales","horario"))
    else:
        return jsonify({
            "success": False,
            "message": "Forbidden."
        }),403
    
    return jsonify({
        "success":True,
        "message":"Loaded all usuarios",
        "data": schema.dump(usuarios)
    }),200

@app.route('/api/usuario/eliminar/<int:id>',methods=['DELETE'])
@jwt_required()
def eliminar_usuario(id):
    identity = get_jwt_identity()
    claims = get_jwt()
    rol = claims.get('rol')
    if(rol==1):
        usuario = Usuario.query.filter_by(id=id).first()
    else:
        return jsonify({
            "success": False,
            "message": "Forbidden",
        }),403
    
    db.session.delete(usuario)
    db.session.commit()
    return jsonify({
        "success": True,
        "message": "Borrado con éxito."
    }),200

@app.route('/api/usuario/modificar/<int:id>',methods=['PUT'])
@jwt_required()
def modificar_usuario(id):
    from models import Usuario
    identity = get_jwt_identity()
    claims = get_jwt()
    rol = claims.get("rol")

    if(rol==1):
        usuario = Usuario.query.get_or_404(id)
        data=request.json
    elif(rol==2 or rol==3):
        usuario = Usuario.query.get_or_404(int(identity))
        data=request.json
    else:
        return jsonify({
            "success": False,
            "message": "Forbidden"
        }),403
        
    if 'personales' in data:
        if 'nombre' in data['personales']:
            usuario.personales.nombre = data['personales']['nombre']
        if 'apellidop' in data['personales']:
            usuario.personales.apellidop = data['personales']['apellidop']
        if 'apellidom' in data['personales']:
            usuario.personales.apellidom = data['personales']['apellidom']
        if 'email' in data['personales']:
            usuario.personales.email = data['personales']['email']
        if 'telefono' in data['personales']:
            usuario.personales.telefono = data['personales']['telefono']
        if 'tipodocumento' in data['personales']:
            usuario.personales.tipodocumento = data['personales']['tipodocumento']
        if 'documento' in data['personales']:
            usuario.personales.documento = data['personales']['documento']
    if 'cuenta' in data:
        if 'nombreusu' in data['cuenta']:
            usuario.cuenta.nombreusu = data['cuenta']['nombreusu']
        if 'password' in data['cuenta']:
            if data['cuenta']['password']!="null" and not data['cuenta']['password'] is None:
                usuario.cuenta.password_hashed = bcrypt.hashpw(data['cuenta']['password'].encode(), bcrypt.gensalt()).decode()
        if 'avatar' in data['cuenta']:
            usuario.cuenta.avatar = data['cuenta']['avatar']
    if 'metricas' in data:
        if 'estatura' in data['metricas']:
            usuario.metricas.estatura = data['metricas']['estatura']
        if 'peso' in data['metricas']:
            usuario.metricas.peso = data['metricas']['peso']
        if 'maxcardio' in data['metricas']:
            usuario.metricas.maxcardio = data['metricas']['maxcardio']
        if 'maxpulso' in data['metricas']:
            usuario.metricas.maxpulso = data['metricas']['maxpulso']
        if 'frecuenciasemanal' in data['metricas']:
            usuario.metricas.frecuenciasemanal = data['metricas']['frecuenciasemanal']
    if 'domicilio' in data:
        if 'calle' in data['domicilio']:
            usuario.domicilio.calle = data['domicilio']['calle']
        if 'numext' in data['domicilio']:
            usuario.domicilio.numext = data['domicilio']['numext']
        if 'numint' in data['domicilio']:
            usuario.domicilio.numint = data['domicilio']['numint']
        if 'asentamiento' in data['domicilio']:
            usuario.domicilio.asentamiento = data['domicilio']['asentamiento']
        if 'codigop' in data['domicilio']:
            usuario.domicilio.codigop = data['domicilio']['codigop']
    if 'subscripcion' in data:
        if 'idpaquete' in data['subscripcion']:
            usuario.subscripcion.idpaquete = data['subscripcion']['idpaquete']
            usuario.subscripcion.estado = "Activa"
            usuario.subscripcion.fechaini = datetime.now()
            usuario.subscripcion.fechafin = datetime.now() + timedelta(days=30)
    
    db.session.commit()
    return jsonify({
        "success": True,
        "message": "usuario actualizado correctamente"
    }),200


@app.route('/api/paquete/agregar',methods=['POST'])
@jwt_required()
def agregar_paquete():
    identity = get_jwt_identity()
    claims = get_jwt()
    rol = claims.get("rol")
    
    if(rol==1):
        data = request.get_json()
    else:
        return jsonify({
            "success": False,
            "message": "Forbidden"
        }),403
    
    isFlexible = False

    if 'flexible' in data:
        if(data['flexible']=='true'):
            isFlexible = True
        if(data['flexible']=='false'):
            isFlexible = False

    paquetenew = Paquete(
        precio=data['precio'],
        clases=data['clases'],
        flexible = isFlexible,
    )
    db.session.add(paquetenew)
    db.session.commit()
    return jsonify({
        "success": True,
        "id": paquetenew.id,
        "message": "Paquete agregado"
    }),200

@app.route('/api/paquete/getall',methods=['GET'])
@jwt_required()
def get_paquetes():
    identity = get_jwt_identity()
    claims = get_jwt()
    rol = claims.get("rol")

    paquetes = Paquete.query.all()
    schema = PaqueteSchema(many=True)
    return jsonify({
        "success":True,
        "message":"Obtenido paquetes",
        "data": schema.dump(paquetes)
    }),200

@app.route('/api/paquete/eliminar/<int:id>',methods=['DELETE'])
@jwt_required()
def eliminar_paquete(id):
    identity = get_jwt_identity()
    claims = get_jwt()
    rol = claims.get("rol")

    if(rol==1):
        paquete = Paquete.query.get_or_404(id)
    else:
        return jsonify({
            "success": False,
            "message": "Forbidden"
        }),403
    
    db.session.delete(paquete)
    db.session.commit()
    return jsonify({
        "success": True,
        "message": "Borrado con éxito."
    }),200

@app.route('/api/paquete/modificar/<int:id>',methods=['PUT'])
@jwt_required()
def modificar_paquete(id):
    identity = get_jwt_identity()
    claims = get_jwt()
    rol = claims.get("rol")

    if(rol==1):
        paquete = Paquete.query.get_or_404(id)
        data = request.get_json()
    else:
        jsonify({
            "success": False,
            "message": "Forbidden"
        }),403

    if 'precio' in data:
        paquete.precio = data['precio']
    if 'clases' in data:
        paquete.clases = data['clases']
    if 'flexible' in data:
        if isinstance(data['flexible'], bool):
            paquete.flexible = data['flexible']
        elif isinstance(data['flexible'], str):
            if(data['flexible'] == 'true'):
                paquete.flexible = True
            elif(data['flexible'] == 'false'):
                paquete.flexible = False
        
    db.session.commit()
    return jsonify({
        "success":True,
        "message":"El paquete fue modificado con éxito.",
    }),200

@app.route('/api/casilla/agregar',methods=['POST'])
@jwt_required()
def agregar_casilla():
    identity = get_jwt_identity()
    claims = get_jwt()
    rol = claims.get("rol")
    
    if(rol==1):
        data = request.get_json()
    else:
        return jsonify({
            "success": False,
            "message": "Forbidden."
        }),403
    
    casillanew = Casillahorario(
        horaini=data['horaini'],
        horafin=data['horafin'],
        dia=data['dia'],
    )
    db.session.add(casillanew)
    db.session.commit()
    return jsonify({
        "success": True,
        "id": casillanew.id,
        "message": "Casilla agregada"
    }),200

@app.route('/api/casilla/getall',methods=['GET'])
@jwt_required()
def get_casillas():
    identity = get_jwt_identity()
    claims = get_jwt()
    rol = claims.get("rol")

    if(rol==1 or rol==2):
        casillas = Casillahorario.query.all()
    elif(rol==3):
        casillas = db.session.query(Casillahorario).outerjoin(Casillahorario.clase).filter(Clase.id == None).all()
    else:
        return jsonify({
            "success": False,
            "message": "Forbidden."
        }),403

    schema = CasillahorarioSchema(many=True)
    return jsonify({
        "success":True,
        "message":"Obtenido casillas",
        "data": schema.dump(casillas)
    }),200

@app.route('/api/casilla/eliminar/<int:id>',methods=['DELETE'])
@jwt_required()
def eliminar_casillas(id):
    identity = get_jwt_identity()
    claims = get_jwt()
    rol = claims.get("rol")

    if(rol==1):
        casilla = Casillahorario.query.get_or_404(id)
    else:
        return jsonify({
            "success": False,
            "message": "Forbidden."
        }),403
    
    db.session.delete(casilla)
    db.session.commit()
    return jsonify({
        "success": True,
        "message": "Borrado con éxito."
    }),200

@app.route('/api/casilla/modificar/<int:id>',methods=['PUT'])
@jwt_required()
def modificar_casilla(id):
    identity = get_jwt_identity()
    claims = get_jwt()
    rol = claims.get("rol")

    if(rol==1):
        casilla = Casillahorario.query.get_or_404(id)
        data = request.get_json()
    else:
        return jsonify({
            "success": False,
            "message": "Forbidden."
        }),403

    if 'horaini' in data:
        casilla.horaini = data['horaini']
    if 'horafin' in data:
        casilla.horafin = data['horafin']
    if 'dia' in data:
        casilla.dia = data['dia']
    
    db.session.commit()
    return jsonify({
        "success":True,
        "message":"La casilla fue modificada con éxito.",
    }),200

@app.route('/api/clase/agregar',methods=['POST'])
@jwt_required()
def agregar_clase():
    identity = get_jwt_identity()
    claims = get_jwt()
    rol = claims.get("rol")

    if(rol==1 or rol==3):
        data = request.get_json()
    else:
        return jsonify({
            "success": False,
            "message": "Forbidden."
        }),403
    
    clasenew = Clase(
        idcoach=data['idcoach'],
        idcasilla=data['idcasilla'],
        idcurso=data['idcurso'],
    )
    db.session.add(clasenew)
    db.session.commit()
    return jsonify({
        "success": True,
        "id": clasenew.id,
        "message": "Clase agregada"
    }),200

@app.route('/api/clase/getall',methods=['GET'])
@jwt_required()
def get_clases():
    identity = get_jwt_identity()
    claims = get_jwt()
    rol = claims.get("rol")
    if(rol==1 or rol==2):
        query = Clase.query.join(Casillahorario)
        clases = query.order_by(Casillahorario.dia, Casillahorario.horaini).all()
    elif(rol==3):
        query = Clase.query.join(Casillahorario)
        clases = query.filter(Clase.idcoach == identity).order_by(Casillahorario.dia, Casillahorario.horaini).all()
    else:
        return jsonify({
            "success": False,
            "message": "Forbidden.",
        }), 403
    
    if(rol==2):
        schema = ClaseSchema(many=True,only=("id","idcoach","idcasilla","idcurso","casillahorario","curso","coach.personales.nombre","coach.personales.apellidop"))
    else:
        schema = ClaseSchema(many=True)
    
    return jsonify({
        "success":True,
        "message":"Obtenido clase",
        "data": schema.dump(clases)
    }),200

@app.route('/api/clase/eliminar/<int:id>',methods=['DELETE'])
@jwt_required()
def eliminar_clase(id):
    identity = get_jwt_identity()
    claims = get_jwt()
    rol = claims.get("rol")
    if(rol==1):
        clase = Clase.query.get_or_404(id)
    else:
        return jsonify({
            "success": False,
            "message": "Forbidden.",
        }), 403
    
    db.session.delete(clase)
    db.session.commit()
    return jsonify({
        "success": True,
        "message": "Borrado con éxito."
    }),200

@app.route('/api/clase/modificar/<int:id>',methods=['PUT'])
@jwt_required()
def modificar_clase(id):
    identity = get_jwt_identity()
    claims = get_jwt()
    rol = claims.get("rol")
    if(rol==1):
        clase = Clase.query.get_or_404(id)
        data = request.get_json()
    else:
        return jsonify({
            "success": False,
            "message": "Forbidden.",
        }),403

    if 'idcoach' in data:
        clase.idcoach = data['idcoach']
    if 'idcasilla' in data:
        clase.idcasilla = data['idcasilla']
    if 'idcurso' in data:
        clase.idcurso = data['idcurso']
    
    db.session.commit()
    return jsonify({
        "success":True,
        "message":"La clase fue modificada con éxito.",
    }),200

@app.route('/api/curso/agregar',methods=['POST'])
@jwt_required()
def agregar_curso():
    identity = get_jwt_identity()
    claims = get_jwt()
    rol = claims.get("rol")

    if(rol==1):
        data = request.get_json()
    else:
        return jsonify({
            "success": False,
            "message": "Forbidden"
        }),403
    
    cursonew = Curso(
        curso = data['curso'],
        descripcion = data['descripcion'],
    )
    db.session.add(cursonew)
    db.session.commit()
    return jsonify({
        "success": True,
        "id": cursonew.id,
        "message": "Curso agregado"
    }),200

@app.route('/api/curso/getall',methods=['GET'])
@jwt_required()
def get_cursos():
    identity = get_jwt_identity()
    claims = get_jwt()
    rol = claims.get("rol")
    if(rol==1 or rol==3):
        cursos = Curso.query.all()
    else:
        return jsonify({
            "success": False,
            "message": "Forbidden."
        }),403
    
    schema = CursoSchema(many=True)
    return jsonify({
        "success":True,
        "message":"Obtenido curso",
        "data": schema.dump(cursos)
    }),200

@app.route('/api/curso/eliminar/<int:id>',methods=['DELETE'])
@jwt_required()
def eliminar_curso(id):
    identity = get_jwt_identity()
    claims = get_jwt()
    rol = claims.get("rol")

    if(rol==1):
        curso = Curso.query.get_or_404(id)
    else:
        return jsonify({
            "success": False,
            "message": "Forbidden."
        }),403
    
    db.session.delete(curso)
    db.session.commit()
    return jsonify({
        "success": True,
        "message": "Borrado con éxito."
    }),200

@app.route('/api/curso/modificar/<int:id>',methods=['PUT'])
@jwt_required()
def modificar_curso(id):
    identity = get_jwt_identity()
    claims = get_jwt()
    rol = claims.get("rol")

    if(rol==1):
        curso = Curso.query.get_or_404(id)
        data = request.get_json()
    else:
        return jsonify({
            "success": False,
            "message": "Forbidden.",
        }),403
    
    if 'curso' in data:
        curso.curso = data['curso']
    if 'descripcion' in data:
        curso.descripcion = data['descripcion']
    
    db.session.commit()
    return jsonify({
        "success":True,
        "message":"El curso fue modificado con éxito.",
    }),200

@app.route('/avatar/<string:username>', methods=['GET'])
def get_avatar(username):
    cuenta = Cuenta.query.filter_by(nombreusu=username).first()
    if cuenta and cuenta.avatar:
        return send_file(
            BytesIO(cuenta.avatar),
            mimetype='image/gif',  # Change this if you're using JPEG/PNG
            as_attachment=False,
            download_name=f"{username}_avatar.gif"
        )
    else:
        abort(404, description="Avatar not found.")