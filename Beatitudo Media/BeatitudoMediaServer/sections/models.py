from django.db import models

# Create your models here.

class Section(models.Model): 
    title    = models.TextField()
    articles = models