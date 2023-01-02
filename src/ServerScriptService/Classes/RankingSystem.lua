local RankingSystem = {}
RankingSystem.__index = RankingSystem

local Tiers = {           -- POINTS NEEDED TO RANK UP
    ["X"] = 20,
    ["IX"] = 200,
    ["VIII"] = 300,
    ["VII"] = 400,
    ["VI"] = 500,
    ["V"] = 600,
    ["IV"] = 700,
    ["III"] = 800,
    ["II"] = 900,
    ["I"] = 1000
}
 
function RankingSystem:ChangePlayerRank(player)
    local playerRank = player.leaderstats.Rank.Value
    local playersPoints = player.leaderstats.Points.Value
    
    for rank, points in pairs(Tiers) do
        print(playerRank..": "..playersPoints)
        -- Not working below
        if playerRank == Tiers[rank] then
            print("Matching rank! "..Tiers[rank])
            if playersPoints >= Tiers[rank].points then
                print(Tiers[rank].points)
            playerRank = Tiers[rank-1]
            end
        end

    end
    
end

return RankingSystem

