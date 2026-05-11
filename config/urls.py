"""SGDjango URL Configuration - Sengene Website with i18n"""
from django.conf.urls.i18n import i18n_patterns
from django.contrib import admin
from django.urls import include, path

urlpatterns = [
    path('i18n/', include('django.conf.urls.i18n')),
]

urlpatterns += i18n_patterns(
    path('', include('apps.pages.urls')),
    path("admin/", admin.site.urls),
    prefix_default_language=False,
)
