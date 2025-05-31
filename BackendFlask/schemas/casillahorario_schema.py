from marshmallow_sqlalchemy import SQLAlchemyAutoSchema
from models.casillahorario import Casillahorario

class CasillahorarioSchema(SQLAlchemyAutoSchema):
    class Meta:
        model = Casillahorario
        load_instance = True
        include_fk = True
        include_relationships = True
