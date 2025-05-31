from marshmallow_sqlalchemy import SQLAlchemyAutoSchema
from models.domicilio import Domicilio

class DomicilioSchema(SQLAlchemyAutoSchema):
    class Meta:
        model = Domicilio
        load_instance = True
        include_fk = True
        include_relationships = True
