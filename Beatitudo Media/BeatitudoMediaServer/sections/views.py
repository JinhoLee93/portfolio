from django.shortcuts import render
from django.http import HttpResponse
from django.core import serializers
from .models import *
from .api.serializers import *
from django.http import JsonResponse
from json import JSONDecodeError
from rest_framework import status
from django.db.models import F
from django.db import transaction
from django.views.decorators.csrf import csrf_exempt
from rest_framework.views import APIView
import requests
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
    
    def post(self, request):
        data = json.loads(request.body)
        section_id = data['section_id']
        try:
            target = Section.objects.get(id=section_id)
            serializer = SectionSerializer(data=target.serialize())
            if serializer.is_valid():
                return JsonResponse( { 'id' : serializer.data['id'],
                                       'title' : serializer.data['title'],
                                       'articles' : serializer.data['articles'] })
        except Section.DoesNotExist:
            return HttpResponse(status=status.HTTP_404_NOT_FOUND)
    
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

class BeatitudoMediaWebServicesAPI(APIView):
    def post(self, request):
        url = 'http://127.0.0.1:8000/beatitudo-media-web-services/process-new-articles/'
        headers = {'Content-type' : 'application/json'}
        response = requests.post(url, data={}, headers=headers)
        processed_articles = json.loads(response.content)['processed_articles']
        for processed_article in processed_articles:
            section_title = processed_article['section_title']
            current_section = Section.objects.get(title=section_title)
            title = processed_article['title']
            thumbnail_url = processed_article['thumbnail_url']
            article_url = processed_article['article_url']
            time_to_read = processed_article['time_to_read']
            date = processed_article['date']
            if not Article.objects.filter(title=title).exists():
                Article.objects.create(section_id=current_section.id, title=title, thumbnail_url=thumbnail_url, article_url=article_url)
                current_article = Article.objects.get(title=title)
                ArticleMetadata.objects.create(article_id=current_article.id, time_to_read=time_to_read, date=date)
                ArticleAuxiliaryData.objects.create(article_id=current_article.id)
        return HttpResponse(status=status.HTTP_200_OK)