"""Se modificó cuales campos son nullable

Revision ID: 2accd1c3081a
Revises: 
Create Date: 2025-04-21 13:52:01.314969

"""
from alembic import op
import sqlalchemy as sa
from sqlalchemy.dialects import mysql

# revision identifiers, used by Alembic.
revision = '2accd1c3081a'
down_revision = None
branch_labels = None
depends_on = None


def upgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    with op.batch_alter_table('clase', schema=None) as batch_op:
        batch_op.alter_column('idcoach',
               existing_type=mysql.INTEGER(display_width=11),
               nullable=True)

    with op.batch_alter_table('domicilio', schema=None) as batch_op:
        batch_op.alter_column('numint',
               existing_type=mysql.INTEGER(display_width=11),
               nullable=True)

    with op.batch_alter_table('horario', schema=None) as batch_op:
        batch_op.alter_column('rutina',
               existing_type=mysql.ENUM('Weider', 'Push_Pull_Leg', 'Torso_Pierna', 'Full_Body'),
               nullable=False)

    with op.batch_alter_table('metricas', schema=None) as batch_op:
        batch_op.alter_column('estatura',
               existing_type=mysql.DECIMAL(precision=3, scale=2),
               nullable=True)
        batch_op.alter_column('peso',
               existing_type=mysql.DECIMAL(precision=5, scale=2),
               nullable=True)
        batch_op.alter_column('maxcardio',
               existing_type=mysql.DECIMAL(precision=4, scale=2),
               nullable=True)
        batch_op.alter_column('maxpulso',
               existing_type=mysql.INTEGER(display_width=11),
               nullable=True)
        batch_op.alter_column('frecuenciasemanal',
               existing_type=mysql.INTEGER(display_width=11),
               nullable=True)

    # ### end Alembic commands ###


def downgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    with op.batch_alter_table('metricas', schema=None) as batch_op:
        batch_op.alter_column('frecuenciasemanal',
               existing_type=mysql.INTEGER(display_width=11),
               nullable=False)
        batch_op.alter_column('maxpulso',
               existing_type=mysql.INTEGER(display_width=11),
               nullable=False)
        batch_op.alter_column('maxcardio',
               existing_type=mysql.DECIMAL(precision=4, scale=2),
               nullable=False)
        batch_op.alter_column('peso',
               existing_type=mysql.DECIMAL(precision=5, scale=2),
               nullable=False)
        batch_op.alter_column('estatura',
               existing_type=mysql.DECIMAL(precision=3, scale=2),
               nullable=False)

    with op.batch_alter_table('horario', schema=None) as batch_op:
        batch_op.alter_column('rutina',
               existing_type=mysql.ENUM('Weider', 'Push_Pull_Leg', 'Torso_Pierna', 'Full_Body'),
               nullable=True)

    with op.batch_alter_table('domicilio', schema=None) as batch_op:
        batch_op.alter_column('numint',
               existing_type=mysql.INTEGER(display_width=11),
               nullable=False)

    with op.batch_alter_table('clase', schema=None) as batch_op:
        batch_op.alter_column('idcoach',
               existing_type=mysql.INTEGER(display_width=11),
               nullable=False)

    # ### end Alembic commands ###
