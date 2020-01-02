"""LUDA URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/3.0/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
import pymysql
from django.contrib import admin
from django.urls import path
from django.shortcuts import render
from django.shortcuts import HttpResponse,HttpResponseRedirect
from django.shortcuts import HttpResponsePermanentRedirect
# import mimetypes

def login(request):
    # mimetypes.add_type("application/javascript", ".js", True)
    return render(request, 'login.html')

def register(request):
    return render(request, 'register.html')

def user(request):
    return render(request, 'user.html')

def forgot(request):
    return render(request, 'forgot.html')

def reset(request):
    return render(request, 'reset.html')

def main(request):
    return render(request, 'main.html')

def query(request):
    has_user = 0
    a = request.GET
    username = a.get('username')
    password = a.get('password')
    user_tup = (username, password)

    db = pymysql.connect('localhost', 'root', 'samantha', 'LUDA')
    cursor = db.cursor()
    sql = 'SELECT * FROM userInfo;'
    cursor.execute(sql)
    all_data = cursor.fetchall()
    i = 0
    while i < len(all_data):
        if user_tup[0] == all_data[i][1] and user_tup[1] == all_data[i][2]:
            has_user = 1
            break
        else:
            i += 1
    if has_user == 1:
        return HttpResponseRedirect('/user/?username=%s'%username)
    else:
        return HttpResponse('用户名或密码错误！')

def save(request):
    has_user = 0
    a = request.GET
    username = a.get('username')
    email = a.get('email')
    password = a.get('password')
    db = pymysql.connect('localhost', 'root', 'samantha', 'LUDA')
    cursor = db.cursor()
    sql1 = 'SELECT * FROM userInfo;'
    cursor.execute(sql1)
    all_data = cursor.fetchall()
    i = 0
    while i < len(all_data):
        if username == all_data[i][1]:
            has_user = 1
            break
        else:
            i += 1
        if has_user == 0:
            userID = "%06d"%(len(all_data)+1)
            sql2 = 'INSERT INTO userInfo VALUES (\'%s\',\'%s\',\'%s\',0,\'wuhan\',120,\'%s\');'%(userID, username, password, email)
            cursor.execute(sql2)
            sql3 = 'CREATE USER \'%s\'@\'LOCALHOST\' IDENTIFIED BY \'%s\';'%(username, password)
            cursor.execute(sql3)
            return HttpResponse('注册成功！')
        else:
            return HttpResponse('用户名已存在！')

urlpatterns = [
    path('admin/', admin.site.urls),
    path('login/', login),
    path('register/', register),
    path('main/', main),
    path('forgot/', forgot),
    path('reset/', reset),
    path('user/', user),
    path('register/save', save),
    path('register/query', save),
    path('login/query', query),
    path('templates/query',query),
    path('login/forget', forgot),
    path('login/register', register),
    path('login/main', main),
]
