from django.urls import path
from . import views

urlpatterns = [
    path('send-sections/', views.SectionsAPI.as_view()),
    path('update-count-of-loved/', views.ArticleAuxiliaryDataAPI.as_view()),
    path('update-article-views/', views.ArticleMetadataAPI.as_view()),
    path('translate-user-articles-into-articles/', views.ArticleAPI.as_view()),
    path('beatitudo-web-services-related/', views.BeatitudoMediaWebServicesAPI.as_view()),
]