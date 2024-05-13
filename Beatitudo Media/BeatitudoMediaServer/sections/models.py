from django.db import models

# Create your models here.

class Sections(models.Model):
    pass

class Section(models.Model): 
    sections = models.ForeignKey(to=Sections, on_delete=models.CASCADE, null=False)
    title    = models.TextField(null=True)

    def __str__(self):
        return f"Section {self.title}"

class Article(models.Model):
    section       = models.ForeignKey(to=Section, on_delete=models.CASCADE, null=False)
    title         = models.TextField()
    article_views = models.IntegerField(default=0)
    thumbnail_url = models.TextField()
    article_url   = models.TextField()

    def __str__(self):
        return f"Article {self.title}"

class Article_Metadata(models.Model):
    time_to_read = models.IntegerField()
    date         = models.TextField()
    article      = models.ForeignKey(to=Article, on_delete=models.CASCADE, null=False)

    def __str__(self):
        return f"Article_Metadata of {self.article.title}"

class Article_Auxiliary_Data(models.Model):
    # loved           = models.BooleanField() Should go to User data model
    count_of_loved  = models.IntegerField(default=0)
    count_of_shared = models.IntegerField(default=0)
    article         = models.ForeignKey(to=Article, on_delete=models.CASCADE, null=False)

    def __str__(self):
        return f"Article_Auxiliary_Data of {self.article.title}"