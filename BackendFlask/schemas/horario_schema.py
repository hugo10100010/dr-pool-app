import enum
from marshmallow_sqlalchemy import SQLAlchemyAutoSchema
from marshmallow import fields
from models.horario import Horario
from marshmallow.fields import Nested

from schemas.clase_schema import ClaseSchema

class MyEnum(enum.Enum):
    Weider = "Weider"
    Push_Pull_Leg = "Push-Pull-Leg"
    Torso_Pierna = "Torso-Pierna"
    Full_Body = "Full body"

class HorarioSchema(SQLAlchemyAutoSchema):
    class Meta:
        model = Horario
        load_instance = True
        include_fk = True
        include_relationships = True

    clase = Nested(ClaseSchema)