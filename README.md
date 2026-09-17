## Derived from the RiiConnect (now WiiLink) DNS repo

Changes from original:

- No executables, just the lists.
- Updated domains using WiiLink DNS (Last check April 2026, not that it changes often if at all)
- Added shell script to query the WiiLink DNS and output in hosts format.
  - Recommended: Adblock-style ```adguardhome-dnsrewrite.txt```
  - Alternative: hosts format ```dns_zones-hosts.txt```
  - For rewrites to work in Adguard Home: DNS Settings > Blocking mode > Default. This way uses the given IP to rewrite.
- Removed "mariokartwii.race.gs.wiimfi.de" because you can use any public DNS server.
- Removed "nplus.prod.silverbirchstudios.com" as it isn't resolved neither in public DNS servers nor WiiLink's.
- Added [Insignia for Xbox](https://insignia.live/)
  - Requires aditional steps
- Added Monster Hunter Old School domains.

# Usage

## General list

This list includes:
- [WiiLink](https://wiilink.ca/) (previously RiiConnect24)
- [Monster Hunter Old School](https://mholdschool.com/)

AFAIK it doesn't break modern services as their domains are either dead or unused

### Instalation

- Adguard Home WebGUI > Blocklists > Add list > Add custom list
  - URL: ```https://raw.githubusercontent.com/Linx-ESP/RiiConnect24-DNS-Server/refs/heads/clean/adguardhome-dnsrewrite.txt```
- Settings > DNS Settings > Blocking mode
  - Default (Needed for domains to be rewritten and not just blocked)

## Insignia list

This list includes:
- [Insignia for Xbox](https://insignia.live/)

Some of the domains do clash with modern Xbox services, so additional steps are needed:

- Add the blocklist. URL: ```https://raw.githubusercontent.com/Linx-ESP/RiiConnect24-DNS-Server/refs/heads/clean/adguardhome-insignia.txt```
- Settings > Client settings:
  - Add your Xbox console (either IP, MAC... doesn't matter) and name it as 'ogxbox'
  - The list is made so it only applies to clients with that name

# Additional info

- For some reason I couldn't make it work on Technitium DNS
- This is a little less reasonable than setting those domains to be forwarded to their specific service DNS server  
- [Wii Link's dns zones](https://github.com/WiiLink24/DNS-Server/blob/master/dns_zones-hosts.txt)  
- I think I should take a look at the scripts again, also for AAAA/IPv6 records... Oct '26 when I'm writing this
