function [match_id_list_retry,start_,flag,data_player_all,data_player_hero_all,...
    match_id_list,scan_value,match_id_processed_list,list_match_player_id,reverse_print]=...
    guardian_database(conn,account_id_list,match_id_list,flag,separateur)
% if start_~=6 we want to rerun full_update with all the saved data
% flag,data_player_all_new,data_player_hero_all_new are 3 empty tables
% created before hand (see function init_empty_table)
% separateur=0.5;
% separateur value is the boundary between legit player and non-legit
% player. <0.5 indicate legitimate player.
scan_value=11;
if ~isempty(account_id_list) && ~isempty(match_id_list)
    match_id_processed_list=[];
    list_match_player_id=[];
    
    [data_player_all,data_player_hero_all]=retrieve_guardian_playerdata(conn,account_id_list);
    % need a
    reroll=0;
    id_hero=-1;id_all=-1;id_flag=-1;
    [id_hero,id_all,id_flag]=find_max_id(conn);
    while id_hero<0 || id_all<0 || id_flag<0
        reroll=reroll+1;
        if reroll>=5
            disp('cannot retry max_id')
            return
        end
        pause(2);
        [id_hero,id_all,id_flag]=find_max_id(conn);
    end
    % find a way to track 'i' so that each who failed get recorded and re added
    for i=1:length(match_id_list)
        data=[];
        try
            selectQ=['select id,match_id,account_id,hero_id,item_0,item_1,item_2,item_3,item_4,item_5,backpack_0,backpack_1,backpack_2,apm,apmx1,apmx2,apmx3,apmx4,apmx5,apmx6,apmx8,apmx10,guardian_use,duration,leaver_status from openplayermatch inner join player on player.player_id=openplayermatch.account_id where openplayermatch.match_id=',num2str(match_id_list(i)),' and player.track=1'];
            data=select(conn,selectQ);
        catch
            disp(['cannot retrieve data of match id ',num2str(match_id_list(i))])
        end
        %     if ok put record match_id to later put guardian_use from value 0 to 1
        if ~isempty(data)
            match_id_processed_list=[match_id_processed_list,match_id_list(i)];
            
            %     get max id of table flag,player_data and player_hero_data
            for j=1:height(data)
                [flag,data_player_all,data_player_hero_all,id_hero,id_all,id_flag]=...
                    MyLittleGuardian_Unit(flag,data_player_hero_all,data_player_all,data(j,:),id_hero,id_all,id_flag);
                list_match_player_id=[list_match_player_id;data.match_id(j),data.account_id(j)];
                %        both "new" table are empty version of the "old" table
            end
        else
            disp('fail to get data')
        end
    end
    %     here will be a function that will treat the table flag and change the
    %     value of global flag to 1 if detection, 0 if no detection
    %     base value is -1 when no treatment is done
    
    modelfile='new_model';
    net = importKerasNetwork(modelfile);
    net_key = csvread('cleff.csv');
    nbr_try=0;
    while nbr_try<10 && ~exist('net','var')
        pause(1)
        net = importKerasNetwork(modelfile);
        nbr_try=nbr_try+1;
    end
    
    if exist('net','var')
        flag=guardian_flag(net,net_key,flag);
    end
        
    %     here will be a function that will treat the table flag and change the
    %     value of global flag to 1 if detection, 0 if no detection
    %     base value is -1 when no treatment is done   
    match_id_list_retry=setdiff(match_id_list,match_id_processed_list); % list of match we have to retry using guardian on
    reverse_print=stock_reverse_print(flag,separateur);
    start_=0;
    [start_,flag,data_player_all,data_player_hero_all,match_id_list,scan_value,match_id_processed_list,list_match_player_id,reverse_print]=...
        full_update(conn,flag,data_player_all,data_player_hero_all,match_id_list,scan_value,match_id_processed_list,list_match_player_id,reverse_print,start_);
else
    disp('nothing new to analyze')
    match_id_list_retry=[];
    start_=6; % change that value to w/e is the max of full_update
    data_player_hero_all=[];data_player_all=[];match_id_processed_list=[];
    list_match_player_id=[];reverse_print=[];
end