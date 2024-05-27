from django.urls import path
from . import views

urlpatterns = [
    path('send-sections/', views.SectionsAPI.as_view()),
    path('update-count-of-loved/', views.ArticleAuxiliaryDataAPI.as_view()),
    path('update-article-views/<int:pk>/', views.ArticleMetadataAPI.as_view()),
]