from rest_framework import serializers
from ..models import *

class ArticleMetaDataSerializer(serializers.ModelSerializer):
    id = serializers.IntegerField()
    article_id = serializers.IntegerField()
    time_to_read = serializers.IntegerField()
    date = serializers.CharField()
    article_views = serializers.IntegerField()
    class Meta:
        model  = ArticleMetadata
        fields = ['id', 'article_id', 'time_to_read', 'date', 'article_views']

class ArticleAuxiliaryDataSerializer(serializers.ModelSerializer):
    id = serializers.IntegerField()
    article_id = serializers.IntegerField()
    count_of_loved = serializers.IntegerField()
    count_of_shared = serializers.IntegerField()
    class Meta:
        model = ArticleAuxiliaryData
        fields = ['id', 'article_id', 'count_of_loved', 'count_of_shared']

class ArticleSerializer(serializers.ModelSerializer):
    article_metadata = serializers.SerializerMethodField('get_article_metadata')
    article_auxiliary_data = serializers.SerializerMethodField('get_article_auxiliary_data')
    id = serializers.IntegerField()
    section_id = serializers.IntegerField()
    title = serializers.CharField()
    thumbnail_url = serializers.CharField()
    article_url = serializers.CharField()
    class Meta:
        model  = Article
        fields = ['id', 'section_id', 'title', 'thumbnail_url', 'article_url', 'article_metadata', 'article_auxiliary_data']

    def get_article_metadata(self, obj):
        current_article_metadata = ArticleMetadata.objects.get(article_id=obj['id'])
        return ArticleMetaDataSerializer(current_article_metadata).data
    
    def get_article_auxiliary_data(self, obj):
        current_article_auxiliary_data = ArticleAuxiliaryData.objects.get(article_id=obj['id'])
        return ArticleAuxiliaryDataSerializer(current_article_auxiliary_data).data

class SectionSerializer(serializers.ModelSerializer):
    articles = serializers.SerializerMethodField('get_articles')
    id = serializers.IntegerField()
    title = serializers.CharField()
    class Meta:
        model  = Section
        fields = ['id', 'title', 'articles']

    def get_articles(self, obj):
        articles = []
        for article in Article.objects.filter(section_id=obj['id']):
            serializer = ArticleSerializer(data=article.serialize())
            if serializer.is_valid():
                articles.append(serializer.data)
            else:
                return []
        return articles