from app import db

class Casillahorario(db.Model):
    __tablename__ = "casillahorario"

    id = db.Column(db.Integer,primary_key=True)
    horaini = db.Column(db.String(5),nullable=False)
    horafin = db.Column(db.String(5),nullable=False)
    dia = db.Column(db.Integer,nullable=False)

    __table_args__ = (
        db.UniqueConstraint('dia','horaini','horafin',name="horario_unico"),
    )

    clase = db.relationship('Clase',back_populates='casillahorario',uselist=False)

    def to_dict(self):
        return {
            "id": self.id,
            "horaini": self.horaini,
            "horafin": self.horafin,
            "dia": self.dia,
            "clase": self.clase.to_dict() if self.clase else None
        }