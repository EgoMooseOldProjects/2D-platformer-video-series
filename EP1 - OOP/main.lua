local playerClass = require("classes/player"); -- player.new(name, health, attack, defend, magic, gold)
local goblinClass = require("classes/goblin"); -- goblin.new(name, health, attack, defend, gold)
local shopClass = require("classes/shop"); -- shop.new(name, gold, inventory)

local ego = playerClass.new("EgoMoose", 100, 8, 1, 15, 0);
local potionShop = shopClass.new("potionShop", 0, {
    ["potion"] = {quantity = 1, price = 5};
});

local goblin1 = goblinClass.new("goblin1", 10, 3, 2, 5);
local goblin2 = goblinClass.new("goblin2", 7, 1, 1, 10);

-- running the logic

potionShop:buy("potion", ego);

print("\n");
print(ego:getStats(), "\n");
print(goblin1:getStats(), "\n");
print(goblin2:getStats(), "\n");

--ego:attack("sniper rifle", goblin2);
--goblin1:attack("sniper rifle", ego);

-- fight

goblin2:attack("attack", ego);
goblin1:attack("attack", ego);

ego:attack("attack", goblin2);

goblin2:attack("attack", ego);
goblin1:attack("attack", ego);

ego:attack("magic", goblin1);

goblin2:attack("attack", ego);
goblin1:attack("attack", ego);

-- check stats
print("\n");
print(ego:getStats(), "\n");
print("gold : " .. ego.gold);

-- try to buy potions
potionShop:buy("potion", ego);
potionShop:buy("potion", ego);

-- show updated stuff
print("\n");
print("gold : " .. ego.gold);
print("owned potions : " .. ego.inventory.potion);