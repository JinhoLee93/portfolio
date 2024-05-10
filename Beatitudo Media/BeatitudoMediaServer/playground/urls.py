from django.urls import path
from . import views

# URL Configuration Modules
urlpatterns = [
    path('hello/', views.say_hello)
]