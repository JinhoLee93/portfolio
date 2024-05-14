from rest_framework import serializers
from ..models import *

class ArticleMetaDataSerializer(serializers.ModelSerializer):
    class Meta:
        model  = Article_Metadata
        fields = ['time_to_read', 'date']

class ArticleAuxiliaryDataSerializer(serializers.ModelSerializer):
    class Meta:
        model = Article_Auxiliary_Data
        fields = ['count_of_loved', 'count_of_shared']

class ArticleSerializer(serializers.ModelSerializer):
    article_metadata = ArticleMetaDataSerializer(many=False, read_only=True)
    article_auxiliary_data = ArticleAuxiliaryDataSerializer(many=False, read_only=True)
    class Meta:
        model  = Article
        fields = ['title', 'article_views', 'thumbnail_url', 'article_url', 'article_metadata', 'article_auxiliary_data']

class SectionSerializer(serializers.ModelSerializer):
    articles = ArticleSerializer(many=True, read_only=True)
    class Meta:
        model  = Section
        fields = ['title', 'articles']

class SectionsSerializer(serializers.ModelSerializer):
    sections = SectionSerializer(many=True, read_only=True)
    class Meta:
        model  = Sections
        fields = ['sections']