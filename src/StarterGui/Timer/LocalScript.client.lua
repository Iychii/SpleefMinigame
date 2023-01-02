local Status = game.ReplicatedStorage.Events.Status
local DisplayStatus = game.ReplicatedStorage.Events.DisplayStatus
local TimeDisplay = script.Parent.Frame.Frame.TimeDisplay
local HeaderText = script.Parent.Frame.Frame.HeaderText



Status.Changed:Connect(function()
	TimeDisplay.Text = Status.Value
	HeaderText.Text = DisplayStatus.Value
end)
