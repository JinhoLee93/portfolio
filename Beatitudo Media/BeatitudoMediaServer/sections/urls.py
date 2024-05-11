from django.urls import path
from . import views

urlpatterns = [
    path('section_contents/', views.send_sections)
]