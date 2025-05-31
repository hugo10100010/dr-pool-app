from app import db
from werkzeug.security import generate_password_hash, check_password_hash

from .cuenta import Cuenta

class Usuario(db.Model):
    __tablename__ = 'usuario'

    id = db.Column(db.Integer, primary_key=True)
    idpersonales = db.Column(db.Integer,db.ForeignKey('personales.id'),unique=True)
    idcuenta = db.Column(db.Integer,db.ForeignKey('cuenta.id'),unique=True)
    idmetricas = db.Column(db.Integer,db.ForeignKey('metricas.id'),unique=True)
    iddomicilio = db.Column(db.Integer,db.ForeignKey('domicilio.id'),unique=True)
    tipousuario = db.Column(db.Integer,nullable=False)

    cuenta = db.relationship('Cuenta',back_populates='usuario',uselist=False,cascade="all, delete")
    personales = db.relationship('Personales',back_populates='usuario',uselist=False, cascade="all, delete")
    metricas = db.relationship('Metricas',back_populates='usuario',uselist=False,cascade="all, delete")
    domicilio = db.relationship('Domicilio',back_populates='usuario',uselist=False,cascade="all, delete")
    subscripcion = db.relationship('Subscripcion',back_populates='usuario',uselist=False,cascade="all, delete")
    clases = db.relationship('Clase', back_populates='coach', lazy=True)
    horario = db.relationship('Horario', back_populates='alumno',lazy=True)
    historial = db.relationship('Historial',back_populates='usuario',lazy=True,cascade="all, delete")

    def get_usuario_by_nombreusu(username):
        usuario = Usuario.query.filter(Usuario.cuenta.has(Cuenta.nombreusu == username)).first()

        if usuario:
            return usuario
        else:
            return None
