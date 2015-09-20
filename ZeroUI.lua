
ZeroUI = {}
ZeroUI.name = "ZeroUI"
ZeroUI.version = 1.0
ZeroUI.defaults = {
	showAttributes = true,
	showCombat = true,
}

function ZeroUI:Initialize()

--if is in combat function
self.inCombat = IsUnitInCombat("player")

if ZeroUI.ZUIConfig.showCombat == true then
EVENT_MANAGER:RegisterForEvent(self.name, EVENT_PLAYER_COMBAT_STATE, self.OnPlayerCombatState)
end

--Always show attribute bars
if ZeroUI.ZUIConfig.showAttributes == true then
PLAYER_ATTRIBUTE_BARS:ForceShow(yes)
end

--buff event
--EVENT_MANAGER:RegisterForEvent(1, EVENT_EFFECT_CHANGED, self.BuffEffectChanged)

end

function ZeroUI.OnAddOnLoaded(event, addonName)
	if addonName == ZeroUI.name then
		
		--use settings
		ZeroUI.ZUIConfig = ZO_SavedVars:New("ZeroUIConfig", ZeroUI.version, nil, ZeroUI.defaults)
		
		local LAM2 = LibStub("LibAddonMenu-2.0")
		--Menu settings starts here
		local panelData = {
			type = "panel",
			name = "ZeroUI",
			displayName = "ZeroUI",
			author = "jlahtela",
			version = ZeroUI.version,
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
				type = "checkbox",
				name = "Show attributes",
				getFunc = function() return ZeroUI.ZUIConfig.showAttributes end,
				setFunc = function(newValue) ZeroUI.ZUIConfig.showAttributes = newValue; end,
				default = ZeroUI.defaults.showAttributes,
				warning = "To apply settings reloadui is required!",
			},
			[3] = {
				type = "header",
				name = "Combat events",
			},
			[4] = {
				type = "checkbox",
				name = "Show combat status messages",
				getFunc = function() return ZeroUI.ZUIConfig.showCombat end,
				setFunc = function(newValue) ZeroUI.ZUIConfig.showCombat = newValue; end,
				default = ZeroUI.defaults.showCombat,
				warning = "To apply settings reloadui is required!",
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

