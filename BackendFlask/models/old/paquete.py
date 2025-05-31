from app import db
from sqlalchemy.dialects.mysql import DECIMAL

class Paquete(db.Model):
    __tablename__ = "paquete"

    id = db.Column(db.Integer,primary_key=True)
    precio = db.Column(DECIMAL(5,2),nullable=False)
    beneficios = db.Column(db.Text,nullable=False)

    subscripciones = db.relationship('Subscripcion',back_populates='paquete',lazy=True,cascade="all")
    historial = db.relationship('Historial',back_populates='paquete',lazy=True,cascade="all")

    def to_dict(self):
        return {
            "id": self.id,
            "precio": self.precio,
            "beneficios": self.beneficios,
            "subscripciones": self.subscripciones.to_dict() if self.subscripciones else None,
            "historial": self.historial.to_dict() if self.historial else None
        }