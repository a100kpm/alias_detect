function account_id_list=find_tracked_player(conn)
account_id_list=[];
selectQ='select player_id from player where track=1';
account_id_list=select(conn,selectQ);
account_id_list=double(account_id_list.player_id);