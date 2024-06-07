from django.urls import path
from . import views

urlpatterns = [
    path('process-new-articles/', views.ProcessedArticleAPI.as_view())
]