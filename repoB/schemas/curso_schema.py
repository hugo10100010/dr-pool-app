from marshmallow_sqlalchemy import SQLAlchemyAutoSchema
from models.curso import Curso

class CursoSchema(SQLAlchemyAutoSchema):
    class Meta:
        model = Curso
        load_instance = True
        include_fk = True
        include_relationships = True
