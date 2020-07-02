import logging

from django.shortcuts import render
from django.http import HttpResponse

logger = logging.getLogger(__name__)


def index(request):
    logger.info("Creando un registro en los logs")
    return HttpResponse("Hello, world. You're at the polls index.")
