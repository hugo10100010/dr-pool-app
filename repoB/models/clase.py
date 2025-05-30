from app import db

class Clase(db.Model):
    __tablename__ = "clase"

    id = db.Column(db.Integer,primary_key=True)
    idcoach = db.Column(db.Integer,db.ForeignKey('usuario.id'))
    idcasilla = db.Column(db.Integer,db.ForeignKey('casillahorario.id'))
    idcurso = db.Column(db.Integer,db.ForeignKey('curso.id'),nullable=False)

    __table_args__ = (
        db.UniqueConstraint("idcasilla",name="casilla_unica"),
    )

    coach = db.relationship('Usuario',back_populates='clases', uselist=False)
    horario = db.relationship('Horario',back_populates='clase', lazy=True)
    casillahorario = db.relationship('Casillahorario',back_populates='clase',uselist=False)
    curso = db.relationship('Curso',back_populates="clase",uselist=False)