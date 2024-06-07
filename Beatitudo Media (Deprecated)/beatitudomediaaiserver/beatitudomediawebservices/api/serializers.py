from rest_framework import serializers
from ..models import *

class ProcessedArticleSerializer(serializers.ModelSerializer):
    section_title = serializers.CharField()
    title = serializers.CharField()
    thumbnail_url = serializers.CharField()
    article_url = serializers.CharField()
    time_to_read = serializers.IntegerField()
    date = serializers.CharField()
    class Meta:
        model = ProcessedArticle
        fields = ['section_title', 'title', 'thumbnail_url', 'article_url', 'time_to_read', 'date']