-- Get Off V1.0
-- By: Parvulster

-- Get Off Command
getoff = "/getoff"

vehicleusers = {}

function EntitySpawn(args)
	if args.entity.__type == "Vehicle" then
		local vehicle = args.entity
		vehicleusers[vehicle:GetId()] = {}
	end
end

function PlayerChat(args)
	if args.text == getoff then
		local vehicle = args.vehicle
		if vehicle ~= nil then
			local driver = vehicleusers[vehicle:GetId()].driver
			if driver == args.player:GetId() then
				local stunter = vehicleusers[vehicle:GetId()].stunter
				if stunter ~= nil then
					local position = stunter:GetPosition()
					stunter:SetPosition(position)
				end
			end
		end
	end
end

function PlayerEnterStunt(args)
	local vehicle = args.vehicle
	vehicleusers[vehicle:GetId()].stunter = args.player:GetId()
end

function PlayerExitStunt(args)
	local vehicle = args.vehicle
	vehicleusers[vehicle:GetId()].stunter = nil
end

function PlayerEnterVehicle(args)
	if args.is_driver then
		local vehicle = args.vehicle
		vehicleusers[vehicle:GetId()].driver = args.player:GetId()
	end
end

function PlayerExitVehicle(args)
	local vehicle = args.vehicle
	if vehicleusers[vehicle:GetId()].driver == args.player:GetId() then
		vehicleusers[vehicle:GetId()].driver = nil
	end
end

Events:Subscribe("EntitySpawn", EntitySpawn)
Events:Subscribe("PlayerChat", PlayerChat)
Events:Subscribe("PlayerEnterStunt", PlayerEnterStunt)
Events:Subscribe("PlayerExitStunt", PlayerExitStunt)
Events:Subscribe("PlayerEnterVehicle", PlayerEnterVehicle)
Events:Subscribe("PlayerExitVehicle", PlayerExitVehicle)