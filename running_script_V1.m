% Le but de ce script est de ramasser des donn�es legit uniquement
Hero=importdata('init.mat');

try
    list_match=importdata('list_match.mat');
catch
    list_match=[]
    
end
try
    Player_stats=importdata('Player_stats.mat');
catch
    Player_stats=table()
end
try
    aaa=importdata('table_legit.mat');
catch
    aaa=[]
end
% id_tournoi=10810
id_tn=input('enter id_tournoi')
pause(1)
try
    TktMatch=TktInfo_ApiGetValve(id_tn);
    TktMatchTable=struct2table(TktMatch.result.matches);
    max_recent=max(TktMatchTable.start_time(:));
    oldest=max_recent-864000 % (10 jours d'�cart d'�cart max)
    TktMatchTable(TktMatchTable.start_time<oldest,:)=[];
    DateLastCheck=datetime(TktMatchTable.start_time(1,1),'ConvertFrom','posixtime');
catch ME
    fprintf('%s',ME.message)
end

id_list=TktMatchTable.match_id;

for k=1:length(id_list)
    disp(k)
    newMatch_id=id_list(k);
    if isempty(find(list_match==newMatch_id,1)) 
        try
            datamatch=ApiGetStatOpen(newMatch_id);
            [TABLE_FLAG,Player_stats,list_match] = MyLittleGuardianV3(datamatch,Player_stats,Hero,list_match);
            aaa=[aaa;TABLE_FLAG];
        catch ME
            fprintf('%s',ME.message)
        end
    else
        disp('match already in base_list')
    end
end
save('list_match.mat','list_match')
save('Player_stats.mat','Player_stats')
save('table_legit.mat','aaa')

% csvwrite('myFile.csv',aaa)