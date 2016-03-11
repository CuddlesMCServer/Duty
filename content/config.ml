# Change settings here

config:
  lang:
    # Message to broadcast to the entire server when a staff member activates Duty mode
    onduty: "&e{name} is now on duty."
    # Message to broadcast to the entire server when a staff member deactivates Duty mode
    offduty: "&e{name} is now off duty."
    # This should be identical as your disconnect message
    fakequit: "&e{name} left the game."
    # This should be identical to your connection message
    fakejoin: "&e{name} joined the game."
    # Message to broadcast to the staff when a staff member activates silent duty mode
    onsilent: "&e{name} is on silent duty."
    # Message to broadcast to the staff when a staff member deactivates silent duty mode
    offsilent: "&e{name} is off silent duty."
  perm:
    # Permission required to enable OR disable duty mode. Give to both ranks below, or to the actual player!
    toggle: duty.toggle
    # Permission to give to the rank that staff are put into when they enable duty mode
    enabled: duty.enabled
  rank:
    # Rank for staff members who are on duty
    onduty: StaffOnDuty
    # Rank for staff members who are off duty
    offduty: StaffOffDuty
  gamemode:
    # Automatically set gamemode to these when toggling
    onduty: SPECTATOR
    offduty: SURVIVAL
s: {}
   
