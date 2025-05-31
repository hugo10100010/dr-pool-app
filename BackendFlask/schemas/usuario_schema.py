from marshmallow_sqlalchemy import SQLAlchemyAutoSchema, auto_field
from marshmallow_sqlalchemy.fields import Nested
from models.usuario import Usuario
from schemas.cuenta_schema import CuentaSchema
from schemas.personales_schema import PersonalesSchema
from schemas.metricas_schema import MetricasSchema
from schemas.domicilio_schema import DomicilioSchema
from schemas.subscripcion_schema import SubscripcionSchema
from schemas.horario_schema import HorarioSchema
from schemas.clase_schema import ClaseSchema
from schemas.historial_schema import HistorialSchema

class UsuarioSchema(SQLAlchemyAutoSchema):
    class Meta:
        model = Usuario
        load_instance = True
        include_fk = True
        include_relationships = True

    personales = Nested(PersonalesSchema)
    cuenta = Nested(CuentaSchema, exclude=('avatar',))
    metricas = Nested(MetricasSchema)
    domicilio = Nested(DomicilioSchema)
    subscripcion = Nested(SubscripcionSchema)
    horario = Nested(HorarioSchema, many=True)
    clases = Nested(ClaseSchema,many=True)
    historial=Nested(HistorialSchema,many=True)