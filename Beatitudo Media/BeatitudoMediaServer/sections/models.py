from django.db import models

# Create your models here.

class Section(models.Model): 
    title    = models.TextField(null=True)

    def __str__(self):
        return f"Section {self.title}"

class Article(models.Model):
    section       = models.ForeignKey(to=Section, related_name='articles', on_delete=models.CASCADE, null=False)
    title         = models.TextField()
    thumbnail_url = models.TextField()
    article_url   = models.TextField()

    def __str__(self):
        return f"Article {self.title}"

class Article_Metadata(models.Model):
    article      = models.ForeignKey(to=Article, related_name='article_metadata', on_delete=models.CASCADE, null=False)
    time_to_read = models.IntegerField()
    date         = models.TextField()
    article_views = models.IntegerField(default=0)

    def __str__(self):
        return f"Article_Metadata of {self.article.title}"

class Article_Auxiliary_Data(models.Model):
    article         = models.ForeignKey(to=Article, related_name='article_auxiliary_data', on_delete=models.CASCADE, null=False)
    count_of_loved  = models.IntegerField(default=0)
    count_of_shared = models.IntegerField(default=0)

    def __str__(self):
        return f"Article_Auxiliary_Data of {self.article.title}"