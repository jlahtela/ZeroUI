
ZeroUI = {}

ZeroUI.name = "ZeroUI"

function ZeroUI:Initialize()
self.inCombat = IsUnitInCombat("player")
EVENT_MANAGER:RegisterForEvent(self.name, EVENT_PLAYER_COMBAT_STATE, self.OnPlayerCombatState)

PLAYER_ATTRIBUTE_BARS:ForceShow(yes)

end

function ZeroUI.OnAddOnLoaded(event, addonName)
	if addonName == ZeroUI.name then
	ZeroUI:Initialize()
	end
end

EVENT_MANAGER:RegisterForEvent(ZeroUI.name, EVENT_ADD_ON_LOADED, ZeroUI.OnAddOnLoaded)

function ZeroUI.OnPlayerCombatState(event, inCombat)
  -- The ~= operator is "not equal to" in Lua.
  if inCombat ~= ZeroUI.inCombat then
    -- The player's state has changed. Update the stored state...
    ZeroUI.inCombat = inCombat
 
    -- ...and then announce the change.
    if inCombat then
      d("Entering combat.")
	 ZO_PlayerAttributeBar:ResetFadeOutDelay() 

    else
      d("Exiting combat.")
    end
 
  end
end

