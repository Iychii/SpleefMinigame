-- SERVICES
local ServerScriptService 				= game:GetService("ServerScriptService")
local ServerStorage 					= game:GetService("ServerStorage")
local ReplicatedStorage 				= game:GetService("ReplicatedStorage")
local DataStoreService					= game:GetService("DataStoreService")
local Players 							= game:GetService("Players")
local Teams 							= game:GetService("Teams")

--- MODULE SCRIPTS
local Timer 							= require(ServerScriptService.Classes.Timer)
local Game 								= require(ServerScriptService.Classes.Game)

-- EVENTS / VALUES
local InRound 							= ReplicatedStorage.Events.InRound
local InIntermission					= ReplicatedStorage.Events.InIntermission
local Status 							= ReplicatedStorage.Events.Status
local DisplayStatus 					= ReplicatedStorage.Events.DisplayStatus

-- LEADER BOARD
local LeaderstatsDataStore = DataStoreService:GetDataStore("LeaderstatsDataStore")

game.Players.PlayerAdded:Connect(function(player)
	local leaderstats = Instance.new("Folder", player)
	leaderstats.Name = "leaderstats"

	local Points = Instance.new("IntValue", leaderstats)
	Points.Name = "Points"
	Points.Value = 0 -- Starting amount
	
	local Rank = Instance.new("StringValue", leaderstats)
	Rank.Name = "Rank"
	Rank.Value = "X" -- Roman Numeral for '10'
end)

-- !TO DO!
-- Create Saving Data and loading data


-- CREATING TEAMS
local LobbyTeam = Instance.new("Team")
LobbyTeam.Parent = Teams
LobbyTeam.Name = "Lobby"

local PlayingTeam = Instance.new("Team")
PlayingTeam.Parent = Teams
PlayingTeam.Name = "Playing"



--[[!! DELETE LATER!!

Booleans to indicate status of players -- !!CHANGE VALUES!!
local isInRound = nil -- is Player participating in round
local isDead = nil -- has the player died in the round

If player is in round, if they have fallen (died), then set isDead to true and switch their teams back to lobby
Start of round, make player isInRound true and change their team to "PlayingTeam"
]]

----[[ START OF GAME SCRIPT ]]-----

--Have a loop continue while there are more than 5 players in the game
-- If there are 5 players, let the game start
-- If there are less than 5 players, don't let the game start

while not InRound.Value and not InIntermission.Value do -- While Round has not started
	-- Checking if theres enough players in server
	PlayerCount =  #game.Players:GetPlayers()

	if (PlayerCount >= 1) then
		-- Server has enough players to start
		if InIntermission.Value == false and InRound.Value == false then
			InIntermission.Value = true
			Timer:roundTimer()
		end
		-- Start Game
		if InRound.Value == false and Status.Value == 0 and InIntermission.Value == true then -- End of Intermission 
			InRound.Value = true
			InIntermission.Value = false

			-- Put all players in PlayingTeam
			for i, v in pairs(Players:GetChildren()) do
				if v:IsA("Player") then
					v.Team = game.Teams.Playing
					print("Switched teams to Playing")
				end
			end

			Game:Start()
			Game:CreateGameArea()
			Game:PrepareRound()
			Timer:roundTimer() -- Start Timer
			
			
			-- !! NOT DONE!!
			local playersInRound = {} --track players alive
			local firstPlace
			local secondPlace
			local thirdPlace
			local temp = {} -- Temporary store a target name
			for _, Player in pairs(Players:GetChildren()) do
				if Player.Character and Player.Character:FindFirstChild("Humanoid") then
					table.insert(playersInRound, Player) -- Add players to playersInRound Table
					temp[Player.Name] = Player.Character.Humanoid.Died:Connect(function()
						table.remove(playersInRound, table.find(playersInRound,Player))
					end)
				end
			end
			-- !! NOT DONE!!
			

		end
		if InRound.Value == true and Status.Value == 0 and InIntermission.Value == false then -- End of the Round
			InRound.Value = false
			InIntermission.Value = true

			-- Put all players in Playing Team
			for i, v in pairs(Players:GetChildren()) do
				if v:IsA("Player") then
					v:LoadCharacter() -- Respawn Player
					v.Team = game.Teams.Lobby
					print("Switched teams to Lobby")
				end
			end

			Game:Finish()
			InIntermission.Value = false
		end	
	else
		-- Not Enough Players
	end
	wait()
end


