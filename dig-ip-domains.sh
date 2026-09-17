#!/bin/bash

# WiiLink DNS Server and domains (previously RiiConnect24)
dns_server="167.235.229.36" 

domains=(
"a.dls1.wiimmfi.de"
"api.tubefixer.ovh"
"available.gs.nintendowifi.net"
"axing.nintendowifi.net"
"ccs.cdn.sho.rc24.xyz"
"cfh.wapp.wii.com"
"dls1.ilostmymind.xyz"
"dls1.wiimmfi.de"
"ds.pokemon-gl.com"
"en-ds.pokemon-gl.com"
"ente.wapp.wii.com"
"entj.wapp.wii.com"
"entu.wapp.wii.com"
"es-ds.pokemon-gl.com"
"flipnote.hatena.com"
"fr-ds.pokemon-gl.com"
"gamespy.com"
"gamestats.gs.nintendowifi.net"
"gamestats2.gs.nintendowifi.net"
"gdata.youtube.com"
"geckocodes.org"
"gpcm.gs.nintendowifi.net"
"gs.nintendowifi.net"
"it-ds.pokemon-gl.com"
"ko-ds.pokemon-gl.com"
"maintenance.hatena.ne.jp"
"master.gs.nintendowifi.net"
"miicontest.wapp.wii.com"
"miicontestp.wapp.wii.com"
"ms.nintendo-europe.com"
"nas.nintendowifi.net"
"naswii.nintendowifi.net"
"natneg1.gs.nintendowifi.net"
"natneg2.gs.nintendowifi.net"
"natneg3.gs.nintendowifi.net"
"natneg4.gs.nintendowifi.net"
"natneg5.gs.nintendowifi.net"
"natneg6.gs.nintendowifi.net"
"news.wapp.wii.com"
"nwcs.wapp.wii.com"
"nwdsrvwdbctl.nintendo.co.jp"
"nzone001.nintendo-europe.com"
"peerchat.gs.nintendowifi.net"
"pkgdsprod.nintendo.co.jp"
"pkvldtprod.nintendo.co.jp"
"rs.nintendo.com"
"sake.gamespy.com"
"sake.gs.nintendowifi.net"
"secure.touchmasterconnect.com"
"syscheck.softwii.de"
"ugo.hatena.ne.jp"
"ugomemo.hatena.ne.jp"
"vt.wapp.wii.com"
"weather.wapp.wii.com"
"wii.nintendo.co.jp"
"wiirecommend.nintendo.com.au"
"wus.wapp.wii.com"
)

# Monster Hunter Old School
dns_server2="34.75.107.68"

domains2=(
 "dnas.playstation.org"
 "kddi-mmbb.jp"
 "corsair.capcom.co.jp"
 "skyhawk.capcom.co.jp"
 "viper.capcom.co.jp"
 "crusader.capcom.co.jp"
 "raptor.capcom.co.jp"
 "strike-raptor.capcom.co.jp"
 "goshawk.capcom.co.jp"
 "spector.capcom.co.jp"
 "meteor.capcom.co.jp"
 "voodoo.capcom.co.jp"
)


output_file_hosts="dns_zones-hosts.txt"
output_file_adguard="adguardhome-dnsrewrite.txt"

# Clear the output files if they exist
> $output_file_hosts
> $output_file_adguard

# It won't give a clean output if a domain answers multiple IPs. Doesn't handle errors.
# This must not output any IPv6 addresses. It shouldn't though.

echo "Processing first list of domains with DNS server: $dns_server"
for domain in "${domains[@]}"
do
  echo "Digging IP for $domain..."
  ip=$(dig +short $domain @$dns_server)
  echo "$ip $domain" >> $output_file_hosts
  echo "||$domain^\$dnsrewrite=NOERROR;A;$ip" >> $output_file_adguard
done

echo ""
echo "Processing second list of domains with DNS server: $dns_server2"
for domain in "${domains2[@]}"
do
  echo "Digging IP for $domain..."
  ip=$(dig +short $domain @$dns_server2)
  echo "$ip $domain" >> $output_file_hosts
  echo "||$domain^\$dnsrewrite=NOERROR;A;$ip" >> $output_file_adguard
done

echo ""
echo "Complete"
