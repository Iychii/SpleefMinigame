local ServerStorage = game:GetService("ServerStorage")

local LoseBlock = script.Parent


LoseBlock.Touched:Connect(function(hit)
	if hit.Parent:FindFirstChild("Humanoid") then
		hit.Parent.Humanoid.Health = 0

	end
end)
