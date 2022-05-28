function match_id_list=add_data_match_para(conn,match_id_list)
% add data related to tracked player that happened to be in match_id_list
nbr_max=length(match_id_list);
match_id_list_processed=ones(nbr_max+1,1)*(-1);
if isempty(gcp('nocreate'))
    parpool(6)
end

parfor (i=1:nbr_max)
    disp([num2str(i),'/',num2str(nbr_max)])
    process=add_match(conn,match_id_list(i),0); % add the game to list, with scan tag 0
    %     or update its scan value if we already attempted and failed to retrieve data from the game
    if process==0
        match_id_list_processed(i)=match_id_list(i);
        continue
    end
    datamatch=[];
    try
        datamatch=ApiGetStatOpen(match_id_list(i)); % try to retrieve data
    catch
    end
    %     add something to check if the retrival of data as been completed
    %     properly
    %  add a function for this! add a function for this! add a function for this! add a function for this! add a function for this! add a function for this!
    retrive=check_data_quality(datamatch);
    %     retrive=1; % val temp, 0 si fail, 1 si réussit
    
    if retrive==1
        stock_data_temp_para(datamatch)
        add_openmatch(conn,datamatch)
        for pos_player=1:10
            account_id=datamatch.players{pos_player,1}.account_id;
            
            if ~isempty(account_id)
                selectQ=sprintf('select * from player where player.player_id=%f',account_id);
                data_player=select(conn,selectQ);
                if ~isempty(data_player)
                    %             start update player name
                    player_name=datamatch.players{pos_player,1}.personaname;
                    update_player(conn,account_id,player_name)
                    %             end update player name
                    add_openplayermatch(conn,datamatch,pos_player)
                else
                    add_player(conn,account_id,0)
                    add_openplayermatch(conn,datamatch,pos_player)
                end
            end
            
        end
        add_match(conn,match_id_list(i),1);
        match_id_list_processed(i)=match_id_list(i);
    end
end
%         get state of the match to know if we have to remove the game
%         from the list or not -new function-
match_id_list=setdiff(match_id_list,match_id_list_processed);
reshape(match_id_list,length(match_id_list),1);

