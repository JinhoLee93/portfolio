from django.shortcuts import render
from django.http import HttpResponse
from django.core import serializers
from .models import *
from .api.serializers import *

# Create your views here.

def send_sections(request):
    wrapper    = Sections.objects.all()
    sections   = Section.objects.all()
    articles   = Article.objects.all()
    article_metadata       = Article_Metadata.objects.all()
    article_auxiliary_data = Article_Auxiliary_Data.objects.all()

    for s in sections:
        print(s)

    return HttpResponse(request)