from django.db import models

# Create your models here.

# Whenever you change the models, makemigrations -> migrate
class Product(models.Model):
    title       = models.TextField()
    description = models.TextField()
    price       = models.TextField()
    summary     = models.TextField(default='this is cool!')