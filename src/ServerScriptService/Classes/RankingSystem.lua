local RankingSystem = {}
RankingSystem.__index = RankingSystem

local Tiers = {           -- POINTS NEEDED TO RANK UP        
    [20] = "X",
    [200] = "IX",
    [300] = "VIII",
    [400] = "VII",
    [500] = "VI",
    [600] = "V",
    [700] = "IV",
    [800] = "III",
    [900] = "II",
    [1000] = "I"
}
 
function RankingSystem:ChangePlayerRank(player)
    local playersPoints = player.leaderstats:FindFirstChild("Points").Value
    for i,_ in pairs(Tiers) do
        if playersPoints >= i then
            player.leaderstats:FindFirstChild("Rank").Value = Tiers[i]
        end
    end
    
end

return RankingSystem

