# LUDA
# 简单的表单网页，实现登录功能，数据来自数据库


# 目录说明

├─ LUDA
│  ├─ __pychache__
│  ├─ __init__.py  
│  ├─ .DS_Store     
│  ├─ asgi.py
│  ├─ settings.py
│  ├─ urls.py
│  └─ wsgi.py
├─ static  //用于存放网页需要的CSS/JS/IMG/FONT等文件
│  ├─ assets
│  ├─ bootstrap
│  ├─ css   
│  ├─ font
│  ├─ img
│  ├─ js
│  └─ .DS_Store
├─ templates //用于存放HTML文件
│  ├─ .DS_Store
│  ├─ forgot.html //“忘记密码”界面--功能未完全实现
│  ├─ login.html //”登录“界面
│  ├─ main.html //”网站主页“界面
│  ├─ register.html //”注册“界面
│  ├─ reset.html //”重置密码“界面--功能未完全实现
│  └─ user.html //“用户主页”界面--功能未完全实现
├─ .DS_Store
├─ db.sqlite3
├─ sql
│  ├─ LUDA_database.sql
│  ├─ LUDA_tables.sql
│  └─ LUDA_triggers.sql
├─ manage.py
└─ README.md

# 构建环境

VSCODE下编写HTML文件，CSS/JS均来自框架和网络
数据库来自MySQL
连接数据库的框架是以Python为基础的Django架构

# 运行方法

1.确认本机已安装Django
2.来到项目文件目录下，在终端输入
    python manage.py migrate
    python3 manage.py runserver

# 错误记录

1. Error:”…TemplateDoesNotExist:index.html”
    解决方法：
    在setting.py的TEMPLATE’DIR’[]加入模版路径
    ’DIRS’:[os.path.join(BASE_DIR, ‘template’)]
2.从static文件夹中调用文件的方法：
    2.1 在settings.py中添加：
        STATIC_URL = '/static/'
        STATICFILES_DIRS = (os.path.join(BASE_DIR, 'static/'),)
    2.2 在所有用到static中文件的HTML中添加：
        {% load static %}
        且将link改为如下格式：
        <link rel="stylesheet" type="text/css" href="{% static 'assets/css/plugins.css' %}">
