#!/bin/bash
# SGDjango Diagnostic Script
# Usage: bash scripts/diagnose.sh

echo "========================================="
echo "  SGDjango 网站诊断脚本"
echo "  时间: $(date '+%Y-%m-%d %H:%M:%S')"
echo "========================================="
echo ""

# 1. Django 进程
echo "[1] Django / Gunicorn 进程"
ps aux | grep -E 'gunicorn|django' | grep -v grep
echo ""

# 2. 端口监听
echo "[2] 端口监听状态"
ss -tlnp | grep -E ':(80|443|8000)\s'
echo ""

# 3. Nginx 状态
echo "[3] Nginx 状态"
systemctl is-active nginx 2>/dev/null && echo "Nginx: 运行中" || echo "Nginx: 未运行"
nginx -t 2>&1
echo ""

# 4. 防火墙
echo "[4] 防火墙规则"
iptables -L -n 2>/dev/null | head -20
echo ""

# 5. HTTP 测试
echo "[5] HTTP 响应测试"
echo -n "  首页 (CN): "
curl -s -o /dev/null -w "%{http_code}" http://localhost/ 2>/dev/null
echo ""
echo -n "  首页 (EN): "
curl -s -o /dev/null -w "%{http_code}" http://localhost/en/ 2>/dev/null
echo ""
echo -n "  外网访问: "
curl -s -o /dev/null -w "%{http_code}" http://sengene.top/ 2>/dev/null
echo ""
echo ""

# 6. Django 配置检查
echo "[6] Django 配置检查"
cd /root/Django/soft-ui-dashboard-django
python3 manage.py check --deploy 2>&1 | tail -5
echo ""

# 7. 错误日志
echo "[7] 最近错误日志 (Gunicorn)"
journalctl -u gunicorn --no-pager -n 10 2>/dev/null
echo ""

# 8. 系统资源
echo "[8] 系统资源"
echo "  磁盘使用:"
df -h / | tail -1
echo "  内存使用:"
free -h | head -2
echo ""

echo "========================================="
echo "  诊断完成"
echo "========================================="
