local addonName = ...
local frame = CreateFrame("Frame")

-- Function to reposition the raid frames
local function CenterRaidFrames()
    local container = CompactRaidFrameContainer
    if not container then return end

    -- Get current vertical offset from the top of UIParent
    local _, _, _, _, yOffset = container:GetPoint()
    -- If no anchor is set, default to -100
    if not yOffset then yOffset = -100 end

    -- Clear existing anchors
    container:ClearAllPoints()

    -- Get screen width and container width
    local screenWidth = UIParent:GetWidth()
    local containerWidth = container:GetWidth()

    -- Calculate centered X position
    local xOffset = (screenWidth - containerWidth) / 2

    -- Anchor to top center
    container:SetPoint("TOPLEFT", UIParent, "TOPLEFT", xOffset, yOffset)
end

-- Register events
frame:RegisterEvent("PLAYER_ENTERING_WORLD")
frame:RegisterEvent("PLAYER_REGEN_ENABLED")
frame:RegisterEvent("GROUP_ROSTER_UPDATE")
frame:SetScript("OnEvent", function(self, event)
    if event == "PLAYER_REGEN_ENABLED" then
        CenterRaidFrames()
    elseif event == "GROUP_ROSTER_UPDATE" or event == "PLAYER_ENTERING_WORLD" then
        if not InCombatLockdown() then
            CenterRaidFrames()
        end
    end
end)
