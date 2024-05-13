from django.shortcuts import render
from django.http import HttpResponse
from django.core import serializers
from .models import Sections

# Create your views here.

def send_sections(request):
    sections_json = serializers.serialize('json', Sections.objects.all())
    return HttpResponse(sections_json, content_type='application/json')