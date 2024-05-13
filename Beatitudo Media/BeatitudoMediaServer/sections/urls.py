from django.urls import path
from . import views

urlpatterns = [
    path('send_sections/', views.send_sections)
]