from app import db

class Domicilio(db.Model):
    __tablename__ = "domicilio"

    id = db.Column(db.Integer,primary_key=True)
    calle = db.Column(db.String(25))
    numext = db.Column(db.Integer)
    numint = db.Column(db.Integer)
    asentamiento = db.Column(db.String(25))
    codigop = db.Column(db.Integer)

    usuario = db.relationship('Usuario',back_populates='domicilio',uselist=False)

    def to_dict(self):
        return {
            "id": self.id,
            "calle": self.calle,
            "numext": self.numext,
            "numint": self.numint if self.numint else None,
            "asentamiento": self.asentamiento,
            "codigop": self.codigop,
            #"usuario": self.usuario.to_dict() if self.usuario else None
        }