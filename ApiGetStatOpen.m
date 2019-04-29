function data=ApiGetStatOpen(id_game)
% not my code (thx shiba)
id_game_rq=num2str(round(id_game));
RQString=['https://api.opendota.com/api/matches/',id_game_rq];
options = weboptions('Timeout',60);
data=webread(RQString,options);

end
