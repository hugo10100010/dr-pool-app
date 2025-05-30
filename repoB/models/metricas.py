from app import db
from sqlalchemy.dialects.mysql import DECIMAL

class Metricas(db.Model):
    __tablename__ = "metricas"

    id = db.Column(db.Integer,primary_key=True)
    estatura = db.Column(DECIMAL(3,2))
    peso = db.Column(DECIMAL(5,2))
    maxcardio = db.Column(DECIMAL(4,2))
    maxpulso = db.Column(db.Integer)
    frecuenciasemanal = db.Column(db.Integer)

    usuario = db.relationship('Usuario',back_populates='metricas',uselist=False)

    def to_dict(self):
        return {
            "id": self.id,
            "estatura": self.estatura,
            "peso": self.peso,
            "maxcardio": self.maxcardio,
            "maxpulso": self.maxpulso,
            "frecuenciasemanal": self.frecuenciasemanal,
            #"usuario": self.usuario.to_dict() if self.usuario else None
        }