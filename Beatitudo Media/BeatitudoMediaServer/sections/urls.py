from django.urls import path
from . import views

urlpatterns = [
    path('send-sections/', views.send_sections)
]