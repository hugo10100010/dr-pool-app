from app import create_app, db
from models import Personales,Cuenta,Domicilio,Metricas,Usuario,Paquete,Subscripcion,Casillahorario,Horario,Clase,Historial, Curso
from werkzeug.security import generate_password_hash
from datetime import datetime, timedelta
import bcrypt

app = create_app()

with app.app_context():
    with open("assets/avatar1.gif","rb") as image:
        avatar_data = image.read()

    personales1 = Personales(
        nombre="Komori",
        apellidop="Chan",
        apellidom="San",
        email="kumchan@gmail.com",
        telefono="4818889999",
        tipodocumento="CURP",
        documento="KUMCHACHACHACHAN"
    )

    cuenta1 = Cuenta(
        nombreusu="VH33",
        password_hashed=bcrypt.hashpw("VH33".encode(), bcrypt.gensalt()).decode(),
        avatar=avatar_data
    )

    metricas1 = Metricas(
        estatura=1.74,
        peso=114.72,
        maxcardio=0.0,
        maxpulso=0,
        frecuenciasemanal=0
    )

    domicilio1 = Domicilio(
        calle="Calle kum",
        numext=6666,
        numint=1,
        asentamiento="Montencillos",
        codigop=79032
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
        tipousuario=2
    )

    db.session.add(usuario1)
    db.session.commit()
    
    with open("assets/avatar2.gif","rb") as image:
        avatar_data2 = image.read()

    personales2 = Personales(
        nombre="Alfonso",
        apellidop="Ramono",
        apellidom="Del Toro",
        email="alfonso@gmail.com",
        telefono="4817778888",
        tipodocumento="CURP",
        documento="ALFONSORAMON"
    )

    cuenta2 = Cuenta(
        nombreusu="21690447",
        password_hashed=bcrypt.hashpw("21690447".encode(), bcrypt.gensalt()).decode(),
        avatar=avatar_data2
    )

    metricas2 = Metricas(
        estatura=1.68,
        peso=103.12,
        maxcardio=1.0,
        maxpulso=1,
        frecuenciasemanal=1
    )

    domicilio2 = Domicilio(
        calle="Donde acuchillan",
        numext=213,
        numint=12,
        asentamiento="El carmen",
        codigop=79053
    )

    db.session.add(personales2)
    db.session.add(cuenta2)
    db.session.add(metricas2)
    db.session.add(domicilio2)
    db.session.commit()

    usuario2 = Usuario(
        idpersonales=personales2.id,
        idcuenta=cuenta2.id,
        idmetricas=metricas2.id,
        iddomicilio=domicilio2.id,
        tipousuario=1
    )

    db.session.add(usuario2)
    db.session.commit()

    with open("assets/avatar3.gif","rb") as image:
        avatar_data3 = image.read()

    personales3 = Personales(
        nombre="Hugo",
        apellidop="Hugo",
        apellidom="Hugo",
        email="hugo@gmail.com",
        telefono="4814814814",
        tipodocumento="CURP",
        documento="HUGO"
    )

    cuenta3 = Cuenta(
        nombreusu="HUGO",
        password_hashed=bcrypt.hashpw("HUGO".encode(), bcrypt.gensalt()).decode(),
        avatar=avatar_data3
    )

    metricas3 = Metricas(
        estatura=1.92,
        peso=104.71,
        maxcardio=30.0,
        maxpulso=200,
        frecuenciasemanal=2
    )

    domicilio3 = Domicilio(
        calle="Calle",
        numext=1,
        numint=1,
        asentamiento="Asentamiento",
        codigop=11111
    )

    db.session.add(personales3)
    db.session.add(cuenta3)
    db.session.add(metricas3)
    db.session.add(domicilio3)
    db.session.commit()

    usuario3 = Usuario(
        idpersonales=personales3.id,
        idcuenta=cuenta3.id,
        idmetricas=metricas3.id,
        iddomicilio=domicilio3.id,
        tipousuario=3
    )

    db.session.add(usuario3)
    db.session.commit()

    paquete1 = Paquete(
        precio=299.99,
        clases = 3,
        flexible = True,
    )

    paquete2 = Paquete(
        precio=399.99,
        clases = 4,
        flexible = True,
    )

    paquete3 = Paquete(
        precio=499.99,
        clases = 5,
        flexible = True,
    )

    paquete4 = Paquete(
        precio=199.99,
        clases = 3,
        flexible = False,
    )

    paquete5 = Paquete(
        precio=299.99,
        clases = 4,
        flexible = False,
    )

    paquete6 = Paquete(
        precio=399.99,
        clases = 5,
        flexible = False,
    )

    db.session.add(paquete1)
    db.session.add(paquete2)
    db.session.add(paquete3)
    db.session.add(paquete4)
    db.session.add(paquete5)
    db.session.add(paquete6)
    db.session.commit()

    subscripcion1 = Subscripcion(
        idusuario=usuario1.id,
        idpaquete=paquete1.id,
        estado="Activa",
        fechaini=datetime.now(),
        fechafin=datetime.now(),
        renovarauto=True
    )
    for i in range(7):
        for j in range(12):
            casilla = Casillahorario(
                horaini=f"{str(j+8).zfill(2)}:00",
                horafin=f"{str(j+9).zfill(2)}:00",
                dia=i+1
            )
            db.session.add(casilla)

    
    db.session.commit()

    

    curso1 = Curso(
        curso="Fitness",
        descripcion="Curso de fitness",
    )
    curso2 = Curso(
        curso="Fitness Version 2",
        descripcion="Curso de fitness alternativo",
    )

    db.session.add(subscripcion1)
    db.session.add(curso1)
    db.session.add(curso2)
    db.session.commit()

    clase1 = Clase(
        idcoach=usuario3.id,
        idcasilla=6,
        idcurso=curso1.id,
    )

    clase2 = Clase(
        idcoach=usuario3.id,
        idcasilla=21,
        idcurso=curso2.id,
    )

    clase3 = Clase(
        idcoach=usuario3.id,
        idcasilla=12,
        idcurso=curso1.id,
    )
    
    clase4 = Clase(
        idcoach=usuario3.id,
        idcasilla=33,
        idcurso=curso2.id,
    )

    clase5 = Clase(
        idcoach=usuario3.id,
        idcasilla=47,
        idcurso=curso1.id,
    )

    clase6 = Clase(
        idcoach=usuario3.id,
        idcasilla=58,
        idcurso=curso2.id,
    )

    historial1 = Historial(
        idusuario=usuario1.id,
        idpaquete=paquete1.id,
        fechaini=datetime.now()-timedelta(days=100),
        fechafin=datetime.now()-timedelta(days=130),
        metodo="EFECTIVO"
    )
    historial2 = Historial(
        idusuario=usuario1.id,
        idpaquete=paquete2.id,
        fechaini=datetime.now()-timedelta(days=200),
        fechafin=datetime.now()-timedelta(days=230),
        metodo="EFECTIVO"
    )
    historial3 = Historial(
        idusuario=usuario1.id,
        idpaquete=paquete3.id,
        fechaini=datetime.now()-timedelta(days=300),
        fechafin=datetime.now()-timedelta(days=330),
        metodo="EFECTIVO"
    )
    historial4 = Historial(
        idusuario=usuario1.id,
        idpaquete=paquete4.id,
        fechaini=datetime.now()-timedelta(days=400),
        fechafin=datetime.now()-timedelta(days=430),
        metodo="EFECTIVO"
    )
    
    db.session.add(clase1)
    db.session.add(clase2)
    db.session.add(clase3)
    db.session.add(clase4)
    db.session.add(clase5)
    db.session.add(clase6)
    db.session.add(historial1)
    db.session.add(historial2)
    db.session.add(historial3)
    db.session.add(historial4)
    db.session.commit()

    horario1 = Horario(
        idusuario = usuario1.id,
        idclase = clase1.id,
    )
    horario2 = Horario(
        idusuario = usuario1.id,
        idclase = clase2.id,
    )
    horario3 = Horario(
        idusuario = usuario1.id,
        idclase = clase3.id,
    )

    
    db.session.add(horario1)
    db.session.add(horario2)
    db.session.add(horario3)
    db.session.commit()

    personales4 = Personales(
        nombre="victoro",
        apellidop="w",
        apellidom="kum",
        email="kum@mail.com",
        telefono="4443332222",
        tipodocumento="CURP",
        documento="AAAAAAAAAA"
    )

    cuenta4 = Cuenta(
        nombreusu="ELKUM",
        password_hashed=bcrypt.hashpw("ELKUM".encode(), bcrypt.gensalt()).decode(),
    )

    metricas4 = Metricas()

    domicilio4 = Domicilio()

    db.session.add(personales4)
    db.session.add(cuenta4)
    db.session.add(metricas4)
    db.session.add(domicilio4)
    db.session.commit()

    usuario4 = Usuario(
        idpersonales=personales4.id,
        idcuenta = cuenta4.id,
        idmetricas = metricas4.id,
        iddomicilio = domicilio4.id,
        tipousuario=2
    )

    db.session.add(usuario4)
    db.session.commit()

    subscripcion2 = Subscripcion(
        idusuario=usuario4.id,
        estado="Inactiva",
        fechaini=datetime.now(),
        fechafin=datetime.now(),
        renovarauto=False
    )

    db.session.add(subscripcion2)
    db.session.commit()

    print("Generado con exito.")