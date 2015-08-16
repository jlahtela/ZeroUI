
ZeroUI = {}

ZeroUI.name = "ZeroUI"

function ZeroUI:Initialize()
self.inCombat = IsUnitInCombat("player")
EVENT_MANAGER:RegisterForEvent(self.name, EVENT_PLAYER_COMBAT_STATE, self.OnPlayerCombatState)

--Always show attribute bars
PLAYER_ATTRIBUTE_BARS:ForceShow(yes)

end

function ZeroUI.OnAddOnLoaded(event, addonName)
	if addonName == ZeroUI.name then
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

