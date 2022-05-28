function retrieve=check_data_quality(datamatch)
% retrieve = 1 is data is fine, 0 if it needs to be discarded
retrieve=0;
if isempty(datamatch)
    return
end
if isa(datamatch.players,'struct')
    return
end
pos_player=1;
if ~isfield(datamatch.players{pos_player,1},'player_slot')
    return
end
if ~isfield(datamatch.players{pos_player,1},'hero_id')
    return
end
if ~isfield(datamatch.players{pos_player,1},'item_0')
    return
end
if ~isfield(datamatch.players{pos_player,1},'item_1')
    return
end
if ~isfield(datamatch.players{pos_player,1},'item_2')
    return
end
if ~isfield(datamatch.players{pos_player,1},'item_3')
    return
end
if ~isfield(datamatch.players{pos_player,1},'item_4')
    return
end
if ~isfield(datamatch.players{pos_player,1},'item_5')
    return
end
if ~isfield(datamatch.players{pos_player,1},'backpack_0')
    return
end
if ~isfield(datamatch.players{pos_player,1},'backpack_1')
    return
end
if ~isfield(datamatch.players{pos_player,1},'backpack_2')
    return
end
if ~isfield(datamatch.players{pos_player,1},'obs_placed')
    return
end
if ~isfield(datamatch.players{pos_player,1},'sen_placed')
    return
end
if ~isfield(datamatch.players{pos_player,1},'kills')
    return
end
if ~isfield(datamatch.players{pos_player,1},'deaths')
    return
end
if ~isfield(datamatch.players{pos_player,1},'assists')
    return
end
if ~isfield(datamatch.players{pos_player,1},'leaver_status')
    return
end
if ~isfield(datamatch.players{pos_player,1},'camps_stacked')
    return
end
if ~isfield(datamatch.players{pos_player,1},'creeps_stacked')
    return
end
if ~isfield(datamatch.players{pos_player,1},'last_hits')
    return
end
if ~isfield(datamatch.players{pos_player,1},'denies')
    return
end
if ~isfield(datamatch.players{pos_player,1},'gold_per_min')
    return
end
if ~isfield(datamatch.players{pos_player,1},'xp_per_min')
    return
end
if ~isfield(datamatch.players{pos_player,1},'level')
    return
end
if ~isfield(datamatch.players{pos_player,1},'gold')
    return
end
if ~isfield(datamatch.players{pos_player,1},'gold_spent')
    return
end
if ~isfield(datamatch.players{pos_player,1},'firstblood_claimed')
    return
end
if ~isfield(datamatch.players{pos_player,1},'roshan_kills')
    return
end
if ~isfield(datamatch.players{pos_player,1},'tower_kills')
    return
end
if ~isfield(datamatch.players{pos_player,1},'kda')
    return
end
if ~isfield(datamatch.players{pos_player,1},'hero_damage')
    return
end
if ~isfield(datamatch.players{pos_player,1},'tower_damage')
    return
end
if ~isfield(datamatch.players{pos_player,1},'hero_healing')
    return
end
if ~isfield(datamatch.players{pos_player,1},'rune_pickups')
    return
end
if ~isfield(datamatch.players{pos_player,1},'stuns')
    return
end
if ~isfield(datamatch.players{pos_player,1},'teamfight_participation')
    return
end
if ~isfield(datamatch.players{pos_player,1},'lane_efficiency')
    return
end
if ~isfield(datamatch.players{pos_player,1},'lane_efficiency_pct')
    return
end
if ~isfield(datamatch.players{pos_player,1},'lane')
    return
end
if ~isfield(datamatch.players{pos_player,1},'lane_role')
    return
end
if ~isfield(datamatch.players{pos_player,1},'actions_per_min')
    return
end
if ~isfield(datamatch.players{pos_player,1},'life_state_dead')
    return
end
if ~isfield(datamatch,'duration')
    return
end
retrieve=1;