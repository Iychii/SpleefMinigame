-- SERVICES
local DataStoreService					= game:GetService("DataStoreService")

-- LEADER BOARD
local LeaderstatsDataStore = DataStoreService:GetDataStore("LeaderstatsDataStore")

game.Players.PlayerAdded:Connect(function(player)
	local leaderstats = Instance.new("Folder", player)
	leaderstats.Name = "leaderstats"

	local Points = Instance.new("IntValue", leaderstats)
	Points.Name = "Points"
	Points.Value = 14 -- Starting amount
	
	local Rank = Instance.new("StringValue", leaderstats)
	Rank.Name = "Rank"
	Rank.Value = "NA"

	local dataSave
	local success, error = pcall(function()
		dataSave = LeaderstatsDataStore.GetAsync(player.UserId)
	end)

	if success then
		print("Player has data")
		for i, data in pairs(leaderstats.GetChildren()) do
			data.Value = dataSave[i]
		end
	
	else
		print("Error when retrieving data")
	end
end)

game.Players.PlayerRemoving:Connect(function(player)

    local success, error pcall(function()
        LeaderstatsDataStore:SetAsync()
    end)
end)