!/bin/bash
cd /home/chenxinxing/gfw
python gfwListgen.py
git add gfwdomains.conf
git add gfwsetfree.conf
git commit -m "auto general by google vps crontab on %date%"
git push -u origin master

