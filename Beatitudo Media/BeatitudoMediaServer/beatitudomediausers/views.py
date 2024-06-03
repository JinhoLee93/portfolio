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
class BeatitudoMediaUserAPI(APIView):
    def post(self, request): # Sign up
        data = json.loads(request.body)
        if 'id' in data: # Send the current user information
            try:
                target = BeatitudoMediaUser.objects.get(id=data['id'])
                serializer = BeatitudoMediaUserSerializer(data=target.serialize())
                if serializer.is_valid():
                    return JsonResponse({ 'beatitudo_media_user' : serializer.data }, status=status.HTTP_200_OK)
            except BeatitudoMediaUser.DoesNotExist:
                return HttpResponse(status=status.HTTP_404_NOT_FOUND)
        email = data['email']
        if BeatitudoMediaUser.objects.filter(email=email).exists(): # If the user already exists, return.
            target = BeatitudoMediaUser.objects.get(email=email)
            serializer = BeatitudoMediaUserSerializer(data=target.serialize())
            if serializer.is_valid():
                return JsonResponse({ 'beatitudo_media_user' : serializer.data }, status=status.HTTP_200_OK)
        if 'nickname' in data:
            nickname = data['nickname']
            BeatitudoMediaUser.objects.create(email=email, nickname=nickname)
            serializer = BeatitudoMediaUserSerializer(data=BeatitudoMediaUser.objects.get(email=email).serialize())
            if serializer.is_valid():
                return JsonResponse({ 'beatitudo_media_user' : serializer.data }, status=status.HTTP_201_CREATED)
            else:
                print(serializer.errors)
            return HttpResponse(status=status.HTTP_400_BAD_REQUEST)
    
    def put(self, request): # Change user nickname
        data = json.loads(request.body)
        current_user_id = data['current_user_id']
        new_nickname = data['new_nickname']
        try:
            target = BeatitudoMediaUser.objects.get(id=current_user_id)
            target.nickname = new_nickname
            target.save()
            serializer = BeatitudoMediaUserSerializer(data=target.serialize())
            if serializer.is_valid():
                return JsonResponse({ 'beatitudo_media_user' : serializer.data })
            else:
                return HttpResponse(status=status.HTTP_400_BAD_REQUEST)
        except BeatitudoMediaUser.DoesNotExist:
            return HttpResponse(status=status.HTTP_404_NOT_FOUND)

class LovedArticlesAPI(APIView):
    def post(self, request):
        data = json.loads(request.body)
        current_user_id = data['current_user_id']
        current_article_id = data['current_article_id']
        if LovedArticle.objects.filter(beatitudo_media_user_id=current_user_id, article_id=current_article_id).exists():
            LovedArticle.objects.filter(beatitudo_media_user_id=current_user_id, article_id=current_article_id).delete()
            serializer = BeatitudoMediaUserSerializer(data=BeatitudoMediaUser.objects.get(id=current_user_id).serialize())
            if serializer.is_valid():
                return JsonResponse( { 'beatitudo_media_user' : serializer.data }, status=status.HTTP_200_OK)
        else:
            LovedArticle.objects.create(beatitudo_media_user=BeatitudoMediaUser.objects.get(id=current_user_id), article_id=current_article_id)
            serializer = BeatitudoMediaUserSerializer(data=BeatitudoMediaUser.objects.get(id=current_user_id).serialize())
            if serializer.is_valid():
                return JsonResponse( { 'beatitudo_media_user' : serializer.data }, status=status.HTTP_201_CREATED)
        return HttpResponse(status=status.HTTP_400_BAD_REQUEST)

class ViewedArticlesAPI(APIView):
    def post(self, request):
        data = json.loads(request.body)
        current_user_id = data['current_user_id']
        current_article_id = data['current_article_id']
        if not ViewedArticle.objects.filter(beatitudo_media_user_id=current_user_id, article_id=current_article_id).exists():
            ViewedArticle.objects.create(beatitudo_media_user_id=current_user_id, article_id=current_article_id)
        serializer = BeatitudoMediaUserSerializer(data=BeatitudoMediaUser.objects.get(id=current_user_id).serialize())
        if serializer.is_valid():
            return JsonResponse({ 'beatitudo_media_user' : serializer.data }, status=status.HTTP_200_OK)
        return HttpResponse(status=status.HTTP_400_BAD_REQUEST)
