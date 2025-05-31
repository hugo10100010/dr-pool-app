from app import db

# horario.py (modelo intermedio)
class Horario(db.Model):
    __tablename__ = "horario"

    id = db.Column(db.Integer, primary_key=True)
    idusuario = db.Column(db.Integer, db.ForeignKey('usuario.id'), nullable=False)
    idclase = db.Column(db.Integer, db.ForeignKey('clase.id'), nullable=False)

    alumno = db.relationship('Usuario', back_populates='horario', uselist=False)
    clase = db.relationship('Clase', back_populates='horario', uselist=False)