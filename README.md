# SGDjango - 三君科技官网

广州三君科技有限公司官方网站，基于 Django 构建，支持中英文双语切换。

## 快速部署

```bash
# 克隆项目
git clone https://github.com/Bettermelsm/SGDjango.git
cd SGDjango

# 创建虚拟环境
python3 -m venv env
source env/bin/activate

# 安装依赖
pip install -r requirements.txt

# 编译翻译文件
python -c "import polib; po=polib.pofile('locale/en/LC_MESSAGES/django.po'); po.save_as_mofile('locale/en/LC_MESSAGES/django.mo')"

# 收集静态文件
python manage.py collectstatic --noinput

# 启动开发服务器
python manage.py runserver 0.0.0.0:8000
```

## 生产部署

```bash
bash scripts/deploy.sh
```

## 项目结构

```
SGDjango/
├── config/             # Django 配置 (settings, urls, wsgi)
├── apps/pages/         # 页面视图与路由
├── templates/          # HTML 模板 (含 i18n)
├── static/             # 静态资源 (CSS, 图片)
├── locale/en/          # 英文翻译 (.po/.mo)
├── scripts/            # 运维脚本
├── nginx/              # Nginx 配置参考
└── manage.py
```

## 中英文切换

- 默认中文: `http://your-domain/`
- 英文版: `http://your-domain/en/`
- 导航栏右上角可切换语言

## 运维诊断

```bash
bash scripts/website_status.sh   # 快速状态检查
bash scripts/diagnose.sh          # 完整诊断
```

## 功能页面

| 页面 | 路径 | 说明 |
|------|------|------|
| 首页 | `/` | 公司简介、核心业务 |
| 关于我们 | `/about/` | 公司详情、团队优势 |
| 技术服务 | `/service/` | 动物实验平台、疾病模型 |
| 产品中心 | `/product/` | 科研仪器、试剂耗材 |
| 人工智能 | `/ai/` | 智能体部署、鼠机接口、具身机器人 |
| 技术交流 | `/communication/` | 技术文章 |
| 联系我们 | `/contact/` | 联系方式、微信二维码 |

## License

Private - 广州三君科技有限公司
