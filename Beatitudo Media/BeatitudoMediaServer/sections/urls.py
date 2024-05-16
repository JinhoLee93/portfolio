from django.urls import path
from . import views

urlpatterns = [
    path('send-sections/', views.SectionsAPI.SectionRelated.send_sections),
    path('increase-likes/', views.SectionsAPI.ArticleRelated.increase_likes),
]