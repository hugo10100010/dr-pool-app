from marshmallow_sqlalchemy import SQLAlchemyAutoSchema
from marshmallow_sqlalchemy.fields import Nested
from models.clase import Clase
from schemas.casillahorario_schema import CasillahorarioSchema
from schemas.curso_schema import CursoSchema

class ClaseSchema(SQLAlchemyAutoSchema):
    class Meta:
        model = Clase
        load_instance = True
        include_fk = True
        include_relationships = True
    
    coach = Nested('UsuarioSchema', only=('personales',))
    casillahorario = Nested(CasillahorarioSchema)
    curso = Nested(CursoSchema)
