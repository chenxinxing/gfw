#!/bin/sh
cnlist() {
#    wget -4 --no-check-certificate -O /tmp/dnsmasq.d/accelerated-domains.china.conf https://raw.githubusercontent.com/felixonmars/dnsmasq-china-list/master/accelerated-domains.china.conf
    wget -4 --no-check-certificate -O /tmp/dnsmasq.d/bogus-nxdomain.china.conf https://raw.githubusercontent.com/felixonmars/dnsmasq-china-list/master/bogus-nxdomain.china.conf
}

adblock() {
    wget -4 --no-check-certificate -O - https://easylist-downloads.adblockplus.org/easylistchina+easylist.txt | grep ^\|\|[^\*]*\^$ | sed -e 's:||:address\=\/:' -e 's:\^:/127\.0\.0\.1:' | uniq > /tmp/dnsmasq.d/adblock.conf
    wget -4 --no-check-certificate -O - https://raw.githubusercontent.com/kcschan/AdditionalAdblock/master/list.txt | grep ^\|\|[^\*]*\^$ | sed -e 's:||:address\=\/:' -e 's:\^:/127\.0\.0\.1:' >> /tmp/dnsmasq.d/adblock.conf
}

gfw(){
    wget --no-check-certificate -O /tmp/dnsmasq.d/gfwsetfree.conf https://raw.githubusercontent.com/chenxinxing/gfw/master/gfwsetfree.conf 
    wget --no-check-certificate -O /tmp/dnsmasq.d/gfwdomains.conf https://raw.githubusercontent.com/chenxinxing/gfw/master/gfwdomains.conf
}

cnlist
gfw
#adblock

#cp /home/chenxx/gfwdomains.conf /tmp/dnsmasq.d/ && chmod -x /tmp/dnsmasq.d/gfwdomains.conf
cp /home/chenxx/config/useradded.conf /tmp/dnsmasq.d/ && chmod -x /tmp/dnsmasq.d/useradded.conf
cp /home/chenxx/config/googleservice.conf /tmp/dnsmasq.d/ && chmod -x /tmp/dnsmasq.d/googleservice.conf
cp /home/chenxx/config/cntop50.conf /tmp/dnsmasq.d/ && chmod -x /tmp/dnsmasq.d/cntop50.conf
/etc/init.d/dnsmasq restart
#/etc/init.d/dnscrypt-proxy start
sh /root/ip.sh /root/ipset_list