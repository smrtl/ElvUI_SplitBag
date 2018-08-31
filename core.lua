local E, L, V, P, G = unpack(ElvUI); --Import: Engine, Locales, PrivateDB, ProfileDB, GlobalDB
local SB = E:NewModule("SplitBag", "AceHook-3.0", "AceEvent-3.0", "AceTimer-3.0");
local EP = LibStub("LibElvUIPlugin-1.0")
local addon, ns = ...

SB.Version = GetAddOnMetadata(addon, "Version")
SB.Title = "|cff1784d1Split Bag|r"
SB.Configs = {}

P["SplitBag"] = {}
V["SplitBag"] = {}

if not E.private["bags"].enable then return end

function SB:ConfigTable()
    E.Options.args.bags.args.splitBags = {
        order = 100,
        type = "group",
        name = SB.Title,
        get = function(info) return E.db.SplitBag[info[#info]] end,
        set = function(info, value) E.db.SplitBag[info[#info]] = value; SB:Layout(false) end,
		args = {
            header1 = {
				order = 1,
				type = "header",
				name = SB.Title,
            },
            splitBag1 = {
                order = 2,
                type = "toggle",
                name = L["Split first bag"],
            },
            splitBag2 = {
                order = 3,
                type = "toggle",
                name = L["Split second bag"],
            },
            splitBag3 = {
                order = 4,
                type = "toggle",
                name = L["Split third bag"],
            },
            splitBag4 = {
                order = 5,
                type = "toggle",
                name = L["Split fourth bag"],
            },
            bagSpacing = {
                order = 6,
                type = "range",
                name = L["Bag spacing"],
                min = 0, max = 20, step = 1,
            },
        },
    }
end

function SB:Initialize()
	EP:RegisterPlugin(addon, SB.ConfigTable)
end

E:RegisterModule(SB:GetName())