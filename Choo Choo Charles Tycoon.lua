--[[
Auto buy [Randomly]
Auto collect
No gui,cuz im lazy :)

^^ every 10 secs
]]

if game.PlaceId ~= 7887127407 then 
    return error('Waht?')
end

local MyTycoon = nil

for i,v in pairs(game.Workspace.Tycoon:GetChildren()) do
    --Get tycoon player having
	if v.ClassName == 'Folder' and v.Properties.Owner.Value == game.Players.LocalPlayer then 
		print(v)
        MyTycoon = v
	end
end

local firetouchinterest

do
	local GEnv = getgenv();
	local touched
	firetouchinterest = GEnv.firetouchinterest or function(part1, part2, toggle)
		if part1 and part2 then
			if toggle == 0 then
				touched = part1.CFrame
				part1.CFrame = part2.CFrame
			else
				part1.CFrame = touched
				touched = nil
			end
		end
	end
end



if MyTycoon == nil then
    --Get a tycoon when dont have
    for i,v in pairs(game.Workspace.Tycoon:GetChildren()) do
	    if v.ClassName == 'Folder' and v.Properties.Owner.Value == nil then 
	    	local HRP = game.Players.LocalPlayer.Character.HumanoidRootPart
            HRP.CFrame = v.tycoonThings.tycoonDoor.tycoonDoorDecor.CFrame
            MyTycoon = v
            wait(1)
            break
	    end
    end
end

local function StartWith (String,StartWith)
    local match = string.match(String, "^"..StartWith)
    return (match ~= nil)
end



local function CollectMoney()
    local HRP = game.Players.LocalPlayer.Character.HumanoidRootPart
    firetouchinterest(HRP,MyTycoon.tycoonThings.CollectorParts.cashCollector.CollectCash,0)
    wait()
    firetouchinterest(HRP,MyTycoon.tycoonThings.CollectorParts.cashCollector.CollectCash,1)
end


local CurrentCash = tonumber(game.Players.LocalPlayer.leaderstats.Cash.Value)

while wait(10) do
    CollectMoney()
    wait()
    
    for i,v in pairs(MyTycoon.Buttons:GetChildren()) do
        local Head = v.Head
        if Head.Transparency == 1 then
            continue
        end
        local Price = v.buttonSettings.Price
        local IsText = pcall(function()
            Price = tonumber(Price.Text)
        end)
        local _Price = Head.UI.PriceText.Text
        if IsText == false then Price = tonumber(Price.Value) end
        
        if StartWith(_Price,'R[$]') == true then
            print('GamePass')
            --GamePass/Product
            continue
        end
        CurrentCash = tonumber(game.Players.LocalPlayer.leaderstats.Cash.Value)

        if CurrentCash >= Price then
            print('Buying '..v.Name..' ('..Price..'/'..CurrentCash..')')
            local HRP = game.Players.LocalPlayer.Character.HumanoidRootPart
            firetouchinterest(HRP,Head,0)
            wait(.05)
            firetouchinterest(HRP,Head,1)
            wait(.75)
            CurrentCash = tonumber(game.Players.LocalPlayer.leaderstats.Cash.Value)
        else
            print('No money')
        end
    end
end
