from django.shortcuts import render
from django.http import HttpResponse
from django.core import serializers
from .models import *
from .api.serializers import *
from django.http import JsonResponse
from json import JSONDecodeError
from rest_framework import views, status
from rest_framework.response import Response
from rest_framework.parsers import JSONParser

# Create your views here.

def send_sections(request):
    return JsonResponse({ 'sections' : [SectionSerializer(section).data for section in Section.objects.all()] })