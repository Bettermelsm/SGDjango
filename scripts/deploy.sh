#!/bin/bash
# SGDjango One-Click Deploy Script
# Usage: bash scripts/deploy.sh
set -e

echo "========================================="
echo "  SGDjango 一键部署脚本"
echo "========================================="

PROJECT_DIR="/root/Django/soft-ui-dashboard-django"
VENV_DIR="$PROJECT_DIR/env"

# 1. System dependencies
echo "[1/6] 安装系统依赖..."
apt-get update -qq
apt-get install -y -qq python3-pip python3-venv nginx 2>/dev/null

# 2. Virtual environment
echo "[2/6] 配置 Python 虚拟环境..."
if [ ! -d "$VENV_DIR" ]; then
    python3 -m venv "$VENV_DIR"
fi
source "$VENV_DIR/bin/activate"

# 3. Python dependencies
echo "[3/6] 安装 Python 依赖..."
pip install --upgrade pip -q
pip install -r "$PROJECT_DIR/requirements.txt" -q

# 4. Compile translations
echo "[4/6] 编译翻译文件..."
cd "$PROJECT_DIR"
python -c "
import polib, os
po_path = 'locale/en/LC_MESSAGES/django.po'
mo_path = 'locale/en/LC_MESSAGES/django.mo'
if os.path.exists(po_path):
    po = polib.pofile(po_path)
    po.save_as_mofile(mo_path)
    print(f'Compiled {len(po)} translations')
else:
    print('No .po file found')
"

# 5. Collect static files
echo "[5/6] 收集静态文件..."
python manage.py collectstatic --noinput -q 2>/dev/null || echo "(collectstatic skipped)"

# 6. Gunicorn service
echo "[6/6] 配置 Gunicorn 服务..."
cat > /etc/systemd/system/gunicorn.service << EOF
[Unit]
Description=Gunicorn for SGDjango
After=network.target

[Service]
User=root
WorkingDirectory=$PROJECT_DIR
ExecStart=$VENV_DIR/bin/gunicorn config.wsgi:application --workers 3 --bind 127.0.0.1:8000
Restart=always

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl enable gunicorn
systemctl restart gunicorn

echo ""
echo "========================================="
echo "  部署完成!"
echo "  验证: curl -s -o /dev/null -w '%{http_code}' http://localhost/"
echo "========================================="
