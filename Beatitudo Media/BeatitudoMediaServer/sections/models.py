from django.db import models

# Create your models here.

class Section(models.Model): 
    title    = models.TextField(null=True)

    def __str__(self):
        return f"Section {self.title}"

class Article(models.Model):
    section       = models.ForeignKey(to=Section, related_name='article', on_delete=models.CASCADE, null=False)
    title         = models.TextField()
    thumbnail_url = models.TextField()
    article_url   = models.TextField()

    def __str__(self):
        return f"Article {self.title}"

class ArticleMetadata(models.Model):
    article      = models.ForeignKey(to=Article, related_name='article_metadata', on_delete=models.CASCADE, null=False)
    time_to_read = models.IntegerField()
    date         = models.TextField()
    article_views = models.IntegerField(default=0)

    def __str__(self):
        return f"ArticleMetadata of {self.article.title}"

class ArticleAuxiliaryData(models.Model):
    article         = models.ForeignKey(to=Article, related_name='article_auxiliary_data', on_delete=models.CASCADE, null=False)
    count_of_loved  = models.IntegerField(default=0)
    count_of_shared = models.IntegerField(default=0)

    def __str__(self):
        return f"ArticleAuxiliaryData of {self.article.title}"
    
    def serialize(self):
        return { 
            'id' : self.id, 
            'article_id' : self.article_id,
            'count_of_loved' : self.count_of_loved,
            'count_of_shared' : self.count_of_shared
        }