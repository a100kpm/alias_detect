javaclasspath('C:\Program Files\MATLAB\R2018b\java\jarext\postgresql-42.2.6.jar')
format long g
conn = database('dotaladder','shiba','FTShiBa26','PortNumber',5432,'Server','90.35.1.2','Vendor','PostgreSQL');
conn.Message

% consider changing value from 4 to 9 (min 10 games)
account_id_list_and_hero=select(conn,'select player_id,hero_id from player_hero_data where nbr>7');

nbr_max=size(account_id_list_and_hero,1);
fake_flag=select(conn,'select * from flag limit 0');
for i=1:nbr_max
    account_id=account_id_list_and_hero(i,1);
    account_id=account_id.player_id;
    hero_id=account_id_list_and_hero(i,2);
    hero_id=hero_id.hero_id;
    selectQ=['select id,match_id,account_id,hero_id,item_0,item_1,item_2,item_3,item_4,item_5,backpack_0,backpack_1,backpack_2,apm,apmx1,apmx2,apmx3,apmx4,apmx5,apmx6,apmx8,apmx10,guardian_use,duration from openplayermatch where openplayermatch.account_id!=',num2str(account_id),'and hero_id=',num2str(hero_id)];
    data=select(conn,selectQ);
    nbr_max2=size(data,1);
    data_player=select(conn,['select * from player_data where player_id=',num2str(account_id)]);
    data_player_hero=select(conn,['select * from player_hero_data where player_id=',num2str(account_id),'and hero_id=',num2str(hero_id)]);
    
    for j=1:nbr_max2
       fake_flag=fake_guardian_database(data(j,:),data_player,data_player_hero,fake_flag); 
    end
end

fake_flag=epuration_data(fake_flag)

% writetable(fake_flag,'data_flag2.csv')

% for i=209:nbr_max
%     disp(i)
%     account_id=account_id_list_and_hero(i,1);
%     account_id=account_id.player_id;
%     hero_id=account_id_list_and_hero(i,2);
%     hero_id=hero_id.hero_id;
%     selectQ=['select id,match_id,account_id,hero_id,item_0,item_1,item_2,item_3,item_4,item_5,backpack_0,backpack_1,backpack_2,apm,apmx1,apmx2,apmx3,apmx4,apmx5,apmx6,apmx8,apmx10,guardian_use,duration from openplayermatch where openplayermatch.account_id!=',num2str(account_id),'and hero_id=',num2str(hero_id), 'and ('];
%     for kk=1:49571
%         selectQ=[selectQ,'match_id=',num2str(m(kk)),' or '];
%     end
%     selectQ(end-3:end)=[];
%     selectQ=[selectQ,')'];
%     data=select(conn,selectQ);
%     nbr_max2=size(data,1);
%     data_player=select(conn,['select * from player_data where player_id=',num2str(account_id)]);
%     data_player_hero=select(conn,['select * from player_hero_data where player_id=',num2str(account_id),'and hero_id=',num2str(hero_id)]);
%     
%     for j=1:nbr_max2
%        fake_flag=fake_guardian_database(data(j,:),data_player,data_player_hero,fake_flag); 
%     end
% end


% textt=['select * from flag where ']
% textt=[textt,'match_id !=',num2str(mn(i)),' and '];

% textt=['select * from flag where ']
% textt=[textt,'match_id=',num2str(match_id_list(i)),' or '];