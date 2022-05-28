function [id_hero,id_all,id_flag]=find_max_id(conn)
id_hero=0;
id_all=0;
id_flag=0;

selectQ='select max(id) from flag';
val=select(conn,selectQ);
if ~isempty(val)
    id_flag=double(val.max);
    if id_flag<1
        id_flag=0;
    end
end
selectQ='select max(id) from player_data';
val=select(conn,selectQ);
if ~isempty(val)
    id_all=double(val.max);
    if id_all<1
        id_all=0;
    end
end
selectQ='select max(id) from player_hero_data';
val=select(conn,selectQ);
if ~isempty(val)
    id_hero=double(val.max);
    if id_hero<1
        id_hero=0;
    end
end