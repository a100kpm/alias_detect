function [flag,data_player_all,data_player_hero_all,id_hero,id_all,id_flag]=...
    MyLittleGuardian_Unit(flag,data_player_hero_all,data_player_all,data,id_hero,id_all,id_flag)
% the 3 ids are the max id we can find in the corresponding table
duration=data.duration;
if duration<900
    disp(" warning, program shouldn't run this, preprocessing function need to get reviewed in order to remove game that are too short")
    return
end
if data.leaver_status>0
%     consider adding a separate value in guardian_use (like 2 instead of 1) 
%     for game with leaver, to mb process them for real in separated
%     instance    
    disp(" warning leaver")
    return
end
if data.apm<60
%     consider adding a separate value in guardian_use (like 3 instead of 1) 
%     for game with low apm, to mb process them for real in separated
%     instance
    disp(" warning, apm too small")
    return
end

match_id=data.match_id;
player_id=data.account_id;
hero_id=data.hero_id;
% id_hero=max([max(data_player_hero_all_new.id),max(data_player_hero_all.id)])+1;
% id_all=max([max(data_player_all_new.id),max(data_player_all.id)])+1;
id_hero=id_hero+1;
id_all=id_all+1;
id_flag=id_flag+1;
new=[0,0];
% Beware there's a sneaky bug with the creation of the two empty table
% below. For unknown reason, it can create player_id and hero_id col with a
% cell array containing a numeric value instead of a plain numeric value
% need some investigation at some point !!!

% START INIT OF TABLE
if isempty(data_player_all(data_player_all.player_id==player_id,:))
    new=[1,1];
    data_all=table(id_all,player_id,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,...
        0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
    data_hero=table(id_hero,player_id,hero_id,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,...
        0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
    %     data_player_all_new=[data_player_all_new;data_all];
    %     data_player_hero_all_new=[data_player_hero_all_new;data_hero];
    
elseif isempty(data_player_hero_all(data_player_hero_all.player_id==player_id & data_player_hero_all.hero_id==hero_id,:))
    new=[0,1];
    %     data_player_hero_all_new=[data_player_hero_all_new;{id,player_id,hero_id,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,...
    %         0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}];
    data_all=data_player_all(data_player_all.player_id==player_id,:);
    data_hero=table(id_hero,player_id,hero_id,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,...
        0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
else
    data_all=data_player_all(data_player_all.player_id==player_id,:);
    data_hero=data_player_hero_all(data_player_hero_all.player_id==player_id & data_player_hero_all.hero_id==hero_id,:);
end
data_all.Properties.VariableNames=data_player_all.Properties.VariableNames;
data_hero.Properties.VariableNames=data_player_hero_all.Properties.VariableNames;
% END INIT OF TABLE

apm=data.apm;
apm_hero=data_hero.apm;

ratio_apm_hero1=data_hero.ratio_apm1;
ratio_apm_hero2=data_hero.ratio_apm2;
ratio_apm_hero3=data_hero.ratio_apm3;
ratio_apm_hero4=data_hero.ratio_apm4;

ratio_apm_hero5=data_hero.ratio_apm5;
ratio_apm_hero6=data_hero.ratio_apm6;
ratio_apm_hero7=data_hero.ratio_apm7;
ratio_apm_hero8=data_hero.ratio_apm8;

action_total=round(apm*duration/60);
[~,position_boot,~] =       get_boot_position(data.item_0,data.item_1,data.item_2,data.item_3,data.item_4,data.item_5);
[position_dagger,~] =       get_dagger_position(data.item_0,data.item_1,data.item_2,data.item_3,data.item_4,data.item_5);
[position_glimmer,~] =      get_glimmer_position(data.item_0,data.item_1,data.item_2,data.item_3,data.item_4,data.item_5);
[position_solar,~] =        get_solar_position(data.item_0,data.item_1,data.item_2,data.item_3,data.item_4,data.item_5);
[position_bkb,~] =          get_bkb_position(data.item_0,data.item_1,data.item_2,data.item_3,data.item_4,data.item_5);
[position_forcestaff,~] =   get_forcestaff_position(data.item_0,data.item_1,data.item_2,data.item_3,data.item_4,data.item_5);
[~,position_actif,~] =      get_actif_position(data.item_0,data.item_1,data.item_2,data.item_3,data.item_4,data.item_5);

variance_hero=data_hero.variance_apm;

variance_ratio_apm1=data_hero.variance_ratio_apm1;
variance_ratio_apm2=data_hero.variance_ratio_apm2;
variance_ratio_apm3=data_hero.variance_ratio_apm3;
variance_ratio_apm4=data_hero.variance_ratio_apm4;
variance_ratio_apm5=data_hero.variance_ratio_apm5;
variance_ratio_apm6=data_hero.variance_ratio_apm6;
variance_ratio_apm7=data_hero.variance_ratio_apm7;
variance_ratio_apm8=data_hero.variance_ratio_apm8;

% % % %     VARIABLE IMPORTANT POUR LA SECTION B % % % % % % % % % % % % %
data_hero.nbr=data_hero.nbr+1;
data_all.nbr=data_all.nbr+1;

nbr=data_all.nbr;
nbr_hero=data_hero.nbr;
% % % %     FIN VARIABLE IMPORTANT POUR LA SECTION B % % % % % % % % % % %



%     ratio move to position
ratio_apm1=data.apmx1/action_total;
%     ratio move to target
ratio_apm2=data.apmx2/action_total;
%     ratio attaque move
ratio_apm3=data.apmx3/action_total;
%     ratio attaque target
ratio_apm4=data.apmx4/action_total;
%     ratio cast to position
ratio_apm5=data.apmx5/action_total;
%     ratio cast on target
ratio_apm6=data.apmx6/action_total;
%     ratio cast no target
ratio_apm7=data.apmx8/action_total;
%     ratio hold position
ratio_apm8=data.apmx10/action_total;



% zone de flag pour la fonction check_triche a implémenter
%% ne pas oublier de rajouter des poids pour les flag héro != flag average
%     FLAG SUR LES BOOTS
table_position_boot=[data_all.position_boot1,data_all.position_boot2,data_all.position_boot3,data_all.position_boot4,data_all.position_boot5,data_all.position_boot6];
[~,flag_average_boot,~] = bayesien_boot(table_position_boot,position_boot);
table_position_boot=[data_hero.position_boot1,data_hero.position_boot2,data_hero.position_boot3,data_hero.position_boot4,data_hero.position_boot5,data_hero.position_boot6];
[~,flag_hero_boot,position_boot_val] = bayesien_boot(table_position_boot,position_boot);
%     FLAG SUR LES APM
[~,flag_hero_apm,new_variance] = gaussien_apm(apm_hero,apm,nbr_hero,variance_hero);
%     FLAG SUR LA DAGGER
table_position_dagger=[data_all.position_dagger1,data_all.position_dagger2,data_all.position_dagger3,data_all.position_dagger4,data_all.position_dagger5,data_all.position_dagger6];
[~,flag_average_dagger,~] = bayesien_dagger(table_position_dagger,position_dagger);
table_position_dagger=[data_hero.position_dagger1,data_hero.position_dagger2,data_hero.position_dagger3,data_hero.position_dagger4,data_hero.position_dagger5,data_hero.position_dagger6];
[~,flag_hero_dagger,position_dagger_val] = bayesien_dagger(table_position_dagger,position_dagger);
%     FLAG SUR LA GLIMMER
table_position_glimmer=[data_all.position_glimmer1,data_all.position_glimmer2,data_all.position_glimmer3,data_all.position_glimmer4,data_all.position_glimmer5,data_all.position_glimmer6];
[~,flag_average_glimmer,~] = bayesien_glimmer(table_position_glimmer,position_glimmer);
table_position_glimmer=[data_hero.position_glimmer1,data_hero.position_glimmer2,data_hero.position_glimmer3,data_hero.position_glimmer4,data_hero.position_glimmer5,data_hero.position_glimmer6];
[~,flag_hero_glimmer,position_glimmer_val] = bayesien_glimmer(table_position_glimmer,position_glimmer);
% FLAG SUR LE SOLAR_CREST
table_position_solar=[data_all.position_solar1,data_all.position_solar2,data_all.position_solar3,data_all.position_solar4,data_all.position_solar5,data_all.position_solar6];
[~,flag_average_solar,~] = bayesien_solar(table_position_solar,position_solar);
table_position_solar=[data_hero.position_solar1,data_hero.position_solar2,data_hero.position_solar3,data_hero.position_solar4,data_hero.position_solar5,data_hero.position_solar6];
[~,flag_hero_solar,position_solar_val] = bayesien_solar(table_position_solar,position_solar);
% FLAG SUR LE BKB
table_position_bkb=[data_all.position_bkb1,data_all.position_bkb2,data_all.position_bkb3,data_all.position_bkb4,data_all.position_bkb5,data_all.position_bkb6];
[~,flag_average_bkb,~] = bayesien_bkb(table_position_bkb,position_bkb);
table_position_bkb=[data_hero.position_bkb1,data_hero.position_bkb2,data_hero.position_bkb3,data_hero.position_bkb4,data_hero.position_bkb5,data_hero.position_bkb6];
[~,flag_hero_bkb,position_bkb_val] = bayesien_bkb(table_position_bkb,position_bkb);
% FLAG SUR LE FORCESTAFF
table_position_forcestaff=[data_all.position_forcestaff1,data_all.position_forcestaff2,data_all.position_forcestaff3,data_all.position_forcestaff4,data_all.position_forcestaff5,data_all.position_forcestaff6];
[~,flag_average_forcestaff,~] = bayesien_forcestaff(table_position_forcestaff,position_forcestaff);
table_position_forcestaff=[data_hero.position_forcestaff1,data_hero.position_forcestaff2,data_hero.position_forcestaff3,data_hero.position_forcestaff4,data_hero.position_forcestaff5,data_hero.position_forcestaff6];
[~,flag_hero_forcestaff,position_forcestaff_val] = bayesien_forcestaff(table_position_forcestaff,position_forcestaff);
%     FLAG SUR LES RATIO_APM
[~,flag_hero_apm1,new_variance1] = gaussien_apm(ratio_apm_hero1,ratio_apm1,nbr_hero,variance_ratio_apm1);
[~,flag_hero_apm2,new_variance2] = gaussien_apm(ratio_apm_hero2,ratio_apm2,nbr_hero,variance_ratio_apm2);
[~,flag_hero_apm3,new_variance3] = gaussien_apm(ratio_apm_hero3,ratio_apm3,nbr_hero,variance_ratio_apm3);
[~,flag_hero_apm4,new_variance4] = gaussien_apm(ratio_apm_hero4,ratio_apm4,nbr_hero,variance_ratio_apm4);

[~,flag_hero_apm5,new_variance5] = gaussien_apm(ratio_apm_hero5,ratio_apm5,nbr_hero,variance_ratio_apm5);
[~,flag_hero_apm6,new_variance6] = gaussien_apm(ratio_apm_hero6,ratio_apm6,nbr_hero,variance_ratio_apm6);
[~,flag_hero_apm7,new_variance7] = gaussien_apm(ratio_apm_hero7,ratio_apm7,nbr_hero,variance_ratio_apm7);
[~,flag_hero_apm8,new_variance8] = gaussien_apm(ratio_apm_hero8,ratio_apm8,nbr_hero,variance_ratio_apm8);

%     FLAG SUR LES ITEMS ACTIFS
table_position_actif=[data_all.position_actif1,data_all.position_actif2,data_all.position_actif3,data_all.position_actif4,data_all.position_actif5,data_all.position_actif6];
[~,flag_average_actif] = bayesien_actif(table_position_actif,position_actif);
table_position_actif=[data_hero.position_actif1,data_hero.position_actif2,data_hero.position_actif3,data_hero.position_actif4,data_hero.position_actif5,data_hero.position_actif6];
[~,flag_hero_actif] = bayesien_actif(table_position_actif,position_actif);

%     RESULTAT
flag_temp=table(id_flag,match_id,player_id,-1,flag_average_boot,flag_hero_boot,flag_hero_apm,flag_average_dagger,flag_hero_dagger,flag_average_glimmer,flag_hero_glimmer,flag_average_solar,flag_hero_solar,flag_average_bkb,flag_hero_bkb,flag_average_forcestaff,flag_hero_forcestaff,flag_hero_apm1,flag_hero_apm2,flag_hero_apm3,flag_hero_apm4,flag_hero_apm5,flag_hero_apm6,flag_hero_apm7,flag_hero_apm8,flag_average_actif,flag_hero_actif);
%               1       2          3       4          5               6                   7               8               9                    10              11           12                 13             14                      15                 16          17                  18              19          20              21              22              23              24              25               26              27
flag_temp.Properties.VariableNames=flag.Properties.VariableNames;
flag=[flag ; flag_temp];



%       variable nombre importante pour les moyennes a venir % % % % % % %
%%%%% section B %%%%%    %%%%% section B %%%%%    %%%%% section B %%%%%
%%%%% section B %%%%%    %%%%% section B %%%%%    %%%%% section B %%%%%
%%%%% section B %%%%%    %%%%% section B %%%%%    %%%%% section B %%%%%
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
data_all.apm=((nbr-1)*data_all.apm+apm)/nbr;
data_hero.apm=((nbr_hero-1)*data_all.apm+apm)/nbr_hero;

data_all.ratio_apm1=((nbr-1)*data_all.ratio_apm1+ratio_apm1)/nbr;
data_hero.ratio_apm1=((nbr_hero-1)*data_hero.ratio_apm1+ratio_apm1)/nbr_hero;

data_all.ratio_apm2=((nbr-1)*data_all.ratio_apm2+ratio_apm2)/nbr;
data_hero.ratio_apm2=((nbr_hero-1)*data_hero.ratio_apm2+ratio_apm2)/nbr_hero;

data_all.ratio_apm3=((nbr-1)*data_all.ratio_apm3+ratio_apm3)/nbr;
data_hero.ratio_apm3=((nbr_hero-1)*data_hero.ratio_apm3+ratio_apm3)/nbr_hero;

data_all.ratio_apm4=((nbr-1)*data_all.ratio_apm4+ratio_apm4)/nbr;
data_hero.ratio_apm4=((nbr_hero-1)*data_hero.ratio_apm4+ratio_apm4)/nbr_hero;

data_all.ratio_apm5=((nbr-1)*data_all.ratio_apm5+ratio_apm5)/nbr;
data_hero.ratio_apm5=((nbr_hero-1)*data_hero.ratio_apm5+ratio_apm5)/nbr_hero;

data_all.ratio_apm6=((nbr-1)*data_all.ratio_apm6+ratio_apm6)/nbr;
data_hero.ratio_apm6=((nbr_hero-1)*data_hero.ratio_apm6+ratio_apm6)/nbr_hero;

data_all.ratio_apm7=((nbr-1)*data_all.ratio_apm7+ratio_apm7)/nbr;
data_hero.ratio_apm7=((nbr_hero-1)*data_hero.ratio_apm7+ratio_apm7)/nbr_hero;

data_all.ratio_apm8=((nbr-1)*data_all.ratio_apm8+ratio_apm8)/nbr;
data_hero.ratio_apm8=((nbr_hero-1)*data_hero.ratio_apm8+ratio_apm8)/nbr_hero;


if isempty(position_boot_val)
    position_boot_val=0;
end
switch position_boot_val
    case 1
        data_all.position_boot1=data_all.position_boot1+1;
        data_hero.position_boot1=data_hero.position_boot1+1;
    case 2
        data_all.position_boot2=data_all.position_boot2+1;
        data_hero.position_boot2=data_hero.position_boot2+1;
    case 3
        data_all.position_boot3=data_all.position_boot3+1;
        data_hero.position_boot3=data_hero.position_boot3+1;
    case 4
        data_all.position_boot4=data_all.position_boot4+1;
        data_hero.position_boot4=data_hero.position_boot4+1;
    case 5
        data_all.position_boot5=data_all.position_boot5+1;
        data_hero.position_boot5=data_hero.position_boot5+1;
    case 6
        data_all.position_boot6=data_all.position_boot6+1;
        data_hero.position_boot6=data_hero.position_boot6+1;
end

data_hero.variance_apm=new_variance;

data_hero.variance_ratio_apm1=new_variance1;
data_hero.variance_ratio_apm2=new_variance2;
data_hero.variance_ratio_apm3=new_variance3;
data_hero.variance_ratio_apm4=new_variance4;

data_hero.variance_ratio_apm5=new_variance5;
data_hero.variance_ratio_apm6=new_variance6;
data_hero.variance_ratio_apm7=new_variance7;
data_hero.variance_ratio_apm8=new_variance8;

if isempty(position_dagger_val)
    position_dagger_val=0;
end
switch position_dagger_val
    case 1
        data_all.position_dagger1=data_all.position_dagger1+1;
        data_hero.position_dagger1=data_hero.position_dagger1+1;
    case 2
        data_all.position_dagger2=data_all.position_dagger2+1;
        data_hero.position_dagger2=data_hero.position_dagger2+1;
    case 3
        data_all.position_dagger3=data_all.position_dagger3+1;
        data_hero.position_dagger3=data_hero.position_dagger3+1;
    case 4
        data_all.position_dagger4=data_all.position_dagger4+1;
        data_hero.position_dagger4=data_hero.position_dagger4+1;
    case 5
        data_all.position_dagger5=data_all.position_dagger5+1;
        data_hero.position_dagger5=data_hero.position_dagger5+1;
    case 6
        data_all.position_dagger6=data_all.position_dagger6+1;
        data_hero.position_dagger6=data_hero.position_dagger6+1;
end

if isempty(position_glimmer_val)
    position_glimmer_val=0;
end
switch position_glimmer_val
    case 1
        data_all.position_glimmer1=data_all.position_glimmer1+1;
        data_hero.position_glimmer1=data_hero.position_glimmer1+1;
    case 2
        data_all.position_glimmer2=data_all.position_glimmer2+1;
        data_hero.position_glimmer2=data_hero.position_glimmer2+1;
    case 3
        data_all.position_glimmer3=data_all.position_glimmer3+1;
        data_hero.position_glimmer3=data_hero.position_glimmer3+1;
    case 4
        data_all.position_glimmer4=data_all.position_glimmer4+1;
        data_hero.position_glimmer4=data_hero.position_glimmer4+1;
    case 5
        data_all.position_glimmer5=data_all.position_glimmer5+1;
        data_hero.position_glimmer5=data_hero.position_glimmer5+1;
    case 6
        data_all.position_glimmer6=data_all.position_glimmer6+1;
        data_hero.position_glimmer6=data_hero.position_glimmer6+1;
end

if isempty(position_solar_val)
    position_solar_val=0;
end
switch position_solar_val
    case 1
        data_all.position_solar1=data_all.position_solar1+1;
        data_hero.position_solar1=data_hero.position_solar1+1;
    case 2
        data_all.position_solar2=data_all.position_solar2+1;
        data_hero.position_solar2=data_hero.position_solar2+1;
    case 3
        data_all.position_solar3=data_all.position_solar3+1;
        data_hero.position_solar3=data_hero.position_solar3+1;
    case 4
        data_all.position_solar4=data_all.position_solar4+1;
        data_hero.position_solar4=data_hero.position_solar4+1;
    case 5
        data_all.position_solar5=data_all.position_solar5+1;
        data_hero.position_solar5=data_hero.position_solar5+1;
    case 6
        data_all.position_solar6=data_all.position_solar6+1;
        data_hero.position_solar6=data_hero.position_solar6+1;
end

if isempty(position_bkb_val)
    position_bkb_val=0;
end
switch position_bkb_val
    case 1
        data_all.position_bkb1=data_all.position_bkb1+1;
        data_hero.position_bkb1=data_hero.position_bkb1+1;
    case 2
        data_all.position_bkb2=data_all.position_bkb2+1;
        data_hero.position_bkb2=data_hero.position_bkb2+1;
    case 3
        data_all.position_bkb3=data_all.position_bkb3+1;
        data_hero.position_bkb3=data_hero.position_bkb3+1;
    case 4
        data_all.position_bkb4=data_all.position_bkb4+1;
        data_hero.position_bkb4=data_hero.position_bkb4+1;
    case 5
        data_all.position_bkb5=data_all.position_bkb5+1;
        data_hero.position_bkb5=data_hero.position_bkb5+1;
    case 6
        data_all.position_bkb6=data_all.position_bkb6+1;
        data_hero.position_bkb6=data_hero.position_bkb6+1;
end

if isempty(position_forcestaff_val)
    position_forcestaff_val=0;
end
switch position_forcestaff_val
    case 1
        data_all.position_forcestaff1=data_all.position_forcestaff1+1;
        data_hero.position_forcestaff1=data_hero.position_forcestaff1+1;
    case 2
        data_all.position_forcestaff2=data_all.position_forcestaff2+1;
        data_hero.position_forcestaff2=data_hero.position_forcestaff2+1;
    case 3
        data_all.position_forcestaff3=data_all.position_forcestaff3+1;
        data_hero.position_forcestaff3=data_hero.position_forcestaff3+1;
    case 4
        data_all.position_forcestaff4=data_all.position_forcestaff4+1;
        data_hero.position_forcestaff4=data_hero.position_forcestaff4+1;
    case 5
        data_all.position_forcestaff5=data_all.position_forcestaff5+1;
        data_hero.position_forcestaff5=data_hero.position_forcestaff5+1;
    case 6
        data_all.position_forcestaff6=data_all.position_forcestaff6+1;
        data_hero.position_forcestaff6=data_hero.position_forcestaff6+1;
end

if ~isempty(position_actif)
    if position_actif(1)==1
        data_all.position_actif1=data_all.position_actif1+1;
        data_hero.position_actif1=data_hero.position_actif1+1;
    end
    if position_actif(2)==1
        data_all.position_actif2=data_all.position_actif2+1;
        data_hero.position_actif2=data_hero.position_actif2+1;
    end
    if position_actif(3)==1
        data_all.position_actif3=data_all.position_actif3+1;
        data_hero.position_actif3=data_hero.position_actif3+1;
    end
    if position_actif(4)==1
        data_all.position_actif4=data_all.position_actif4+1;
        data_hero.position_actif4=data_hero.position_actif4+1;
    end
    if position_actif(5)==1
        data_all.position_actif5=data_all.position_actif5+1;
        data_hero.position_actif5=data_hero.position_actif5+1;
    end
    if position_actif(6)==1
        data_all.position_actif6=data_all.position_actif6+1;
        data_hero.position_actif6=data_hero.position_actif6+1;
    end
end

if new(1)==1
    data_player_all=[data_player_all;data_all];
else
    data_player_all(data_player_all.player_id==player_id,:)=data_all;
    id_all=id_all-1;
end
if new(2)==1
    data_player_hero_all=[data_player_hero_all;data_hero];
else
    data_player_hero_all(data_player_hero_all.hero_id==hero_id & data_player_hero_all.player_id==player_id,:)=data_hero;
    id_hero=id_hero-1;
end

