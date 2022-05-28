function match_id_list=find_unprocessed_openplayerdata(conn)
selectQ=sprintf('select open.match_id from openplayermatch as open,player where open.account_id=player.player_id and player.track=1 and open.guardian_use=0');
data_id_list=select(conn,selectQ);
match_id_list=double((unique(data_id_list.match_id)));