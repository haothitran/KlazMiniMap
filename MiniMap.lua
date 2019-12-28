--------------------------------------------------------------------------------
-- // MODULES / MINIMAP
--------------------------------------------------------------------------------

MinimapBorderTop:Hide()       -- zone text border
MiniMapWorldMapButton:Hide()  -- world map
GameTimeFrame:Hide()          -- calendar
MiniMapTracking:Hide()        -- tracking
MinimapZoomIn:Hide()          -- zoom in
MinimapZoomOut:Hide()         -- zoom out

-- hide clock
local f = CreateFrame("Frame", nil, UIParent)
f:RegisterEvent("ADDON_LOADED")
f:SetScript("OnEvent", function(self, event, name)
  if name == "Blizzard_TimeManager" then
    TimeManagerClockButton:Hide()
    TimeManagerClockButton:SetScript("OnShow", function(self)
      TimeManagerClockButton:Hide()
    end)
  end
end)

-- dark border
local s = CreateFrame("Frame")
s:RegisterEvent("PLAYER_LOGIN")
s:SetScript("OnEvent",function(self, event)
  for i, v in pairs({
    MinimapBorder,
    MiniMapMailBorder,
    QueueStatusMinimapButtonBorder,
  }) do
    v:SetVertexColor(.15, .15, .15)
  end
end)

-- mouse wheel zoom
Minimap:EnableMouseWheel(true)
Minimap:SetScript("OnMouseWheel", function(self, z)
  local c = Minimap:GetZoom()
  if (z > 0 and c < 5) then
    Minimap:SetZoom(c + 1)
  elseif (z < 0 and c > 0) then
    Minimap:SetZoom(c - 1)
  end
end)

-- mouse clicks
Minimap:SetScript("OnMouseUp", function(self, btn)
  if btn == "RightButton" then
    _G.ToggleDropDownMenu(1, nil, _G.MiniMapTrackingDropDown, self)
  elseif btn == "MiddleButton" then
    _G.GameTimeFrame:Click()
  else
    _G.Minimap_OnClick(self)
  end
end)
