ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
TriggerEvent('esx_phone:registerNumber', 'fbi', ('fbi'), true, true)
TriggerEvent('esx_society:registerSociety', 'fbi', 'fbi', 'society_fbi', 'society_fbi', 'society_fbi', {type = 'private'})

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
end)




















----------------Annonces


RegisterServerEvent('evJob:AnnonceFbi1')
AddEventHandler('evJob:AnnonceFbi1', function()
	local _src = source
    local xPlayer = ESX.GetPlayerFromId(_src)
    local xPlayers = ESX.GetPlayers()
    for i=1, #xPlayers, 1 do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Fbi', '~y~Annonce', 'Le Fbi ~g~recrute', 'CHAR_BLANK_ENTRY', 1)
    end
end)

RegisterServerEvent('evJob:AnnonceFbi')
AddEventHandler('evJob:AnnonceFbi', function()
    local _src = source
    local xPlayer = ESX.GetPlayerFromId(_src)
    local xPlayers = ESX.GetPlayers()
    for i=1, #xPlayers, 1 do 
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Fbi', '~y~Annonce', 'Une ~r~prime ~w~à été mise en place Merci de consulez notre ~r~RadioD', 'CHAR_BLANK_ENTRY', 1)
    end
end)


RegisterServerEvent('evJob:AnnonceRdv')
AddEventHandler('evJob:AnnonceRdv', function()
    local _src = source
    local xPlayer = ESX.GetPlayerFromId(_src)
    local xPlayers = ESX.GetPlayers()
    for i=1, #xPlayers, 1 do 
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Rdv', '~y~Annonce', '~y~Un agent du Fbi est demander à l acceuil Merci !', 'CHAR_CHAT_CALL', 1)
    end
end)



----------Stock_Item



RegisterNetEvent('evJob:GiveItem')
AddEventHandler('evJob:GiveItem', function(Nom, Item)
    local _src = source
    local xPlayer = ESX.GetPlayerFromId(_src)
    xPlayer.addInventoryItem(Item, 1)
end)



-- Coffre
RegisterServerEvent('evJob:prendreitems')
AddEventHandler('evJob:prendreitems', function(itemName, count)
	local _src = source
	local xPlayer = ESX.GetPlayerFromId(_src)
	local sourceItem = xPlayer.getInventoryItem(itemName)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_mechanic', function(inventory)
		local inventoryItem = inventory.getItem(itemName)

		if count > 0 and inventoryItem.count >= count then

			if sourceItem.limit ~= -1 and (sourceItem.count + count) > sourceItem.limit then
				TriggerClientEvent('esx:showNotification', _src, "quantité invalide")
			else
				inventory.removeItem(itemName, count)
				xPlayer.addInventoryItem(itemName, count)
				TriggerClientEvent('esx:showNotification', _src, 'Objet retiré', count, inventoryItem.label)
			end
		else
			TriggerClientEvent('esx:showNotification', _src, "quantité invalide")
		end
	end)
end)


RegisterNetEvent('evJob:stockitem')
AddEventHandler('evJob:stockitem', function(itemName, count)
	local _src = source
	local xPlayer = ESX.GetPlayerFromId(source)
	local sourceItem = xPlayer.getInventoryItem(itemName)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_mechanic', function(inventory)
		local inventoryItem = inventory.getItem(itemName)

		-- does the player have enough of the item?
		if sourceItem.count >= count and count > 0 then
			xPlayer.removeInventoryItem(itemName, count)
			inventory.addItem(itemName, count)
			TriggerClientEvent('esx:showNotification', _src, "Objet déposé "..count..""..inventoryItem.label.."")
		else
			TriggerClientEvent('esx:showNotification', _src, "quantité invalide")
		end
	end)
end)


ESX.RegisterServerCallback('evJob:inventairejoueur', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local items   = xPlayer.inventory

	cb({items = items})
end)

ESX.RegisterServerCallback('evJob:prendreitem', function(source, cb)
	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_mechanic', function(inventory)
		cb(inventory.items)
	end)
end)


------Menotter


RegisterServerEvent('evFbi:handcuff')
AddEventHandler('evFbi:handcuff', function(target)
  TriggerClientEvent('evFbi:handcuff', target)
end)


------Escorter
RegisterServerEvent('evFbi:drag')
AddEventHandler('evFbi:drag', function(target)
  local _source = source
  TriggerClientEvent('evFbi:drag', target, _source)
end)


-- Badge Fbi

RegisterServerEvent('fbibadge:open')
AddEventHandler('fbibadge:open', function(ID, targetID, type)
	local identifier = ESX.GetPlayerFromId(ID).identifier
	local _source 	 = ESX.GetPlayerFromId(targetID).source

	MySQL.Async.fetchAll('SELECT firstname, lastname, dateofbirth, sex, height FROM users WHERE identifier = @identifier', {['@identifier'] = identifier},
	function (user)
		if (user[1] ~= nil) then
			MySQL.Async.fetchAll('SELECT type FROM user_licenses WHERE owner = @identifier', {['@identifier'] = identifier},
			function (licenses)
				local array = {
					user = user,
					licenses = licenses
				}
				TriggerClientEvent('fbibadge:open', _source, array, type)
			end)
		end
	end)
end)

ESX.RegisterServerCallback('esx_phone:getItemAmount', function(source, cb, item)
    local xPlayer = ESX.GetPlayerFromId(source)
    local qtty = xPlayer.getInventoryItem(item).count
    cb(qtty)
end)

RegisterServerEvent('fbibadge:ItemsBadge')
AddEventHandler('fbibadge:ItemsBadge', function()
	local XPlayer = ESX.GetPlayerFromId(source)

	local qtty = XPlayer.getInventoryItem(Config.BadgeItem).count
	if qtty > 1 then
		XPlayer.removeInventoryItem(Config.BadgeItem, 1)

	elseif qtty < 1 then
		XPlayer.addInventoryItem(Config.BadgeItem, 1)
	end
end)