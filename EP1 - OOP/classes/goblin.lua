local goblin = {__type = "goblin"};

function goblin.new(name, health, attack, defend, gold)
	local self = setmetatable({}, {__index = goblin});
	self.name = name or "Nameless";
	self.health = health or 100;
	self.stats = {
		["attack"] = attack or 0;
		["defend"] = defend or 0;
	};
	self.gold = gold or 0;
	return self;
end;

function goblin:takeDamage(value)
	local newhealth = self.health - (value - self.stats.defend);
	self.health = newhealth < 0 and 0 or newhealth;
	print(self.name .. " health: " .. self.health);
end;

function goblin:attack(style, opponent)
	if (self.health > 0) then
		if (type(opponent) == "table" and opponent.__type and opponent.__type == "player") then
			if (opponent.health > 0) then
				local validStyle = style ~= "health" and self.stats[style];
				if (validStyle) then
					opponent:takeDamage(validStyle);
				else
					error(style .. " is not a valid way of attacking for " .. self.__type);
				end;
			else
				print("This player is already dead!");
			end;
		else
			error("Attempt to fight non player opponent");
		end;
	else
		print("This goblin is dead!");
	end;
end;

function goblin:getStats()
	local t = {"name : " .. self.name, "health :" .. self.health};
	for key, value in next, self.stats do 
		table.insert(t, key .. " : " .. value);
	end;
	return table.concat(t, "\n");
end;

return goblin;