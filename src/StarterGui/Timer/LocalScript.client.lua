local Status = game.ReplicatedStorage.Values.Status
local DisplayStatus = game.ReplicatedStorage.Values.DisplayStatus
local TimeDisplay = script.Parent.Frame.Frame.TimeDisplay
local HeaderText = script.Parent.Frame.Frame.HeaderText



Status.Changed:Connect(function()
	TimeDisplay.Text = Status.Value
	HeaderText.Text = DisplayStatus.Value
end)
