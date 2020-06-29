import os, sys

from airflow.models import BaseOperator


def setup_django_for_airflow():
    # Add Django project root to path
    sys.path.append('../')

    os.environ.setdefault("DJANGO_SETTINGS_MODULE", "project.config.settings")

    import django
    django.setup()


class DjangoOperator(BaseOperator):

    def pre_execute(self, *args, **kwargs):
        setup_django_for_airflow()


class DjangoExampleOperator(DjangoOperator):

    def execute(self, context):
        from project.ses.models import model
        model.objects.get_or_create()



""" import os
import django
os.environ.setdefault(
    "DJANGO_SETTINGS_MODULE",
    "myapp.settings"
)
django.setup()
from your_app import models

def get_and_modify_models(ds, **kwargs):
    all_objects = models.MyModel.objects.filter(my_str_field = 'abc')
    all_objects[15].my_int_field = 25
    all_objects[15].save()
    return list(all_objects)

django_op = DjangoOperator(task_id='get_and_modify_models', owner='airflow') """