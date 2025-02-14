--Frame to listen for the events
local frame = CreateFrame("Frame")

--Register the events
frame:RegisterEvent("PLAYER_LOGIN")

--Getting the time played by the player
local totalPlayTime, _, _=GetTimePlayed()

--Converting the time played into hours, minutes and seconds
local hours = math.floor(totalPlayTime/3600)
local minutes = math.floor((totalPlayTime%3600)/60)
local seconds = totalPlayTime%60

--Format the time played
local formattedTime = string.format("%d hours, %d minutes, %d seconds", hours, minutes, seconds)

--Display the time played to the user
local frame = CreateFrame("Frame", "PlayedTimeFrame", UIParent)
frame:SetSize(200, 50)
frame:SetPoint("CENTER", UIParent, Center)
frame:SetBackdrop({
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
frame.text = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
frame.text:SetPoint("CENTER", frame, "CENTER")
frame.text:SetText("Total time played: "..formattedTime)

frame:RegisterEvent("PLAYER_LOGIN")
frame:SetScript("OnEvent", function(self, event, argi)
    if event == "PLAYER_LOGIN" then
        local totalPlayTime, _, _=GetTimePlayed()
        local hours = math.floor(totalPlayTime/3600)
        local minutes = math.floor((totalPlayTime%3600)/60)
        local seconds = totalPlayTime%60
        local formattedTime = string.format("%d hours, %d minutes, %d seconds", hours, minutes, seconds)
        text:SetText(formattedTime)
    end
end)