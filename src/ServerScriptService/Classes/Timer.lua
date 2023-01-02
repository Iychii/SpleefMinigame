-- SERVICES
local ReplicatedStorage					= game:GetService("ReplicatedStorage")

-- VARIABLES
local roundLength = 10 -- Round is 60 seconds
local intermissionLength = 5 -- Intermission is 15 seconds

-- Values / VALUES
local InRound							= ReplicatedStorage.Values.InRound
local InIntermission					= ReplicatedStorage.Values.InIntermission
local Status 							= ReplicatedStorage.Values.Status
local DisplayStatus 					= ReplicatedStorage.Values.DisplayStatus


local Timer = {}
Timer.__index = Timer

function Timer:roundTimer()
		if InIntermission.Value == true then
			for i = intermissionLength, 0, -1 do
				wait(1)
				DisplayStatus.Value = "Starting in..."
				Status.Value = i
			
				-- Play Countdown Sound
				if Status.Value == 3 then
					local countdownSound = game.Workspace.Countdown
					countdownSound:Play()
				end
			
			end
		end
		if InRound.Value == true then
			for i = roundLength, 0, -1 do
				wait(1)
				DisplayStatus.Value = "Time left: "
				Status.Value = i
			end
		end
	end

return Timer
