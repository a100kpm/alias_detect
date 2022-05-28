function add_player(conn,player_id,track,name)
% track = 1 --> track
% track = 0 --> no track
if nargin==3
    name=' ';
end

selectQ=sprintf('select * from player where player.player_id=%f' ,player_id);
player_info=select(conn,selectQ);

if ~isempty(player_info)
    player_info.track=track;
    if ~isequal(player_info.player_name,{''}) && isequal(name,' ')
        % don't change name to empty name
    else
        player_info.player_name=name;
    end
    player_info=standardizeMissing(player_info,' ');
    whereclause=sprintf('where player.player_id=%f' , player_id);
    update(conn,'player',{'player_id','player_name','track'},player_info,whereclause)
    return
end

player_info=[player_info;{player_id,name,track}];
player_info=standardizeMissing(player_info,' ');

sqlwrite(conn,'player',player_info);