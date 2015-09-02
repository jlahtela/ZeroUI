
ZeroUI = {}

ZeroUI.name = "ZeroUI"

function ZeroUI:Initialize()

--ZeroUI menu to settings
--.EVENT_MANAGER:RegisterForEvent("ZeroUI_OnLoad", EVENT_ADD_ON_LOADED, OnLoad)

--if is in combat function
self.inCombat = IsUnitInCombat("player")
EVENT_MANAGER:RegisterForEvent(self.name, EVENT_PLAYER_COMBAT_STATE, self.OnPlayerCombatState)

--Always show attribute bars
PLAYER_ATTRIBUTE_BARS:ForceShow(yes)

end

function ZeroUI.OnAddOnLoaded(event, addonName)
	if addonName == ZeroUI.name then
	
	local LAM2 = LibStub("LibAddonMenu-2.0")
	--Menu settings starts here
	local panelData = {
	type = "panel",
	name = "ZeroUI",
	displayName = "ZeroUI",
	author = "jlahtela",
	version = "0.0.2",
	slashCommand = "/ZeroUI",	--(optional) will register a keybind to open to this panel
	registerForRefresh = true,	--boolean (optional) (will refresh all options controls when a setting is changed and when the panel is shown)
	registerForDefaults = true,	--boolean (optional) (will set all options controls back to default values)
	} 
	LAM2:RegisterAddonPanel("ZeroUI_OptionsPanel", panelData)
	end
	
	ZeroUI:Initialize()

end

EVENT_MANAGER:RegisterForEvent(ZeroUI.name, EVENT_ADD_ON_LOADED, ZeroUI.OnAddOnLoaded)

function ZeroUI.OnPlayerCombatState(event, inCombat)
--Check if is in combat
  if inCombat ~= ZeroUI.inCombat then
    ZeroUI.inCombat = inCombat
    if inCombat then
		--If in combat make actions here
		--Add message to chat that entering to combat
      d("Entering combat.")
    else
		--when exits combat
      d("Exiting combat.")
    end
 
  end
end




