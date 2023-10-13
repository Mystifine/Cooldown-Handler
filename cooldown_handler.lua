local players = game.Players;

local cooldown_handler = {}

local cooldown_log = {};

-- for general cooldowns
function cooldown_handler.onCooldown(cooldown_id : string, cooldown_duration : number) : number
	local on_cooldown = false;
	if not cooldown_log[cooldown_id] or os.clock() - cooldown_log[cooldown_id] >= cooldown_duration then
		on_cooldown = false;
	else
		on_cooldown = true;
	end
	return on_cooldown;
end

function cooldown_handler.setCooldown(cooldown_id : string, cooldown_value : number)
	cooldown_log[cooldown_id] = cooldown_value;
end

-- for player specific cooldowns
function cooldown_handler.onPlayerCooldown(player : Player, cooldown_id : string, cooldown_duration : number) : boolean
	if not cooldown_log[player] then
		cooldown_log[player] = {};
	end
	
	local on_cooldown = false;
	
	if not cooldown_log[player][cooldown_id] or os.clock() - cooldown_log[player][cooldown_id] >= cooldown_duration then
		on_cooldown = false;
	else
		on_cooldown = true
	end
	return on_cooldown
end

function cooldown_handler.setPlayerCooldown(player : Player, cooldown_id : string, cooldown_value : number) : nil
	if not cooldown_log[player] then
		cooldown_log[player] = {};
	end
	
	cooldown_log[player][cooldown_id] = cooldown_value
end

players.PlayerRemoving:Connect(function(player : Player)
	cooldown_log[player] = nil;
end)

return cooldown_handler
