import enum
from app import db

class Personales(db.Model):
    __tablename__ = 'personales'

    id = db.Column(db.Integer,primary_key=True)
    nombre = db.Column(db.String(25),nullable=False)
    apellidop = db.Column(db.String(20),nullable=False)
    apellidom = db.Column(db.String(20),nullable=False)
    email = db.Column(db.String(50),unique=True,nullable=False)
    telefono = db.Column(db.String(10),nullable=False)
    tipodocumento = db.Column(db.String(10),nullable=False)
    documento = db.Column(db.String(30),unique=True,nullable=False)

    usuario = db.relationship('Usuario',back_populates='personales',uselist=False)

    def to_dict(self):
        return {
            "id": self.id,
            "nombre": self.nombre,
            "apellidop": self.apellidop,
            "apellidom": self.apellidom,
            "email": self.email,
            "telefono": self.telefono,
            "tipodocumento": self.tipodocumento,
            "documento": self.documento,
            #"usuario": self.usuario.to_dict() if self.usuario else None
        }
    
    