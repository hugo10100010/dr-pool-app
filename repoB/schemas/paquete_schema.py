from marshmallow_sqlalchemy import SQLAlchemyAutoSchema
from models.paquete import Paquete

class PaqueteSchema(SQLAlchemyAutoSchema):
    class Meta:
        model = Paquete
        load_instance = True
        include_fk = True
        include_relationships = True
