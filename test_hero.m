function [TABLE_FLAG,Player_stats,list_match]=test_hero(TABLE_FLAG,Player_stats,Hero,list_match,id_list,HERO_NAME)
% a priori taper la liste avec [nbr] puis rajouter les éléments suivant
% avec liste(end+1) = new_elem
% id_list =[4705058690,4704541848,4702551885,4695691522,4692520145,4691667176,4688955663,4686063630,4683060779,4680101002,4679383700,4678989004,4677170710,4676871742,4662780954,4652742570,4652086564,4643370811,4641117448,4640934672,4637781965,4636296294,4632889418,4630667984,4630336742,4626603813,4626011049,4621274195,4620212670,4616309019,4614429421,4611921961,4611784654,4600399916,4597392360,4596495034,4593240007,4591638697]
% player_idd=49382246
for i=1:length(id_list)
    try
        val=id_list(i);
        datamatch=ApiGetStatOpen(val);
        [TABLE_FLAG,Player_stats,list_match] = MyLittleGuardian_hero_based(datamatch,Player_stats,Hero,list_match,HERO_NAME);
        disp(i)
    catch
    end
end

id_list_test=[4692568820,4704372744,4704288137,4696828362,4698829443,4703072611,4703202868,4698164043,4699168779,4701713416,4692899633,4693162810,4693159257,4702527301,4703125708,4698674698,4692412823,4694195908,4693437073];
id_list_test=[id_list_test,4712504888,4727091803,4724373756,4713801073];
aaa=[];
for i=1:length(id_list_test)
    val=id_list_test(i);
    datamatch=ApiGetStatOpen(val);
    [TABLE_FLAG] = check_hero(datamatch,Player_stats,Hero,list_match,HERO_NAME,player_idd);
    aaa=[aaa;TABLE_FLAG];
    disp(i)
end