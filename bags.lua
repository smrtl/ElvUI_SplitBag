local E, L, V, P, G = unpack(ElvUI); --Import: Engine, Locales, PrivateDB, ProfileDB, GlobalDB
local B = E:GetModule("Bags")
local SB = E:GetModule("SplitBag")

function SB.Layout(self, isBank)
    if not E.private["bags"].enable or isBank then return end
    local f = B:GetContainerFrame(isBank);

    if not f then return; end
    local buttonSize = isBank and B.db.bankSize or B.db.bagSize;
	local buttonSpacing = E.Border*2;
	local containerWidth = ((isBank and B.db.bankWidth) or B.db.bagWidth)
	local numContainerColumns = floor(containerWidth / (buttonSize + buttonSpacing));
    local numContainerRows = 0;
    local numBags = 0;
    local numBagSlots = 0;
    local bagSpacing = E.db.SplitBag.bagSpacing;
    local splitBag1 = E.db.SplitBag.splitBag1;
    local splitBag2 = E.db.SplitBag.splitBag2;
    local splitBag3 = E.db.SplitBag.splitBag3;
    local splitBag4 = E.db.SplitBag.splitBag4;

    local lastButton;
    local lastRowButton;
    for i, bagID in ipairs(f.BagIDs) do
        local newBag = bagID == 1 and splitBag1 or bagID == 2 and splitBag2 or bagID == 3 and splitBag3 or bagID == 4 and splitBag4 or false;
        
        --Bag Slots
		local numSlots = GetContainerNumSlots(bagID);
        if numSlots > 0 and f.Bags[bagID] then
            for slotID = 1, numSlots do
                f.totalSlots = f.totalSlots + 1;
                f.Bags[bagID][slotID]:ClearAllPoints();

                if lastButton then
                    if newBag and slotID == 1 then
                        f.Bags[bagID][slotID]:Point('TOP', lastRowButton, 'BOTTOM', 0, -(buttonSpacing + bagSpacing));
                        lastRowButton = f.Bags[bagID][slotID];
                        numContainerRows = numContainerRows + 1;
                        numBags = numBags + 1;
                        numBagSlots = 0;
                    elseif numBagSlots % numContainerColumns == 0 then
                        f.Bags[bagID][slotID]:Point('TOP', lastRowButton, 'BOTTOM', 0, -buttonSpacing);
                        lastRowButton = f.Bags[bagID][slotID];
                        numContainerRows = numContainerRows + 1;
                    else
                        f.Bags[bagID][slotID]:Point('LEFT', lastButton, 'RIGHT', buttonSpacing, 0);
                    end
                else
                    f.Bags[bagID][slotID]:Point('TOPLEFT', f.holderFrame, 'TOPLEFT');
                    lastRowButton = f.Bags[bagID][slotID];
                    numContainerRows = numContainerRows + 1;
                end

                lastButton = f.Bags[bagID][slotID];
                numBagSlots = numBagSlots + 1;
            end
        end
    end

    f:Size(containerWidth, ((buttonSize + buttonSpacing) * numContainerRows) + numBags * bagSpacing + f.topOffset + f.bottomOffset + 2);
end
hooksecurefunc(B, "Layout", SB.Layout)