import enum
from app import db

class MyEnum(enum.Enum):
    Weider = "Weider"
    Push_Pull_Leg = "Push-Pull-Leg"
    Torso_Pierna = "Torso-Pierna"
    Full_Body = "Full body"

class Horario(db.Model):
    __tablename__ = "horario"

    id = db.Column(db.Integer,primary_key=True)
    idusuario = db.Column(db.Integer,db.ForeignKey('usuario.id'),nullable=False)
    rutina = db.Column(db.String(20), nullable=False)

    usuario = db.relationship('Usuario',back_populates='horario',uselist=False)

    def to_dict(self):
        return {
            "id": self.id,
            "idusuario": self.idusuario,
            "rutina": self.rutina,
            "usuario": self.usuario.to_dict() if self.usuario else None
        }