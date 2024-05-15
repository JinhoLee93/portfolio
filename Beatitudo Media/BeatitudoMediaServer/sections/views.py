from django.shortcuts import render
from django.http import HttpResponse
from django.core import serializers
from .models import *
from .api.serializers import *
from django.http import JsonResponse

# Create your views here.

def send_sections(request):
    sections = [SectionSerializer(section).data for section in Section.objects.all()]
    return JsonResponse({ 'sections' : sections })