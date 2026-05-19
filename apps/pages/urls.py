from django.urls import path

from . import views

urlpatterns = [
    path('',views.website_home,name='home'),#Ribosome_edited
    path('about/', views.about, name='about'),#Ribosome_edited
    path('service/', views.service, name='service'),
    path('product/', views.product, name='product'),
    path('ai/', views.ai, name='ai'),
    path('communication/', views.communication, name='communication'),
    path('contact/', views.contact, name='contact'),
]

