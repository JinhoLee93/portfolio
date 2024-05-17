from rest_framework import serializers
from ..models import *

class ArticleMetaDataSerializer(serializers.ModelSerializer):
    class Meta:
        model  = Article_Metadata
        fields = ['id', 'time_to_read', 'date', 'article_views']

class ArticleAuxiliaryDataSerializer(serializers.ModelSerializer):
    class Meta:
        model = Article_Auxiliary_Data
        fields = ['id', 'count_of_loved', 'count_of_shared']

class ArticleSerializer(serializers.ModelSerializer):
    article_metadata = serializers.SerializerMethodField('get_article_metadata')
    article_auxiliary_data = serializers.SerializerMethodField('get_article_auxiliary_data')
    class Meta:
        model  = Article
        fields = ['id', 'title', 'thumbnail_url', 'article_url', 'article_metadata', 'article_auxiliary_data']

    def get_article_metadata(self, obj):
        current_article_metadata = Article_Metadata.objects.filter(article_id=obj.id).first()
        return ArticleMetaDataSerializer(current_article_metadata).data
    
    def get_article_auxiliary_data(self, obj):
        current_article_auxiliary_data = Article_Auxiliary_Data.objects.filter(article_id=obj.id).first()
        return ArticleAuxiliaryDataSerializer(current_article_auxiliary_data).data

class SectionSerializer(serializers.ModelSerializer):
    articles = serializers.SerializerMethodField('get_articles')
    class Meta:
        model  = Section
        fields = ['id', 'title', 'articles']

    def get_articles(self, obj):
        articles = []
        for article in Article.objects.filter(section_id=obj.id):
            serialized = ArticleSerializer(article).data
            articles.append(serialized)
        return articles