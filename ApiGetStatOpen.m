function data=ApiGetStatOpen(id_game)

id_game_rq=num2str(round(id_game));
pause(1)
RQString=['https://api.opendota.com/api/matches/',id_game_rq];
% RQString=['https://api.opendota.com/api/matches/',id_game_rq,'?api_key=63b76659-0bc5-4dfb-b7f8-da0f545a416b'];
options = weboptions('Timeout',60);
data=webread(RQString,options);

end

