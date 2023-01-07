-- SERVICES
local ServerScriptService 				= game:GetService("ServerScriptService")
local ReplicatedStorage 				= game:GetService("ReplicatedStorage")
local Players 							= game:GetService("Players")

--- MODULE SCRIPTS
local Timer 							= require(ServerScriptService.Classes.Timer)
local Game 								= require(ServerScriptService.Classes.Game)
local RankingSystem						= require(ServerScriptService.Classes.RankingSystem)

-- EVENTS / VALUES
local InRound 							= ReplicatedStorage.Values.InRound
local InIntermission					= ReplicatedStorage.Values.InIntermission
local Status 							= ReplicatedStorage.Values.Status
local DisplayStatus 					= ReplicatedStorage.Values.DisplayStatus

----[[ START OF GAME SCRIPT ]]-----

--Have a loop continue while there are more than 5 players in the game
-- If there are 5 players, let the game start
-- If there are less than 5 players, don't let the game start

while not InRound.Value and not InIntermission.Value do -- While Round has not started
	-- Checking if theres enough players in server
	local PlayerCount =  #game.Players:GetPlayers()
	local PLAYERSNEEDED = 1
	local playersInRound = {} --track players alive

	if PlayerCount >= PLAYERSNEEDED then
		-- Server has enough players to start
		if InIntermission.Value == false and InRound.Value == false then
			InIntermission.Value = true
			Timer:roundTimer()
		end
		-- Start Game
		if InRound.Value == false and Status.Value == 0 and InIntermission.Value == true then -- End of Intermission 
			InRound.Value = true
			InIntermission.Value = false

			Game:Start()
			Game:CreateGameArea()
			Game:PrepareRound()
			Timer:roundTimer() -- Start Timer
			
			-- PROMPT KEEPING TRACK OF PLAYERs IN THE ROUND AND EDIT TABLE TO DETERMINE SURVIVING PLAYERS
			local temp = {} -- Temporary store a target name
			for _, Player in pairs(Players:GetChildren()) do
				if Player.Character and Player.Character:FindFirstChild("Humanoid") then
					table.insert(playersInRound, Player) -- Add players to playersInRound Table
					temp[Player.Name] = Player.Character.Humanoid.Died:Connect(function()
						table.remove(playersInRound, table.find(playersInRound,Player))
					end)
				end
			end
			
			temp["Removing"] = game.Players.PlayerRemoving:Connect(function(player)
				local ind = table.find(playersInRound, player)
				if ind then
					table.remove(playersInRound, ind)
				end
			end)


			-- DETERMINE WINNERS --
			if #playersInRound == 1 then
				local success, error = pcall(function()
				local playerWon = playersInRound[1]
				DisplayStatus.Value =  playerWon.Name.." is the Winner!"
				Status.Value = " "

				playerWon.leaderstats.Points.Value += math.random(10,15) -- Earn between 10-15 points
				RankingSystem:ChangePlayerRank(playerWon)
				wait(3)
				end)
				if not success then
					warn("Error when rewarding winner: ".. error)
				end
			elseif #playersInRound == 0 then
				print("There is no single winner")
				DisplayStatus.Value = "There is no winner this round"
				wait(3)
			end

		end

		if InRound.Value == true and Status.Value == 0 and InIntermission.Value == false then -- End of the Round
			InRound.Value = false
			InIntermission.Value = true

			for _, v in pairs(playersInRound) do
				if v:IsA("Player") then
					v:LoadCharacter() -- Respawn Player
				end
			end

			Game:Finish()
			InIntermission.Value = false
		end	
	else
		warn("Not Enough Players")
		-- Not Enough Players
	end
	wait()
end

