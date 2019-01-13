#!/bin/sh



# Check if an IP address is listed on one of the following blacklists
#-------------------------------------------------------------------
#list of the blacklists

BLISTS="
    cbl.abuseat.org
    dnsbl.sorbs.net
    bl.spamcop.net
    zen.spamhaus.org
    combined.njabl.org
    bl.spamcop.net
   access.redhawk.org
bl.emailbasura.org
bl.spamcop.net
blackholes.five-ten-sg.com
block.dnsbl.sorbs.net
cart00ney.surriel.com
dev.null.dk
dialups.visi.com
dnsbl.anticaptcha.net
dnsbl.justspam.org
dnsbl.sorbs.net
dnsbl-2.uceprotect.net
dul.dnsbl.sorbs.net
hil.habeas.com
intruders.docs.uu.se
l2.apews.org
msgid.bl.gweep.ca
old.dnsbl.sorbs.net
proxy.bl.gweep.ca
rbl.schulte.org
relays.bl.gweep.ca
relays.nether.net
smtp.dnsbl.sorbs.net
spam.olsentech.net
tor.ahbl.org
web.dnsbl.sorbs.net
zombie.dnsbl.sorbs.net
rbl.megarbl.net
b.barracudacentral.org
bl.shlink.org
bl.technovision.dk
blackholes.wirehub.net
blocked.hilli.dk
cbl.abuseat.org
dialup.blacklist.jippg.org
dnsbl.abuse.ch
dnsbl.antispam.or.id
dnsbl.kempt.net
dnsbl.tornevall.org
dnsbl-3.uceprotect.net
dul.ru
black.junkemailfilter.com
ips.backscatterer.org
mail-abuse.blacklist.jippg.org
new.dnsbl.sorbs.net
opm.tornevall.org
psbl.surriel.com
rbl.snark.net
relays.bl.kundenserver.de
rsbl.aupads.org
socks.dnsbl.sorbs.net
spamguard.leadmon.net
tor.dnsbl.sectoor.de
xbl.spamhaus.org
dnsbl.inps.de
bl.csma.biz
bl.spamcannibal.org
bl.tiopan.com
blacklist.sci.kun.nl
bogons.cymru.com
cblless.anti-spam.org.cn
dialups.mail-abuse.org
dnsbl.ahbl.org
dnsbl.dronebl.org
dnsbl.njabl.org
dnsbl-1.uceprotect.net
duinv.aupads.org
escalations.dnsbl.sorbs.net
http.dnsbl.sorbs.net
korea.services.net
misc.dnsbl.sorbs.net
no-more-funn.moensted.dk
pbl.spamhaus.org
pss.spambusters.org.ar
recent.dnsbl.sorbs.net
relays.mail-abuse.org
sbl.spamhaus.org
spam.dnsbl.sorbs.net
spamsources.fabel.dk
ubl.unsubscore.com
zen.spamhaus.org


"
#assuming the list of IP addresses are in a .txt

for address in `cat blacklist.txt`;
  do

#IP address validation


reverse=$(echo $address |
  sed -ne "s~^\([0-9]\{1,3\}\)\.\([0-9]\{1,3\}\)\.\([0-9]\{1,3\}\)\.\([0-9]\{1,3\}\)$~\4.\3.\2.\1~p")

       if [ "x${reverse}" = "x" ] ; then
echo "$address doesn't look like a valid IP address"
continue 

fi


# -- do a reverse ( address -> name) DNS lookup
REVERSE_DNS=$(dig +short -x $address)

echo IP $address NAME ${REVERSE_DNS:----}

# -- cycle through all the blacklists
for BL in ${BLISTS} ; do

    # show the reversed IP and append the name of the blacklist
   printf "%-40s" " ${reverse}.${BL}."

    # use dig to lookup the name in the blacklist
    LISTED="$(dig +short -t a ${reverse}.${BL}.)"


    echo ${LISTED:----}

done

#==========================================
#echo OK =$(grep -c "OKAY" blacklistresults.txt)
done  >  blacklistresults.txt

