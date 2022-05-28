function fake_flag=fake_guardian_database(data,data_all,data_hero,fake_flag)

match_id=data.match_id;
player_id=data.account_id;
% hero_id=data.hero_id;

id_flag=1;

duration=data.duration;
apm=data.apm;
apm_hero=data_hero.apm;
% nbr=data_all.nbr;
nbr_hero=data_hero.nbr;

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

%     FLAG SUR LES BOOTS
table_position_boot=[data_all.position_boot1,data_all.position_boot2,data_all.position_boot3,data_all.position_boot4,data_all.position_boot5,data_all.position_boot6];
[~,flag_average_boot,~] = bayesien_boot(table_position_boot,position_boot);
table_position_boot=[data_hero.position_boot1,data_hero.position_boot2,data_hero.position_boot3,data_hero.position_boot4,data_hero.position_boot5,data_hero.position_boot6];
[~,flag_hero_boot,~] = bayesien_boot(table_position_boot,position_boot);
%     FLAG SUR LES APM
[~,flag_hero_apm,~] = gaussien_apm(apm_hero,apm,nbr_hero,variance_hero);
%     FLAG SUR LA DAGGER
table_position_dagger=[data_all.position_dagger1,data_all.position_dagger2,data_all.position_dagger3,data_all.position_dagger4,data_all.position_dagger5,data_all.position_dagger6];
[~,flag_average_dagger,~] = bayesien_dagger(table_position_dagger,position_dagger);
table_position_dagger=[data_hero.position_dagger1,data_hero.position_dagger2,data_hero.position_dagger3,data_hero.position_dagger4,data_hero.position_dagger5,data_hero.position_dagger6];
[~,flag_hero_dagger,~] = bayesien_dagger(table_position_dagger,position_dagger);
%     FLAG SUR LA GLIMMER
table_position_glimmer=[data_all.position_glimmer1,data_all.position_glimmer2,data_all.position_glimmer3,data_all.position_glimmer4,data_all.position_glimmer5,data_all.position_glimmer6];
[~,flag_average_glimmer,~] = bayesien_glimmer(table_position_glimmer,position_glimmer);
table_position_glimmer=[data_hero.position_glimmer1,data_hero.position_glimmer2,data_hero.position_glimmer3,data_hero.position_glimmer4,data_hero.position_glimmer5,data_hero.position_glimmer6];
[~,flag_hero_glimmer,~] = bayesien_glimmer(table_position_glimmer,position_glimmer);
% FLAG SUR LE SOLAR_CREST
table_position_solar=[data_all.position_solar1,data_all.position_solar2,data_all.position_solar3,data_all.position_solar4,data_all.position_solar5,data_all.position_solar6];
[~,flag_average_solar,~] = bayesien_solar(table_position_solar,position_solar);
table_position_solar=[data_hero.position_solar1,data_hero.position_solar2,data_hero.position_solar3,data_hero.position_solar4,data_hero.position_solar5,data_hero.position_solar6];
[~,flag_hero_solar,~] = bayesien_solar(table_position_solar,position_solar);
% FLAG SUR LE BKB
table_position_bkb=[data_all.position_bkb1,data_all.position_bkb2,data_all.position_bkb3,data_all.position_bkb4,data_all.position_bkb5,data_all.position_bkb6];
[~,flag_average_bkb,~] = bayesien_bkb(table_position_bkb,position_bkb);
table_position_bkb=[data_hero.position_bkb1,data_hero.position_bkb2,data_hero.position_bkb3,data_hero.position_bkb4,data_hero.position_bkb5,data_hero.position_bkb6];
[~,flag_hero_bkb,~] = bayesien_bkb(table_position_bkb,position_bkb);
% FLAG SUR LE FORCESTAFF
table_position_forcestaff=[data_all.position_forcestaff1,data_all.position_forcestaff2,data_all.position_forcestaff3,data_all.position_forcestaff4,data_all.position_forcestaff5,data_all.position_forcestaff6];
[~,flag_average_forcestaff,~] = bayesien_forcestaff(table_position_forcestaff,position_forcestaff);
table_position_forcestaff=[data_hero.position_forcestaff1,data_hero.position_forcestaff2,data_hero.position_forcestaff3,data_hero.position_forcestaff4,data_hero.position_forcestaff5,data_hero.position_forcestaff6];
[~,flag_hero_forcestaff,~] = bayesien_forcestaff(table_position_forcestaff,position_forcestaff);
%     FLAG SUR LES RATIO_APM
[~,flag_hero_apm1,~] = gaussien_apm(ratio_apm_hero1,ratio_apm1,nbr_hero,variance_ratio_apm1);
[~,flag_hero_apm2,~] = gaussien_apm(ratio_apm_hero2,ratio_apm2,nbr_hero,variance_ratio_apm2);
[~,flag_hero_apm3,~] = gaussien_apm(ratio_apm_hero3,ratio_apm3,nbr_hero,variance_ratio_apm3);
[~,flag_hero_apm4,~] = gaussien_apm(ratio_apm_hero4,ratio_apm4,nbr_hero,variance_ratio_apm4);

[~,flag_hero_apm5,~] = gaussien_apm(ratio_apm_hero5,ratio_apm5,nbr_hero,variance_ratio_apm5);
[~,flag_hero_apm6,~] = gaussien_apm(ratio_apm_hero6,ratio_apm6,nbr_hero,variance_ratio_apm6);
[~,flag_hero_apm7,~] = gaussien_apm(ratio_apm_hero7,ratio_apm7,nbr_hero,variance_ratio_apm7);
[~,flag_hero_apm8,~] = gaussien_apm(ratio_apm_hero8,ratio_apm8,nbr_hero,variance_ratio_apm8);

%     FLAG SUR LES ITEMS ACTIFS
table_position_actif=[data_all.position_actif1,data_all.position_actif2,data_all.position_actif3,data_all.position_actif4,data_all.position_actif5,data_all.position_actif6];
[~,flag_average_actif] = bayesien_actif(table_position_actif,position_actif);
table_position_actif=[data_hero.position_actif1,data_hero.position_actif2,data_hero.position_actif3,data_hero.position_actif4,data_hero.position_actif5,data_hero.position_actif6];
[~,flag_hero_actif] = bayesien_actif(table_position_actif,position_actif);

%     RESULTAT
flag=table(id_flag,match_id,player_id,-1,flag_average_boot,flag_hero_boot,flag_hero_apm,flag_average_dagger,flag_hero_dagger,flag_average_glimmer,flag_hero_glimmer,flag_average_solar,flag_hero_solar,flag_average_bkb,flag_hero_bkb,flag_average_forcestaff,flag_hero_forcestaff,flag_hero_apm1,flag_hero_apm2,flag_hero_apm3,flag_hero_apm4,flag_hero_apm5,flag_hero_apm6,flag_hero_apm7,flag_hero_apm8,flag_average_actif,flag_hero_actif);
%               1       2        3     4          5               6                   7               8               9                    10              11           12                 13             14                      15                 16          17                  18              19          20              21              22              23              24              25               26              27
flag.Properties.VariableNames=fake_flag.Properties.VariableNames;
fake_flag=[fake_flag;flag];