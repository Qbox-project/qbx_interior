local Apartments = require 'config.server'.Apartments
local Interiors = require 'config.server'.Interiors

local function TeleportToInterior(Ped, Coords)
	SetEntityCoords(Ped, Coords.exit.x, Coords.exit.y, Coords.exit.z)
	SetEntityHeading(Ped, Coords.exit.w)
end

exports('CreateDefaultApartment', function(Source, ApartmentName, Routingbucket, Coords)
	if not Apartments[ApartmentName] then error(string.format('%s, passed %s. But that apartment name doesn\'t exist.', GetInvokingResource(), ApartmentName)) return end

	if type(ApartmentName) == 'number' then
		local InteractCoords = {
			exit = vector4(Coords.x + Apartments[ApartmentName].exit.x, Coords.y + Apartments[ApartmentName].exit.y, Coords.z + 1.0, Apartments[ApartmentName].exit.w),
			clothes = vector3(Coords.x + Apartments[ApartmentName].clothes.x, Coords.y + Apartments[ApartmentName].clothes.y, Coords.z + 1.0),
			stash = vector3(Coords.x + Apartments[ApartmentName].stash.x, Coords.y + Apartments[ApartmentName].stash.y, Coords.z + 1.0),
			logout = vector3(Coords.x + Apartments[ApartmentName].logout.x, Coords.y + Apartments[ApartmentName].logout.y, Coords.z + 1.0)
		}
		local Shell = CreateObject(ApartmentName, Coords.x, Coords.y, Coords.z, true, false, false)
		while not DoesEntityExist(Shell) do Wait(0) end
		FreezeEntityPosition(Shell, true)
		TriggerClientEvent('qb-interior:client:screenfade', Source)
		Wait(300)
		TeleportToInterior(GetPlayerPed(Source), InteractCoords)
		exports.qbx_core:SetEntityBucket(Shell, Routingbucket)
		exports.qbx_core:SetPlayerBucket(Source, Routingbucket)
		return InteractCoords, Shell
	elseif type(ApartmentName) == 'string' then
		local InteractCoords = {
			exit = vector4(Apartments[ApartmentName].exit.x, Apartments[ApartmentName].exit.y, Apartments[ApartmentName].exit.w),
			clothes = vector3(Apartments[ApartmentName].clothes.x, Apartments[ApartmentName].clothes.y,  Apartments[ApartmentName].clothes.z),
			stash = vector3(Apartments[ApartmentName].stash.x, Apartments[ApartmentName].stash.y, Apartments[ApartmentName].stash.z),
			logout = vector3(Apartments[ApartmentName].logout.x, Apartments[ApartmentName].logout.y, Apartments[ApartmentName].logout.z)
		}
		TriggerClientEvent('qb-interior:client:screenfade', Source)
		Wait(300)
		TeleportToInterior(GetPlayerPed(Source), InteractCoords)
		exports.qbx_core:SetPlayerBucket(Source, Routingbucket)
		return InteractCoords
	end
end)

exports('CreateDefaultInterior', function(Source, InteriorName, Routingbucket, Coords)
	if not Interiors[InteriorName] then error(string.format('%s, passed %s. But that apartment name doesn\'t exist.', GetInvokingResource(), InteriorName)) return end

	if type(InteriorName) == 'number' then
		local InteractCoords = {
			exit = vector4(Coords.x + Interiors[InteriorName].exit.x, Coords.y + Interiors[InteriorName].exit.y, Coords.z + 1.0, Interiors[InteriorName].exit.w)
		}
		local Shell = CreateObject(InteriorName, Coords.x, Coords.y, Coords.z, true, false, false)
		while not DoesEntityExist(Shell) do Wait(0) end
		FreezeEntityPosition(Shell, true)
		TriggerClientEvent('qb-interior:client:screenfade', Source)
		Wait(300)
		TeleportToInterior(GetPlayerPed(Source), InteractCoords)
		exports.qbx_core:SetEntityBucket(Shell, Routingbucket)
		exports.qbx_core:SetPlayerBucket(Source, Routingbucket)
		return InteractCoords, Shell
	elseif type(InteriorName) == 'string' then
		local InteractCoords = {
			exit = vector4(Interiors[InteriorName].exit.x, Interiors[InteriorName].exit.y, Interiors[InteriorName].exit.w)
		}
		TriggerClientEvent('qb-interior:client:screenfade', Source)
		Wait(300)
		TeleportToInterior(GetPlayerPed(Source), InteractCoords)
		exports.qbx_core:SetPlayerBucket(Source, Routingbucket)
		return InteractCoords
	end
end)
