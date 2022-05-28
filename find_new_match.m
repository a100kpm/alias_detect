function match_id_list=find_new_match(conn,account_id_list)
match_id_list=[];
account_id_list=unique(account_id_list);

time=datetime('now');
time=round(posixtime(time));

for aa=1:length(account_id_list)
    Player_id=account_id_list(aa);
    pause(0.05)
    try
        TktMatch=Tkt_Player_Info_ApiGetValve(Player_id);
        if isa(TktMatch.result.matches,'struct')
            TktMatchTable=struct2table(TktMatch.result.matches);
        else
            TktMatchTable=table();
            for i=1:length(TktMatch.result.matches)
                
                match_id=TktMatch.result.matches{i,1}.match_id;
                start_time=TktMatch.result.matches{i,1}.start_time;
                TktMatchTable=[TktMatchTable;table(match_id,start_time)];
                
            end
        end
        oldest=time-31536000; % 365 jours d'écart
        TktMatchTable(TktMatchTable.start_time<oldest,:)=[];
        %     DateLastCheck=datetime(TktMatchTable.start_time(1,1),'ConvertFrom','posixtime');
        %     datetime --> donne une date lisible
    catch
%     catch ME
%         disp(aa)
%         fprintf('%s',ME.message)
%         continue
    end
    
    id_list=TktMatchTable.match_id;
    id_list=id_list(1:min(100,length(id_list)));
    match_id_list=[match_id_list;id_list];
    
end
match_id_list=unique(match_id_list);
% need something to check the select worked properly !
conn = database('dotaladder','shiba','FTShiBa26','PortNumber',5432,'Server','90.35.1.2','Vendor','PostgreSQL');
conn.Message
pause(5)
% restart co
selectQ='select match_id from matchs where match_scan>=10';
old_match_id_list=select(conn,selectQ);
old_match_id_list=double(old_match_id_list.match_id);

match_id_list=setdiff(match_id_list,old_match_id_list);