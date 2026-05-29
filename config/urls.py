"""SGDjango URL Configuration - Sengene Website with i18n"""
from django.conf.urls.i18n import i18n_patterns
from django.contrib import admin
from django.contrib.sitemaps.views import sitemap
from django.urls import include, path
from django.views.static import serve
from django.conf import settings

from apps.pages.sitemap import StaticViewSitemap

sitemaps = {
    'pages': StaticViewSitemap,
}

urlpatterns = [
    path('i18n/', include('django.conf.urls.i18n')),
    path('sitemap.xml', sitemap, {'sitemaps': sitemaps}, name='sitemap'),
    path('robots.txt', serve, {'path': 'robots.txt', 'document_root': settings.STATICFILES_DIRS[0]}),
]

urlpatterns += i18n_patterns(
    path('', include('apps.pages.urls')),
    path("admin/", admin.site.urls),
    prefix_default_language=False,
)
