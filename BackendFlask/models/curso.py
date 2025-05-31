from app import db

class Curso(db.Model):
    __tablename__ = "curso"

    id = db.Column(db.Integer,primary_key=True)
    curso = db.Column(db.Text,nullable=False)
    descripcion = db.Column(db.Text,nullable=False)
    clase = db.relationship('Clase',back_populates='curso',lazy=True)

    def to_dict(self):
        return {
            "id": self.id,
            "curso": self.curso,
            "descripcion": self.descripcion,
            "clase": self.clase.to_dict() if self.clase else None,
        }