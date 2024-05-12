from django.db import models

# Create your models here.

class Sections(models.Model):
    description = models.TextField(null=True)

class Section(models.Model): 
    sections = models.ForeignKey(to=Sections, on_delete=models.CASCADE, null=True)
    id       = models.IntegerField(primary_key=True)
    title    = models.TextField(null=True)

class Article(models.Model):
    section       = models.ForeignKey(to=Section, on_delete=models.CASCADE, null=True)
    title         = models.TextField()
    article_views = models.IntegerField()
    thumbnail_url = models.TextField()
    article_url   = models.TextField()
    article_metadata_url       = models.TextField()
    article_auxiliary_data_url = models.TextField()

class Article_Metadata(models.Model):
    time_to_read = models.IntegerField()
    date         = models.TextField()

class Article_Auxiliary_Data(models.Model):
    loved           = models.BooleanField()
    count_of_loved  = models.IntegerField()
    count_of_shared = models.IntegerField()