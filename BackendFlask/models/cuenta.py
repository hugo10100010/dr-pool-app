from app import db
from sqlalchemy.dialects.mysql import MEDIUMBLOB

class Cuenta(db.Model):
    __tablename__ = "cuenta"

    id = db.Column(db.Integer,primary_key=True)
    nombreusu = db.Column(db.String(40),unique=True,nullable=False)
    password_hashed = db.Column(db.String(512),nullable=False)
    avatar = db.Column(MEDIUMBLOB)

    usuario = db.relationship('Usuario',back_populates='cuenta',uselist=False)

    def to_dict(self):
        return {
            'id': self.id,
            'nombreusu': self.nombreusu,
            'password_hashed': self.password_hashed,
            #'avatar': self.avatar,
            #'usuario': self.usuario.to_dict() if self.usuario else None
        }