local shop = {__type = "shop"};

function shop.new(name, gold, inventory)
	local self = setmetatable({}, {__index = shop});
	self.name = name or "Nameless";
	self.inventory = inventory;
	self.gold = gold;
	return self;
end;

function shop:buy(item, player)
	if (type(player) == "table" and player.__type and player.__type == "player") then
		if (self.inventory[item] and self.inventory[item].quantity > 0) then
			if (player.gold >= self.inventory[item].price) then
				-- transaction successful
				self.gold = self.gold + self.inventory[item].price;
				self.inventory[item].quantity = self.inventory[item].quantity - 1;
				player.gold = player.gold - self.inventory[item].price;
				player.inventory[item] = (player.inventory[item] or 0) + 1;
			else
				print(player.name .. " didn't have enough money to buy " .. item);
			end;
		else
			print("The shop doesn't seem to carry that item!");
		end;
	else
		error("Only players can shop here!");
	end;
end;

return shop;