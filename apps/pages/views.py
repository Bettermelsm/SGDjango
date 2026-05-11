from django.shortcuts import render
from django.http import HttpResponse

# Create your views here.

#def index(request):

    # Page from the theme 
 #   return render(request, 'pages/index.html', {'segment': 'dashboard'})



#Ribosome_edit_202511061938
def website_home(request):
    """Sengene自定义首页"""
    return render(request, 'website/index.html')

#Ribosome_edit_202312042302
#add_sub_web
def about(request):
    return render(request,'website/about.html')

def service(request):
    return render(request,'website/service.html')

def product(request):
    return render(request,'website/product.html')

def communication(request):
    return render(request,'website/communication.html')

def contact(request):
    return render(request,'website/contact.html')
