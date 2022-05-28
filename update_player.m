function update_player(conn,player_id,player_name)

selectQ=sprintf('select track from player where player.player_id=%f' ,player_id);
track=select(conn,selectQ);

add_player(conn,player_id,track.track,player_name)