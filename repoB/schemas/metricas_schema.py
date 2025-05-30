from marshmallow_sqlalchemy import SQLAlchemyAutoSchema
from models.metricas import Metricas

class MetricasSchema(SQLAlchemyAutoSchema):
    class Meta:
        model = Metricas
        load_instance = True
        include_fk = True
        include_relationships = True
