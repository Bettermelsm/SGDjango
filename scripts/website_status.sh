#!/bin/bash
# SGDjango Quick Status Check
# Usage: bash scripts/website_status.sh

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

echo "SGDjango 网站状态 $(date '+%H:%M:%S')"
echo "-----------------------------------"

# Services
for svc in nginx gunicorn; do
    if systemctl is-active --quiet $svc 2>/dev/null; then
        echo -e "$svc: ${GREEN}运行中${NC}"
    else
        echo -e "$svc: ${RED}未运行${NC}"
    fi
done

# Processes
gunicorn_count=$(pgrep -f gunicorn | wc -l)
echo "Gunicorn workers: $gunicorn_count"

# Ports
echo "端口 8000: $(ss -tlnp | grep ':8000' | wc -l | xargs -I{} bash -c '[ {} -gt 0 ] && echo -e \"${GREEN}监听中${NC}\" || echo -e \"${RED}未监听${NC}\"')"

# HTTP
http_cn=$(curl -s -o /dev/null -w "%{http_code}" http://localhost/ 2>/dev/null)
http_en=$(curl -s -o /dev/null -w "%{http_code}" http://localhost/en/ 2>/dev/null)
http_ext=$(curl -s -o /dev/null -w "%{http_code}" http://sengene.top/ 2>/dev/null)

echo -n "HTTP 首页(CN): "
[ "$http_cn" = "200" ] && echo -e "${GREEN}${http_cn}${NC}" || echo -e "${RED}${http_cn}${NC}"

echo -n "HTTP 首页(EN): "
[ "$http_en" = "200" ] && echo -e "${GREEN}${http_en}${NC}" || echo -e "${RED}${http_en}${NC}"

echo -n "HTTP 外网: "
[ "$http_ext" = "200" ] && echo -e "${GREEN}${http_ext}${NC}" || echo -e "${RED}${http_ext}${NC}"

# i18n check
echo -n "i18n 翻译文件: "
if [ -f /root/Django/soft-ui-dashboard-django/locale/en/LC_MESSAGES/django.mo ]; then
    echo -e "${GREEN}存在${NC}"
else
    echo -e "${RED}缺失${NC}"
fi

# Resources
echo "磁盘: $(df -h / | tail -1 | awk '{print $5}')"
echo "内存: $(free -h | grep Mem | awk '{print $3"/"$2}')"
echo "-----------------------------------"
