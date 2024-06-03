from django.db import models

# Create your models here.
class BeatitudoMediaUser(models.Model):
    email = models.TextField(unique=True)
    nickname = models.TextField()
    
    def __str__(self):
        return f"user {self.email}"
    
    def serialize(self):
        return {
            'id' : self.id,
            'email' : self.email,
            'nickname' : self.nickname
        }

class ViewedArticle(models.Model):
    beatitudo_media_user = models.ForeignKey(to=BeatitudoMediaUser, related_name='viewed_article', on_delete=models.CASCADE, null=False)
    article_id = models.IntegerField()

class LovedArticle(models.Model):
    beatitudo_media_user = models.ForeignKey(to=BeatitudoMediaUser, related_name='loved_article', on_delete=models.CASCADE, null=False)
    article_id = models.IntegerField()