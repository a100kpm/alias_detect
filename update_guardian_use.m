function update_guardian_use(conn,list_match_player_id)
if ~isempty(list_match_player_id)
    nbr=size(list_match_player_id,1);
    data=[];
    whereclause={};
    for i=1:nbr
        whereclause{end+1}=['where openplayermatch.match_id=',num2str(list_match_player_id(i,1)),' and openplayermatch.account_id=',num2str(list_match_player_id(i,2))];
        data=[data;1];
    end
    
    whereclause=whereclause';
    
    
    update(conn,'openplayermatch','guardian_use',data,whereclause)
end