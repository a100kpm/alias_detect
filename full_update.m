function [start_,flag,data_player_all,data_player_hero_all,match_id_list,scan_value,match_id_processed_list,list_match_player_id,reverse_print]=...
    full_update(conn,flag,data_player_all,data_player_hero_all,match_id_list,scan_value,match_id_processed_list,list_match_player_id,reverse_print,start_)
% this function update everything after guardian unit is done
% start_ val is there to know where to restart the function in case one
% part failed
% change a bit so that start_ is actually relevant

if start_==0
    match_processed2analyzed(conn,match_id_processed_list,scan_value+1)
    start_=1;
end
if start_==1
    update_player_data(conn,data_player_all)
    start_=2;
end
if start_==2
    update_player_hero_data(conn,data_player_hero_all)
    start_=3;
end
if start_==3
    update_flag(conn,flag)
    start_=4;
end
if start_==4
    update_reverse_print(conn,reverse_print)
    start_=5;
end


