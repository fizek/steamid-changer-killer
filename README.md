# steamid-changer-killer
How to protect srcds from steamid-changer.

CURRENT STATUS: NOT READY
For polish version follow this link: https://fizek.pl/sck (TBD)


I will show you my idea how to protect CS:Source server from cheaters which use steamid changer software
I use vps, bash and Source RCON client for command line form here: https://github.com/n0la/rcon

1. Logs
You need logs from server which are you want to protect. Besides /cstrike/logs and /cstrike/addons/sourcemod/logs (these will be also needed) I created my own logs based on smac_status (so for working project, you need SMAC installed - or you can extract this command from source code as well – for example from here: https://github.com/Nerus87/smac/blob/master/scripting/smac.sp) command executed from RCON client.
