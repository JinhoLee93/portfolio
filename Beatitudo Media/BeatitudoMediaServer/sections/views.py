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
from django.db.models import F
from django.db import transaction
from django.views.decorators.csrf import csrf_exempt
from rest_framework.views import APIView

# Create your views here.

class SectionsAPI(APIView):
    def get(self, request):
        return JsonResponse({ 'sections' : [SectionSerializer(section).data for section in Section.objects.all()] })
    
class ArticleMetadataAPI(APIView):
    def put(self, request, pk):
        @transaction.atomic
        def do_update(obj):
            obj.article_views = F('article_views') + 1
            obj.save(update_fields=['article_views'])
        try:
            target = ArticleMetadata.objects.get(pk=pk)
            do_update(target)
        except ArticleMetadata.DoesNotExist:
            return JsonResponse({ 'response' : f'Article Metadata {pk} does not exist' }, status=status.HTTP_404_NOT_FOUND)
        return JsonResponse({ 'response' : f'Update Successful for {pk}' }, status=status.HTTP_200_OK)
            
class ArticleAuxiliaryDataAPI(APIView):
    def get(self, request, pk):
        try:
            target = ArticleAuxiliaryData.objects.get(pk=pk)
        except ArticleAuxiliaryData.DoesNotExist:
            return JsonResponse({ 'response' : f'Article Auxiliary Data {pk} does not exist' }, status=status.HTTP_404_NOT_FOUND)
        return JsonResponse({ 'auxiliary_data' : ArticleAuxiliaryDataSerializer(target) })

    def put(self, request, pk):
        @transaction.atomic
        def do_update(obj):
            obj.count_of_loved = F('count_of_loved') + 1
            obj.save(update_fields=['count_of_loved'])
        try:
            target = ArticleAuxiliaryData.objects.get(pk=pk)
            do_update(target)
        except ArticleAuxiliaryData.DoesNotExist:
            return JsonResponse({ 'response' : f'Article Auxiliary Data {pk} does not exist' }, status=status.HTTP_404_NOT_FOUND)
        return JsonResponse({ 'response' : f'Update Successful for {pk}' }, status=status.HTTP_200_OK)