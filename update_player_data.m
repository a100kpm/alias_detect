function update_player_data(conn,data_player_all)

list_all_id=data_player_all.player_id;
selectQ='select player_data.player_id from player_data where';
nbr=length(list_all_id);

for i=1:nbr
    selectQ=[selectQ,' player_id=',num2str(list_all_id(i)),' or'];
end
selectQ(end-2:end)=[];
list_id_update=select(conn,selectQ);
list_id_update=table2array(list_id_update);
list_id_add=setdiff(list_all_id,list_id_update);

whereclause={};
data=[];
for i=1:length(list_id_update)
    whereclause{end+1}=['where player_data.player_id=',num2str(list_id_update(i))];
    data=[data;data_player_all(data_player_all.player_id==list_id_update(i),:)];
end
whereclause=whereclause';


list_col={'id','player_id','nbr','apm','variance_apm','ratio_apm1','ratio_apm2','ratio_apm3','ratio_apm4',...
    'ratio_apm5','ratio_apm6','ratio_apm7','ratio_apm8','position_boot1','position_boot2',...
    'position_boot3','position_boot4','position_boot5','position_boot6','position_dagger1',...
    'position_dagger2','position_dagger3','position_dagger4','position_dagger5','position_dagger6',...
    'position_glimmer1','position_glimmer2','position_glimmer3','position_glimmer4','position_glimmer5',...
    'position_glimmer6','position_solar1','position_solar2','position_solar3','position_solar4',...
    'position_solar5','position_solar6','position_bkb1','position_bkb2','position_bkb3',...
    'position_bkb4','position_bkb5','position_bkb6','position_forcestaff1','position_forcestaff2',...
    'position_forcestaff3','position_forcestaff4','position_forcestaff5','position_forcestaff6',...
    'variance_ratio_apm1','variance_ratio_apm2','variance_ratio_apm3','variance_ratio_apm4',...
    'variance_ratio_apm5','variance_ratio_apm6','variance_ratio_apm7','variance_ratio_apm8',...
    'position_actif1','position_actif2','position_actif3','position_actif4','position_actif5','position_actif6'};
if ~isempty(data)
    update(conn,'player_data',list_col,data,whereclause)
end

data=data_player_all(ismember(data_player_all.player_id,list_id_add),:);
if ~isempty(data)
    sqlwrite(conn,'player_data',data)
end

