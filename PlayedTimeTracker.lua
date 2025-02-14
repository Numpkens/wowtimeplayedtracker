--Frame to listen for the events
local frame = CreateFrame("Frame")

--Register the events
frame:RegisterEvent("PLAYER_LOGIN")

--Create the display frame
local displayFrame = CreateFrame("Frame", "PlayedTimeFrame", UIParent, "BackdropTemplate")
displayFrame:SetSize(800, 50)
displayFrame:SetPoint("CENTER", UIParent, "CENTER")
displayFrame:SetBackdrop({
    bgFile = "Interface/Tooltips/UI-Tooltip-Background",
    edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
    tile = true,
    tileSize = 16,
    edgeSize = 16,
    insets = {
        left = 4,
        right = 4,
        top = 4,
        bottom = 4
    }
})
displayFrame.text = displayFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
displayFrame.text:SetPoint("CENTER", displayFrame, "CENTER")
displayFrame.text:SetFont("fonts/morpheus.ttf", 28, "OUTLINE")

-- Initially hide the display frame
displayFrame:Hide()

--Event handler function
frame:SetScript("OnEvent", function(self, event, arg1)
    if event == "PLAYER_LOGIN" then
        RequestTimePlayed()
    elseif event == "TIME_PLAYED_MSG" then
        local totalPlayTime = arg1
        local hours = math.floor(totalPlayTime / 3600)
        local minutes = math.floor((totalPlayTime % 3600) / 60)
        local seconds = totalPlayTime % 60
        local formattedTime = string.format("%d hours, %d minutes, %d seconds", hours, minutes, seconds)
        displayFrame.text:SetText("Total time played: " .. formattedTime)
        displayFrame:Show()
        C_Timer.After(20, function()
            displayFrame:Hide()
        end)
    end
end)

--Register the TIME_PLAYED_MSG event to get the playtime
frame:RegisterEvent("TIME_PLAYED_MSG")