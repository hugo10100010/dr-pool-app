import enum
from marshmallow_sqlalchemy import SQLAlchemyAutoSchema
from marshmallow_sqlalchemy.fields import Nested
from models.subscripcion import Subscripcion
from marshmallow import fields

from schemas.paquete_schema import PaqueteSchema

class MyEnum(enum.Enum):
    Activa = "Activa"
    Inactiva = "Inactiva"
    Suspendida = "Suspendida"

class SubscripcionSchema(SQLAlchemyAutoSchema):
    class Meta:
        model = Subscripcion
        load_instance = True
        include_fk = True
        include_relationships = True

    paquete = Nested(PaqueteSchema)
