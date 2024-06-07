from django.db import models

# Create your models here.
class ProcessedArticle(models.Model):
    section_title = models.TextField()
    title         = models.TextField()
    thumbnail_url = models.TextField()
    article_url   = models.TextField()
    time_to_read  = models.IntegerField(default=0)
    date          = models.TextField(default='')

    def __str__(self):
        return f'Article {self.title}'
    
    def serialize(self):
        return {
            'section_title' : self.section_title,
            'title' : self.title,
            'thumbnail_url' : self.thumbnail_url,
            'article_url' : self.article_url,
            'time_to_read' : self.time_to_read,
            'date' : self.date,
        }