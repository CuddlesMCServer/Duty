local Duty = lukkit.addPlugin("Duty", "2.2.1",
    function(plugin)
        plugin.onEnable(
            function()
                plugin.config.setDefault("config.enable.toggle", true)
                plugin.config.setDefault("config.enable.silent", true)
                plugin.config.setDefault("config.enable.vanish", true)
                plugin.config.setDefault("config.enable.joindisable", true)
                plugin.config.setDefault("config.enable.location", true)
                plugin.config.setDefault("config.enable.vanishchatblock", true)
                plugin.config.setDefault("config.enable.vanishchatcommand", false)
                plugin.config.setDefault("config.lang.onduty", "&e&o{name} is now on duty.")
                plugin.config.setDefault("config.lang.offduty", "&e&o{name} is now off duty.")
                plugin.config.setDefault("config.lang.onsilent", "&7&o{name} is on silent duty.")
                plugin.config.setDefault("config.lang.offsilent", "&7&o{name} is off silent duty.")
                plugin.config.setDefault("config.lang.fakequit", "&e{name} left the game.")
                plugin.config.setDefault("config.lang.fakejoin", "&e{name} joined the game.")
                plugin.config.setDefault("config.perm.toggle", "duty.toggle")
                plugin.config.setDefault("config.perm.enabled", "duty.enabled")
                plugin.config.setDefault("config.rank.onduty", "StaffOnDuty")
                plugin.config.setDefault("config.rank.offduty", "StaffOffDuty")
                plugin.config.setDefault("config.rank.mode", "add") -- Can be add or set
                plugin.config.setDefault("config.gamemode.onduty", "SPECTATOR")
                plugin.config.setDefault("config.gamemode.offduty", "SURVIVAL")
                plugin.config.setDefault("config.fallbacklocation.w", "world")
                plugin.config.setDefault("config.fallbacklocation.x", -240)
                plugin.config.setDefault("config.fallbacklocation.y", 73)
                plugin.config.setDefault("config.fallbacklocation.z", -32)
                plugin.config.setDefault("config.vanishchat.command", "helpop")
                plugin.config.save()
                
                plugin.print("Coded by Lord_Cuddles for mx.cuddl.es in Lukkit")
                plugin.print("Enabled version ".. plugin.version .." successfully")
                
            end
        )
        
        plugin.addCommand("duty", "Enable or disable duty mode", "/duty",
            function(sender, args)
                if plugin.config.get("config.enable.toggle") == true then
                    if sender:hasPermission("duty.toggle") == true then
                        if args[1] == "off" or sender:hasPermission(plugin.config.get("config.perm.enabled")) == true then
                            
                            local u = sender:getUniqueId():toString()
                            local w = plugin.config.get("s."..u..".w")
                            local x = plugin.config.get("s."..u..".x")
                            local y = plugin.config.get("s."..u..".y")
                            local z = plugin.config.get("s."..u..".z")
                            
                            local m = plugin.config.get("s."..u..".m")
                            local world = sender:getPlayer():getLocation():getWorld():getName()
                            if not w then w = plugin.config.get("config.fallbacklocation.w") end
                            if world == w then
                                if m == "s" then
                                    local msg = plugin.config.get("config.lang.offsilent")
                                    msg = string.gsub(msg, "{name}", sender:getName())
                                    msg = string.gsub(msg, "&", "§")
                                    server:broadcast(msg, plugin.config.get("config.perm.toggle"))
                                elseif m == "v" then
                                    local msg = plugin.config.get("config.lang.onsilent")
                                    msg = string.gsub(msg, "{name}", sender:getName())
                                    msg = string.gsub(msg, "&", "§")
                                    server:broadcast(msg, plugin.config.get("config.perm.toggle"))
                                    server:dispatchCommand(server:getConsoleSender(), "essentials:vanish "..sender:getName().." off")
                                    local msg = plugin.config.get("config.lang.fakejoin")
                                    msg = string.gsub(msg, "{name}", sender:getName())
                                    msg = string.gsub(msg, "&", "§")
                                    broadcast(msg)
                                else
                                    local msg = plugin.config.get("config.lang.offduty")
                                    msg = string.gsub(msg, "{name}", sender:getName())
                                    msg = string.gsub(msg, "&", "§")
                                    broadcast(msg)
                                end
                                plugin.config.clear("s."..u)
                                plugin.config.save()
                                server:dispatchCommand(server:getConsoleSender(), "pex user "..sender:getName().." group add "..plugin.config.get("config.rank.offduty"))
                                server:dispatchCommand(server:getConsoleSender(), "pex user "..sender:getName().." group remove "..plugin.config.get("config.rank.onduty"))
                                server:dispatchCommand(server:getConsoleSender(), "minecraft:gamemode "..plugin.config.get("config.gamemode.offduty").." "..sender:getName())
                                if x and y and z and plugin.config.get("config.enable.location") == true then
                                    server:dispatchCommand(server:getConsoleSender(), "minecraft:tp "..sender:getName().." "..x.." "..y.." "..z)
                                else
                                    local x = plugin.config.get("config.fallbacklocation.x")
                                    local y = plugin.config.get("config.fallbacklocation.y")
                                    local z = plugin.config.get("config.fallbacklocation.z")
                                    server:dispatchCommand(server:getConsoleSender(), "minecraft:tp "..sender:getName().." "..x.." "..y.." "..z)
                                    if plugin.config.get("config.enable.location") == true then
                                        sender:sendMessage("§bYou were teleported to spawn as previous location data was not found.")
                                    end
                                end
                            else
                                sender:sendMessage("§eYou must be in world '"..w.."' to disable duty mode!")
                            end
                            
                        elseif args[1] == "on" or sender:hasPermission(plugin.config.get("config.perm.enabled")) == false then
                            
                            local u = sender:getUniqueId():toString()
                            local w = sender:getPlayer():getLocation():getWorld():getName()
                            local x = sender:getPlayer():getLocation():getX()
                            local y = sender:getPlayer():getLocation():getY()
                            local z = sender:getPlayer():getLocation():getZ()
                            
                            plugin.config.set("s."..u..".e", true)
                            plugin.config.set("s."..u..".w", w)
                            plugin.config.set("s."..u..".x", x)
                            plugin.config.set("s."..u..".y", y)
                            plugin.config.set("s."..u..".z", z)
                            if args[1] == "-s" and plugin.config.get("config.enable.silent") == true then
                                plugin.config.set("s."..u..".m", "s")
                            elseif args[1] == "-v" and plugin.config.get("config.enable.vanish") == true then
                                plugin.config.set("s."..u..".m", "v")
                            else
                                plugin.config.set("s."..u..".m", "n")
                            end
                            plugin.config.save()
                            server:dispatchCommand(server:getConsoleSender(), "pex user "..sender:getName().." group add "..plugin.config.get("config.rank.onduty"))
                            server:dispatchCommand(server:getConsoleSender(), "pex user "..sender:getName().." group remove "..plugin.config.get("config.rank.offduty"))
                            server:dispatchCommand(server:getConsoleSender(), "minecraft:gamemode "..plugin.config.get("config.gamemode.onduty").." "..sender:getName())
                            if args[1] == "-v" and plugin.config.get("config.enable.vanish") == true then
                                local msg = plugin.config.get("config.lang.onsilent")
                                msg = string.gsub(msg, "{name}", sender:getName())
                                msg = string.gsub(msg, "&", "§")
                                server:broadcast(msg, plugin.config.get("config.perm.toggle"))
                                server:dispatchCommand(server:getConsoleSender(), "essentials:vanish "..sender:getName().." on")
                                local msg = plugin.config.get("config.lang.fakequit")
                                msg = string.gsub(msg, "{name}", sender:getName())
                                msg = string.gsub(msg, "&", "§")
                                broadcast(msg)
                            elseif args[1] == "-s" and plugin.config.get("config.enable.silent") == true then
                                local msg = plugin.config.get("config.lang.onsilent")
                                msg = string.gsub(msg, "{name}", sender:getName())
                                msg = string.gsub(msg, "&", "§")
                                server:broadcast(msg, plugin.config.get("config.perm.toggle"))
                            else
                                local msg = plugin.config.get("config.lang.onduty")
                                msg = string.gsub(msg, "{name}", sender:getName())
                                msg = string.gsub(msg, "&", "§")
                                broadcast(msg)
                            end
                        end
                    else
                        sender:sendMessage("§cYou need the permission '"..plugin.config.get("config.perm.toggle").."' to run that.")
                    end
                else
                    sender:sendMessage("§cDuty plugin is currently disabled.")
                end
            end
        )
        
        events.add("playerJoin",
            function(event)
                if plugin.config.get("config.enable.joindisable") == true then
                    local player = event:getPlayer()
                    if player:hasPermission(plugin.config.get("config.perm.enabled")) == true then
                        if plugin.config.get("s."..player:getUniqueId():toString()..".m") == "v" then
                            plugin.config.set("s."..player:getUniqueId():toString()..".m", "s")
                            plugin.config.save()
                        end
                        server:dispatchCommand(player, "duty")
                        player:sendMessage("§cDuty mode was disabled as you logged out.")
                    end
                end
            end
        )
        
        events.add("asyncPlayerChat",
            function(event)
                if plugin.config.get("config.enable.vanishchatblock") == true then
                    local player = event:getPlayer()
                    if player:hasPermission(plugin.config.get("config.perm.enabled")) == true then
                        if plugin.config.get("s."..player:getUniqueId():toString()..".m") == "v" then
                            if plugin.config.get("config.enable.vanishchatcommand") then
                                server:dispatchCommand(player, plugin.config.get("config.vanishchat.command").." "..event:getMessage())
                            else
                                sender:sendMessage("§7You cannot chat when fake disconnected!")
                            end
                            event:setCancelled(true)
                        end
                    end
                end
            end
        )
        
    end
)
