from django.shortcuts import render
from django.http import HttpResponse
from django.core import serializers
from django.db.models import F
from django.db import transaction
from django.views.decorators.csrf import csrf_exempt
from django.http import JsonResponse
from rest_framework import status
from rest_framework.views import APIView
from .models import *
from .api.serializers import *
from .utils.scraper.scraper import *
from .utils.classifier.classifier import *

# Create your views here.
class ProcessedArticleAPI(APIView):
    def post(self, request):
        serialized_processed_articles = []
        processed_article_queryset = ProcessedArticle.objects.all()
        if processed_article_queryset:
            for processed_article in processed_article_queryset:
                serializer = ProcessedArticleSerializer(data=processed_article.serialize())
                if serializer.is_valid():
                    serialized_processed_articles.append(serializer.data)
        else:
            try:
                scraped_articles = get_articles_from_big_kinds() # [0, ..., 999]
                gpt_client = GPTClient()

                scraped_articles_for_gpt = []
                current_idx = 0
                for scraped_article in scraped_articles:
                    scraped_articles_for_gpt.append(scraped_article)
                    if len(scraped_articles_for_gpt) == 20:
                        request = gpt_client.create_query_prompt([article.title for article in scraped_articles_for_gpt])
                        response = gpt_client.send_query_prompt(request=request)
                        list_response = response[1:-1].split(', ')
                        for section_title in list_response:
                            section_title.replace("'", "")
                            section_title = section_title[1:-1]
                            if section_title in ['Moving', 'Amazing', 'Happy', 'Funny']:
                                current_article = scraped_articles[current_idx]
                                time_to_read = (len(current_article.article_body.split(' ')) // 200) + 1
                                ProcessedArticle.objects.create(section_title=section_title, 
                                                                title=current_article.title, 
                                                                thumbnail_url=current_article.thumbnail_url,
                                                                article_url=current_article.article_url,
                                                                time_to_read=time_to_read)
                                
                                serializer = ProcessedArticleSerializer(data={ 
                                    'section_title' : section_title,
                                    'title' : current_article.title, 
                                    'thumbnail_url' : current_article.thumbnail_url,
                                    'article_url' : current_article.article_url,
                                    'time_to_read' : time_to_read,
                                    'date' : current_article.date,
                                })

                                if serializer.is_valid():
                                    serialized_processed_articles.append(serializer.data)
                            current_idx += 1
                        scraped_articles_for_gpt = []
            except:
                return HttpResponse(status=status.HTTP_500_INTERNAL_SERVER_ERROR)
        
        return JsonResponse({ 'processed_articles' :  serialized_processed_articles }, status=status.HTTP_200_OK)