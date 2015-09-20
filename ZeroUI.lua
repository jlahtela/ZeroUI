
ZeroUI = {}
ZeroUI.name = "ZeroUI"


function ZeroUI:Initialize()
--Saved variables
self.ZUIConfig = ZO_SavedVars:New("ZeroUISettings", 1, nil, {})

--if is in combat function
self.inCombat = IsUnitInCombat("player")
EVENT_MANAGER:RegisterForEvent(self.name, EVENT_PLAYER_COMBAT_STATE, self.OnPlayerCombatState)

ZeroUI.ZeroUISettings.ShowAttributes = 1

--Always show attribute bars
PLAYER_ATTRIBUTE_BARS:ForceShow(yes)

--buff event
--EVENT_MANAGER:RegisterForEvent(1, EVENT_EFFECT_CHANGED, self.BuffEffectChanged)

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
			version = "0.0.4",
			slashCommand = "/ZeroUI",	--(optional) will register a keybind to open to this panel
			registerForRefresh = true,	--boolean (optional) (will refresh all options controls when a setting is changed and when the panel is shown)
			registerForDefaults = true,	--boolean (optional) (will set all options controls back to default values)
		} 
		LAM2:RegisterAddonPanel("ZeroUI_OptionsPanel", panelData)
		
		local optionsTable = { 
			[1] = {
				type = "header",
				name = "User Interface",
			},
			[2] = {
				type = "header",
				name = "Combat events",
			},
		}
		LAM2:RegisterOptionControls("ZeroUI_OptionsPanel", optionsTable)
	

	

		ZeroUI:Initialize()
	end
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


--if buff comes on set ability bars force visible
--function ZeroUI.BuffEffectChanged(event)
	--for debugging that event work:
	--d("Buff enabled!")

	--PLAYER_ATTRIBUTE_BARS:
	--PLAYER_ATTRIBUTE_BARS:ForceShow(yes)

--end


