function AddTopOpendotaPlayer2TrackList(conn)
List_hero_id=[];
List_account_id=[];
try
    selectQ='select hero_id from hero';
    List_hero_id=select(conn,selectQ);
catch
end

if isempty(List_hero_id)
    disp('fail to get hero_list')
    return
end
List_hero_id=double(List_hero_id.hero_id);
nbr_hero=length(List_hero_id);

for i=1:nbr_hero
    pause(1)
    try
        id_hero=List_hero_id(i);
        RQString=['https://api.opendota.com/api/rankings?hero_id=',num2str(id_hero)];
        options = weboptions('Timeout',60);
        data=webread(RQString,options);
        data=struct2table(data.rankings);
        List_account_id=[List_account_id;data.account_id];
    catch
    end
end

List_account_id=unique(List_account_id);

selectQ='select player_id from player';
List_account_id_database=select(conn,selectQ);
List_account_id_database=double(List_account_id_database.player_id);

List_account_id_add=setdiff(List_account_id,List_account_id_database);
List_account_id_update=intersect(List_account_id,List_account_id_database);

if ~isempty(List_account_id_add)
    nbr=length(List_account_id_add);
    name=strings(nbr,1);
    track=ones(nbr,1);
    table_data_add=table(List_account_id_add,name,track);
    table_data_add.Properties.VariableNames={'player_id','player_name','track'};
    sqlwrite(conn,'player',table_data_add);
end
if ~isempty(List_account_id_update)
   nbr=length(List_account_id_update);
   data=ones(nbr,1);
   whereclause=cell(1,nbr);
   for i=1:nbr
       whereclause{i}=['where player.player_id=',num2str(List_account_id_update(i))];
   end
update(conn,'player','track',data,whereclause)
end
