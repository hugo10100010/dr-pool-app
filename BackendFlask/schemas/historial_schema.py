from marshmallow_sqlalchemy import SQLAlchemyAutoSchema
from models.historial import Historial
from marshmallow_sqlalchemy.fields import Nested

from schemas.paquete_schema import PaqueteSchema

class HistorialSchema(SQLAlchemyAutoSchema):
    class Meta:
        model = Historial
        load_instance = True
        include_fk = True
        include_relationships = True
    
    paquete = Nested(PaqueteSchema)