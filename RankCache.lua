local RankCache = {}
local GroupID = 0;
local DataStore = game:GetService("DataStoreService"):GetDataStore("RANK_CACHE_")
function PlayerAdded(Player: Player)
	local Rank = Player:GetRankInGroup(GroupID)
	local Role = Player:GetRoleInGroup(GroupID)
	local PlayerCache = DataStore:GetAsync(Player.UserId.."_CACHE")
	if not PlayerCache then PlayerCache = {Rank,Role} end
	if (PlayerCache[1] ~= Rank or PlayerCache[2] ~= Role) then
		DataStore:SetAsync(Player.UserId.."_CACHE",{
			Rank or 0,
			Role or "Guest"
		})
		PlayerAdded(Player)
	end
end
game.Players.PlayerAdded:Connect(PlayerAdded)
function getRank(playerId)
	return DataStore:GetAsync(playerId.."_CACHE")[1]
end
function getRole(playerId)
	return DataStore:GetAsync(playerId.."_CACHE")[2]
end
RankCache.GetRole=getRole
RankCache.GetRank=getRank
return RankCache