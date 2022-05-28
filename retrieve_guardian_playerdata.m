function [data_player_all_old,data_player_hero_all_old]=retrieve_guardian_playerdata(conn,account_id_list)
selectQ='select * from player_data where';
selectQ_end=sprintf(' player_id=%f or',account_id_list);
selectQ_end=selectQ_end(1:length(selectQ_end)-3);
selectQ=[selectQ,selectQ_end];
data_player_all_old=select(conn,selectQ);

selectQ='select * from player_hero_data where';
selectQ=[selectQ,selectQ_end];
data_player_hero_all_old=select(conn,selectQ);
