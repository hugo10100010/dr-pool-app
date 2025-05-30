import enum
from app import db

class MyEnum(enum.Enum):
    Activa = "Activa"
    Inactiva = "Inactiva"
    Suspendida = "Suspendida"

class Subscripcion(db.Model):
    __tablename__ = "subscripcion"

    id = db.Column(db.Integer,primary_key=True)
    idusuario = db.Column(db.Integer,db.ForeignKey('usuario.id'),nullable=False)
    idpaquete = db.Column(db.Integer,db.ForeignKey('paquete.id'))
    estado = db.Column(db.String(10),nullable=False)
    fechaini = db.Column(db.DateTime,nullable=False)
    fechafin = db.Column(db.DateTime,nullable=False)
    renovarauto = db.Column(db.Boolean,nullable=False)

    usuario = db.relationship('Usuario',back_populates='subscripcion',uselist=False)
    paquete = db.relationship('Paquete',back_populates='subscripciones',uselist=False)

    def to_dict(self):
        return {
            "id": self.id,
            "idusuario": self.idusuario,
            "idpaquete": self.idpaquete,
            "estado": self.estado,
            "fechaini": self.fechaini,
            "fechafin": self.fechafin,
            "renovarauto": self.renovarauto,
            "usuario": self.usuario.to_dict() if self.usuario else None,
            "paquete": self.paquete.to_dict() if self.paquete else None
        }