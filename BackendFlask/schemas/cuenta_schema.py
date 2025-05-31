from marshmallow_sqlalchemy import SQLAlchemyAutoSchema
from marshmallow import fields
from models.cuenta import Cuenta
import base64

class CuentaSchema(SQLAlchemyAutoSchema):
    class Meta:
        model = Cuenta
        load_instance = True
        include_fk = True
        include_relationships = True

    avatar = fields.Method("get_avatar_as_base64")

    def get_avatar_as_base64(self, obj):
        if obj.avatar:
            if isinstance(obj.avatar, bytes):
                return base64.b64encode(obj.avatar).decode("utf-8")
            else:
                try:
                    return base64.b64encode(bytes(obj.avatar, 'utf-8')).decode("utf-8")
                except Exception:
                    return None
        return None
