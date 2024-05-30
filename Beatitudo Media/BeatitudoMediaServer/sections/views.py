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
import json

# Create your views here.

class SectionsAPI(APIView):
    def get(self, request):
        sections = []
        for section in Section.objects.all():
            serializer = SectionSerializer(data=section.serialize())
            if serializer.is_valid():
                sections.append(serializer.data)
            else:
                return HttpResponse(status=status.HTTP_404_NOT_FOUND)
        return JsonResponse({ 'sections' : sections }, status=status.HTTP_200_OK)
    
class ArticleMetadataAPI(APIView):
    def put(self, request):
        @transaction.atomic
        def do_update(obj):
            obj.article_views = F('article_views') + 1
            obj.save(update_fields=['article_views'])
        data = json.loads(request.body)
        id = data['id']
        try:
            do_update(ArticleMetadata.objects.get(id=id))
            serializer = ArticleMetaDataSerializer(data=ArticleMetadata.objects.get(id=id).serialize())
            if serializer.is_valid():
                return JsonResponse({ 'id' : serializer.data['id'],
                                      'article_id' : serializer.data['article_id'],
                                      'time_to_read' : serializer.data['time_to_read'],
                                      'date' : serializer.data['date'],
                                      'article_views' : serializer.data['article_views'] })
            else:
                print(serializer.errors)
        except ArticleMetadata.DoesNotExist:
            return HttpResponse(status=status.HTTP_404_NOT_FOUND)
        return HttpResponse(status=status.HTTP_400_BAD_REQUEST)
            
class ArticleAuxiliaryDataAPI(APIView):
    def get(self, request, pk):
        try:
            target = ArticleAuxiliaryData.objects.get(pk=pk)
        except ArticleAuxiliaryData.DoesNotExist:
            return JsonResponse({ 'response' : f'Article Auxiliary Data {pk} does not exist' }, status=status.HTTP_404_NOT_FOUND)
        return JsonResponse({ 'auxiliary_data' : ArticleAuxiliaryDataSerializer(target) })

    def put(self, request):
        @transaction.atomic
        def do_update(obj, should_increment):
            if should_increment:
                obj.count_of_loved = F('count_of_loved') + 1
            else:
                obj.count_of_loved = F('count_of_loved') - 1
            obj.save(update_fields=['count_of_loved'])

        data = json.loads(request.body)
        current_article_id = data['current_article_id']
        should_increment = data['should_increment']
        try:
            do_update(ArticleAuxiliaryData.objects.get(article_id=current_article_id), should_increment)
            serializer = ArticleAuxiliaryDataSerializer(data=ArticleAuxiliaryData.objects.get(article_id=current_article_id).serialize())
            if serializer.is_valid():
                return JsonResponse({ 'id' : serializer.data['id'],
                                      'article_id' : serializer.data['article_id'],
                                      'count_of_loved' : serializer.data['count_of_loved'],
                                      'count_of_shared' : serializer.data['count_of_shared'] }, status=status.HTTP_200_OK)
        except ArticleAuxiliaryData.DoesNotExist:
            return HttpResponse(status=status.HTTP_404_NOT_FOUND)
        return HttpResponse(status=status.HTTP_404_NOT_FOUND)
    
class ArticleAPI(APIView):
    def post(self, request):
        data = json.loads(request.body)
        article_ids = data['article_ids']
        serialized_articles = []
        for article_id in article_ids:
            article_data = Article.objects.get(id=article_id).serialize()
            serializer = ArticleSerializer(data=article_data)
            if serializer.is_valid():
                serialized_articles.append(serializer.data)
            else:
                print(serializer.errors)
                return HttpResponse(status=status.HTTP_400_BAD_REQUEST)
        return JsonResponse({ 'articles' : serialized_articles }, status=status.HTTP_200_OK)
