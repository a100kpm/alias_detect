function [TABLE_FLAG,Player_stats,list_match]=test_hero(TABLE_FLAG,Player_stats,Hero,list_match,id_list,HERO_NAME)
% a priori taper la liste avec [nbr] puis rajouter les éléments suivant
% avec liste(end+1) = new_elem
for i=1:length(id_list)
    try
        val=id_list(i);
        datamatch=ApiGetStatOpen(val);
        [TABLE_FLAG,Player_stats,list_match] = MyLittleGuardian_hero_based(datamatch,Player_stats,Hero,list_match,HERO_NAME);
        
    catch
    end
end