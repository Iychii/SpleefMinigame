-- SERVICES
local ServerScriptService 				= game:GetService("ServerScriptService")
local ServerStorage 					= game:GetService("ServerStorage")
-- SCRIPTS
local Dissapear 						= require(ServerScriptService.Components.Disappear)

-- VARIABLES
local GameTeleporterPosition = game.Workspace.GameTeleporter.CFrame.Position



local Game = {}
Game.__index = Game


-- Start New Game
function Game:Start()
	Game:TeleportPlayers(GameTeleporterPosition)
	-- Change all players team to "Playing"

end

-- Create Platforms
function Game:CreateGameArea()
	local GameArea = ServerStorage.Models:FindFirstChild("GameArea")
	local Children = GameArea:GetChildren()

	local clonedGameArea = nil

	-- Create folder to put in cloned platform
	local GameAreaFolder = Instance.new("Folder")
	GameAreaFolder.Parent = game.Workspace
	GameAreaFolder.Name = "ClonedGameArea"

	for i = 1, #Children do	
		clonedGameArea = Children[i]:Clone()
		clonedGameArea.Parent = GameAreaFolder
	end

	local Objects = GameAreaFolder:GetChildren()

	for _,v in next, Objects do
		if v:IsA("BasePart") and v.Name == "Part" then
			v.Touched:Connect(function(hit)
				local part = v
				Dissapear.DissapearPart(hit,part)

			end)
		end
	end
end

-- Destroy Platforms
function Game:DestroyGameArea()
	game.Workspace:WaitForChild("ClonedGameArea"):Destroy()
end


--Start Game Timer
function Game:PrepareRound()
	wait(2)
	local TemporaryBlock = game.Workspace:FindFirstChild("ClonedGameArea").TemporaryBlock
	TemporaryBlock:Destroy()

end

-- 

-- Teleport Players to Desired positon
function Game:TeleportPlayers(position)

	for _,v in ipairs(game.Players:GetPlayers()) do
		if v.Character then
			v.Character:MoveTo(position)
		end
	end

end

-- Game ends after countdown
function Game:Finish()
	-- Destroy Temp Game Area
	Game:DestroyGameArea()

end

return Game