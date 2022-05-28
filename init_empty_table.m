function [flag,data_player_all,data_player_hero_all,rez]=init_empty_table(conn)
flag=1;data_player_all=1;data_player_hero_all=1;rez=1;
selectQ='select * from flag limit 0';
flag=select(conn,selectQ);
% selectQ='select * from player_data limit 0';
% data_player_all=select(conn,selectQ);
% selectQ='select * from player_hero_data limit 0';
% data_player_hero_all=select(conn,selectQ);

% if flag==1 || data_player_all==1 || data_player_hero_all==1
if isa(flag,'double')
    rez=0
end
% we want only to go on if rez=1
