from django.urls import path
from . import views

urlpatterns = [
    path('user-related/', views.BeatitudoMediaUserAPI.as_view()),
    path('loved-articles-related/', views.LovedArticlesAPI.as_view()),
    path('viewed-articles-related/', views.ViewedArticlesAPI.as_view())
]