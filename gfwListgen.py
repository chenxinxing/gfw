# Modified from http://autoddvpn.googlecode.com/svn/trunk/grace.d/gfwListgen.py
#!/usr/bin/env python

#from os.path import expanduser
import urllib
import base64
import string
import re

gfwlist = 'http://autoproxy-gfwlist.googlecode.com/svn/trunk/gfwlist.txt'

gfwlistfile = open('gfwlist.txt', 'w')
gfwdn = open('gfwdomains.conf', 'w')
gfwsetfree = open('gfwsetfree.conf', 'w')


# some sites can be visited via https or is already in known list
oklist = ['flickr.com','amazon.com','twimg.com']
#print "fetching gfwList ..."
d = urllib.urlopen(gfwlist).read()
#print("gfwList fetched")

data = base64.b64decode(d)
lines = string.split(data, "\n")

for l in lines:
        gfwlistfile.write(l+'\n')
gfwlistfile.close()

newlist = []

for l in lines:
        if len(l) == 0:
                continue
        if l[0] == "!":
                continue
        if l[0] == "@":
                continue
        if l[0] == "[":
                continue
        l = string.replace(l, "||","")
        l = string.replace(l, "|https://","")
        l = string.replace(l, "|http://","")
        # strip everything from "/" to the end
        if l.find("/") != -1:
                l = l[0:l.find("/")]
        if l.find("%2F") != -1:
                continue
        if l.find("*") != -1:
                continue
        if l.find(".") == -1:
                continue
        if l in oklist:
                continue
        newlist.append(l)

newlist = list(set(newlist))
newlist.sort()

# generate dnsmasq configuration

ipaddress = '^([01]?\d\d?|2[0-4]\d|25[0-5])\.([01]?\d\d?|2[0-4]\d|25[0-5])\.([01]?\d\d?|2[0-4]\d|25[0-5])\.([01]?\d\d?|2[0-4]\d|25[0-5])$'

for l in newlist:
#        if l == re.compile(ipaddress):
	if l == re.compile("^\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}$"):
                gfwsetfree.write('ipset=/'+l+'/setmefree\n')
        else:
		gfwdn.write('server=/'+l+'/127.0.0.1#1053\n')
                gfwsetfree.write('ipset=/'+l+'/setmefree\n')
gfwdn.close()
gfwsetfree.close()

