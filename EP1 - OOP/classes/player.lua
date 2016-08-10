local player = {__type = "player"};

function player.new(name, health, attack, defend, magic, gold)
	local self = setmetatable({}, {__index = player});
	self.name = name or "Nameless";
	self.health = health or 100;
	self.stats = {
		["attack"] = attack or 0;
		["defend"] = defend or 0;
		["magic"] = magic or 0;
	};
	self.gold = gold or 0;
	self.inventory = {};
	return self;
end;

function player:takeDamage(value)
	local newhealth = self.health - (value - self.stats.defend);
	self.health = newhealth < 0 and 0 or newhealth;
	print(self.name .. " health: " .. self.health);
end;

function player:attack(style, opponent)
	if (self.health > 0) then
		if (type(opponent) == "table" and opponent.__type and opponent.__type == "goblin") then
			if (opponent.health > 0) then
				local validStyle = style ~= "health" and self.stats[style];
				if (validStyle) then
					opponent:takeDamage(validStyle);
					if opponent.health <= 0 then
						self.gold = self.gold + opponent.gold;
						opponent.gold = 0;
					end;
				else
					error(style .. " is not a valid way of attacking for " .. self.__type);
				end;
			else
				print("This goblin is already dead!");
			end;
		else
			error("Attempt to fight non goblin opponent");
		end;
	else
		print("This player is dead!");
	end;
end;

function player:getStats()
	local t = {"name : " .. self.name, "health :" .. self.health};
	for key, value in next, self.stats do 
		table.insert(t, key .. " : " .. value);
	end;
	return table.concat(t, "\n");
end;

return player;