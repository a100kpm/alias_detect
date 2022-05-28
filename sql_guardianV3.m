javaclasspath('C:\Program Files\MATLAB\R2018b\java\jarext\postgresql-42.2.6.jar')
format long g
% 
% select(conn,"select pg_size_pretty(pg_database_size('dotaladder'))")
% 
% penser a changer les start_ val de dur a variable (pour le moment 0 ou 6 en général)
% penser a changer les derniers sprintf en num2str
% penser a améliorer les "check" au erreurs du a un échec de la récup des
% données via la database
conn = database('dotaladder','shiba','FTShiBa26','PortNumber',5432,'Server','90.35.1.2','Vendor','PostgreSQL');
conn.Message
% % % % % % % 
% pour save en csv writetable(data,'data_flag2.csv')
% % % % % % 
% penser a changer flag en flags dans toutes les fonctions ! (et check si
% flags n'est pas déjà présent avant cela)
% penser a rajouter une fonction pour track un nouveau joueur d'id specifique

% penser a rajouter une fonction qui add automatiquement tout les joueurs en track
% lorsque l'on add de nouveau match (optionnelle)

% ne pas prendre les match d'apm sommé <500 (important pour tournoi, osef pour ladder)
% et de durée de moins de 10 min (important both ladder et tournoi)
% dans la bdd

% % % % 
% add a remove track if player doesn't allow history pickup
% (probably inside find_new_match)
% % % % 
separateur=0.5;
% separateur value is the boundary between legit player and non-legit
% player. <0.5 indicate legitimate player.

if isfile('workspace_full_update.mat')
    load('workspace_full_update.mat');
    disp('updating database from past data...')
    while start_<6
        if nbr_retry>=5
            save('workspace_full_update','start_','flag','data_player_all','data_player_hero_all','match_id_list','scan_value','match_id_processed_list','list_match_player_id','reverse_print')
            disp('cannot update processed data; retry later')
            disp('please do not touch to the save of the workspace till relaunching sql_guardian')
            disp('sql_guardian will automatically attempt to update database with that save at next run')
            return
        end
        nbr_retry=nbr_retry+1;
        pause(5)
        [start_,flag,data_player_all,data_player_hero_all,match_id_list,scan_value,match_id_processed_list,list_match_player_id,reverse_print]=...
            full_update(conn,flag,data_player_all,data_player_hero_all,match_id_list,scan_value,match_id_processed_list,list_match_player_id,reverse_print,start_);
    end
    if start_==6
        delete('workspace_full_update.mat')
    end
end


% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
% CALL FUNCTION TO SEARCH FOR ID OF TRACKED PLAYERS
account_id_list=find_tracked_player(conn);
if isempty(account_id_list)
    disp('no player is currently being tracked')
    return
end
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
match_id_list_retry_add=[];


% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
% CALL FUNCTION TO SEARCH FOR NEW MATCHS OF THE TRACKED PLAYERS
match_id_list=find_new_match(conn,account_id_list);
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %

% start looping from here to the end
% start looping from here to the end
% start looping from here to the end
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
% CALL FUNCTION TO ADD DATA OF THOSE NEW MATCHS
match_id_list=[match_id_list;match_id_list_retry_add];
% conn = database('dotaladder','shiba','FTShiBa26','PortNumber',5432,'Server','90.35.1.2','Vendor','PostgreSQL');
match_id_list_retry_add=add_data_match(conn,match_id_list);
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %

% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
% CALL FUNCTION TO SEARCH FOR UNPROCESSED MATCH OF THOSE TRACKED PLAYERS
match_id_list=find_unprocessed_openplayerdata(conn);
if isempty(match_id_list)
    return
end
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %

% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
% INIT FLAGS FOR THE GUARDIAN
[flag,~,~,rez]=init_empty_table(conn);
compteur=0;
while rez==0
    compteur=compteur+1;
    if compteur>5
        disp('trouble to access database')
        return
    end
    pause(5)
    [flag,~,~,rez]=init_empty_table(conn);
end

[match_id_list_retry,start_,flag,data_player_all,data_player_hero_all,...
    match_id_list,scan_value,match_id_processed_list,list_match_player_id,reverse_print]=...
    guardian_database(conn,account_id_list,match_id_list,flag,separateur);

nbr_retry=0;
while start_<5
    if nbr_retry>=5
        save('workspace_full_update','start_','flag','data_player_all','data_player_hero_all','match_id_list','scan_value','match_id_processed_list','list_match_player_id','reverse_print')
        disp('cannot update processed data; retry later')
        disp('please do not touch to the save of the workspace till relaunching sql_guardian')
        disp('sql_guardian will automatically attempt to update database with that save at next run')
        return
    end
    nbr_retry=nbr_retry+1;
    pause(5)
    [start_,flag,data_player_all,data_player_hero_all,match_id_list,scan_value,match_id_processed_list,list_match_player_id,reverse_print]=...
        full_update(conn,flag,data_player_all,data_player_hero_all,match_id_list,scan_value,match_id_processed_list,list_match_player_id,reverse_print,start_);
end


% end loop (add condition so that we only stop at the right moment)
% (and auto stop if no more match to process)

% save match_id_list_retry_add ??? // a priori non








