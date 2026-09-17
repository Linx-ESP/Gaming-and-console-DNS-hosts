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
- From october 2026 I won't mention specific domains that get removed or change, just more general changes. Commit history is available of course
- Joined Insignia list since it only applies to devices tagged in a particular way

# Usage

## General

This includes:
- [WiiLink](https://wiilink.ca/) (previously RiiConnect24)
- [Monster Hunter Old School](https://mholdschool.com/)

AFAIK it doesn't break modern services as their domains are either dead or unused. If they do please notify me to set them up like Insignia's

### Instalation

- Adguard Home WebGUI > Blocklists > Add list > Add custom list
  - URL: ```https://raw.githubusercontent.com/Linx-ESP/Gaming-and-console-DNS-hosts/refs/heads/clean/adguardhome-dnsrewrite.txt```
- Settings > DNS Settings > Blocking mode
  - Default (Needed for domains to be rewritten and not just blocked)

## Insignia

This adds:
- [Insignia for Xbox](https://insignia.live/)

Some of the domains do clash with modern Xbox services, so additional steps are needed:

- Add the blocklist. URL: ```https://raw.githubusercontent.com/Linx-ESP/Gaming-and-console-DNS-hosts/refs/heads/clean/adguardhome-dnsrewrite.txt```
- Settings > Client settings:
  - Add your Xbox console (either IP, MAC... doesn't matter) and name it as 'ogxbox'
  - This way only applies to clients with that name since those domains are still in use

# Additional info

- `adguardhome-insignia.txt` is kept for compatibility, is integrated in `adguardhome-dnsrewrite.txt`
- `dns_zones-hosts.txt` doesn't have Insignia, I don't use pihole so I don't know if there is an equivalent option to apply to specific clients like adguard
- For some reason I couldn't make it work on Technitium DNS
- This is a little less reasonable than setting those domains to be forwarded to their specific service DNS server  
- I think I should take a look at the scripts again, also for AAAA/IPv6 records... Oct '26 when I'm writing this  
- Repo has been renamed from `Linx-ESP/RiiConnect24-DNS-Server` but anything pointing to it will keep working as this is how GitHub works thankfully. Change done to not keep RiiConnect's name from forking.  
  
## Why do I do it this way?
  
Why do I check again their servers and not copy from their provided lists ([WiiLink](https://github.com/WiiLink24/DNS-Server) | [Monster Hunter Old School](https://github.com/MH-Oldschool/mhosdns) | [Insignia](https://github.com/insignia-live/insigniaDNS)):  
- There were domains from RiiConnect that don't appear anymore on the WiiLink repo that they still resolve   
- Some of the WiiLink provided domains are (or were) not modified from normal upstream DNS servers  
- Some of the WiiLink provided domains are (or were) not resolved by their own DNS server  
- I will contact them or do a PR about it to them but still, I prefer to query their own DNS server and compare against Cloudflare's for unchanged ones  
- I think it will be easier to CI/CD with GitHub actions... Of course I haven't done it so whatever.  
  

