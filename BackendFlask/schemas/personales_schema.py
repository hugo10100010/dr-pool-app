
from marshmallow_sqlalchemy import SQLAlchemyAutoSchema
from models.personales import Personales

class PersonalesSchema(SQLAlchemyAutoSchema):
    class Meta:
        model = Personales
        load_instance = True
        include_fk = True
        include_relationships = True
