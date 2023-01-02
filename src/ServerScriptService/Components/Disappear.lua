-- Script for Platform Dissapearing
local Dissapear = {}

function Dissapear.DissapearPart(hit,part)
	local humanoid = hit.Parent:FindFirstChild("Humanoid")
	if humanoid then
		for i=0, 1, 0.5 do
			wait(0.5)
			part.Transparency = i
		end
		part.CanCollide = false
		part:Destroy()
	end
	
end

return Dissapear




