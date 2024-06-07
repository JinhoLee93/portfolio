from rest_framework import serializers
from ..models import *

class LovedArticleSerializer(serializers.ModelSerializer):
    class Meta:
        model = LovedArticle
        fields = ['article_id']

class ViewedArticleSerializer(serializers.ModelSerializer):
    class Meta:
        model = ViewedArticle
        fields = ['article_id']

class BeatitudoMediaUserSerializer(serializers.ModelSerializer):
    viewed_articles = serializers.SerializerMethodField('get_viewed_articles')
    loved_articles = serializers.SerializerMethodField('get_loved_articles')
    id = serializers.IntegerField()
    email = serializers.CharField()
    nickname = serializers.CharField()
    class Meta:
        model = BeatitudoMediaUser
        fields = ['id', 'email', 'nickname', 'viewed_articles', 'loved_articles']

    def get_viewed_articles(self, obj):
        if isinstance(obj, dict):
            viewed_articles = []
            for viewed_article in ViewedArticle.objects.filter(beatitudo_media_user_id=obj['id']):
                serialized = ViewedArticleSerializer(viewed_article).data
                viewed_articles.append(serialized)
        else:
            viewed_articles = []
            for viewed_article in ViewedArticle.objects.filter(beatitudo_media_user_id=obj.id):
                serialized = ViewedArticleSerializer(viewed_article).data
                viewed_articles.append(serialized)
        return viewed_articles
    
    def get_loved_articles(self, obj): 
        if isinstance(obj, dict):
            loved_articles = []
            for loved_article in LovedArticle.objects.filter(beatitudo_media_user_id=obj['id']):
                serialized = LovedArticleSerializer(loved_article).data
                loved_articles.append(serialized)
        else:
            loved_articles = []
            for loved_article in LovedArticle.objects.filter(beatitudo_media_user_id=obj.id):
                serialized = LovedArticleSerializer(loved_article).data
                loved_articles.append(serialized)
        return loved_articles