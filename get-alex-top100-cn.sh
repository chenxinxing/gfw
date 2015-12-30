Attach1="./ChinaCDN.txt"
Attach2="./ChinaCustom.txt"
ChinaDNS="114.114.114.114"
OutPutFile="./alex-top100-cn.conf"


echo "##Dnsmasq.conf generated date:$(date)##" >>$OutPutFile
echo "##Dnsmasq.conf generated date:$(date)##"
echo "##All .CN Domain##" >>$OutPutFile
echo "##All .CN Domain##" 
echo "server=/.cn/$ChinaDNS" >>$OutPutFile
echo "server=/.com.cn/$ChinaDNS" >>$OutPutFile
echo "##Alexa Top500 In China##">>$OutPutFile
echo "##Alexa Top500 In China##"
for i in 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 
do
echo -ne "\r# Generate dnsoption for Page $i##"
curl -s "http://www.alexa.com/topsites/countries;$i/CN" | grep "/siteinfo/" | grep -vE ".cn|twitter|tumblr|google|gmail|flickr|youtube|facebook|amazon|godaddy|wikipedia" | sed -e "s#^[^\/]*\/[^\/]*\/[^\/]*/\\(.*\)\".*#server=/.\1/$ChinaDNS#g" >>$OutPutFile
done
