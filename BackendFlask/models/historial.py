from app import db

class Historial(db.Model):
    __tablename__ = "historial"

    id = db.Column(db.Integer,primary_key=True)
    idusuario = db.Column(db.Integer,db.ForeignKey('usuario.id'),nullable=False)
    idpaquete = db.Column(db.Integer,db.ForeignKey('paquete.id'),nullable=False)
    fechaini = db.Column(db.DateTime,nullable=False)
    fechafin = db.Column(db.DateTime,nullable=False)
    metodo = db.Column(db.String(30),nullable=False)

    usuario = db.relationship('Usuario',back_populates='historial',uselist=False)
    paquete = db.relationship('Paquete',back_populates='historial',uselist=False)

    def to_dict(self):
        return {
            "id": self.id,
            "idusuario": self.idusuario,
            "idpaquete": self.idpaquete,
            "fechaini": self.fechaini,
            "fechafin": self.fechafin,
            "metodo": self.metodo,
            "usuario": self.usuario.to_dict() if self.usuario else None,
            "paquete": self.paquete.to_dict() if self.paquete else None
        }