function empty_table = create_empty_tableV2(Hero,ID_HERO,deb,account_id)
% empty_table sert a creer des lignes de table,
% pour les integrer dans Player_stats


%% deb est une variable binaire indiquant si le joueur a déjà une entré dans la table de stats
%% s'il elle vaut 0, elle indique que non, et que par consequent il faut
%% creer la ligne ALL en plus de la ligne hero.

if deb==0
    Player_id = ones(2,1)*account_id;
    ID = ID_HERO; ID = [0; ID];
    pos_hero=find(Hero.ID==ID(2));
    NOM = Hero.Nom(pos_hero); NOM = ['ALL'; NOM];
    nbr = zeros(2,1);
    apm = zeros(2,1);
    ratio_apm1 = zeros(2,1);
    ratio_apm2 = zeros(2,1);
    ratio_apm3 = zeros(2,1);
    ratio_apm4 = zeros(2,1);
    ratio_apm5 = zeros(2,1);
    ratio_apm6 = zeros(2,1);
    ratio_apm7 = zeros(2,1);
    ratio_apm8 = zeros(2,1);
    position_boot1 = zeros(2,1);
    position_boot2 = zeros(2,1);
    position_boot3 = zeros(2,1);
    position_boot4 = zeros(2,1);
    position_boot5 = zeros(2,1);
    position_boot6 = zeros(2,1);
    variance_apm = zeros(2,1);
    position_dagger1 = zeros(2,1);
    position_dagger2 = zeros(2,1);
    position_dagger3 = zeros(2,1);
    position_dagger4 = zeros(2,1);
    position_dagger5 = zeros(2,1);
    position_dagger6 = zeros(2,1);
    position_glimmer1 = zeros(2,1);
    position_glimmer2 = zeros(2,1);
    position_glimmer3 = zeros(2,1);
    position_glimmer4 = zeros(2,1);
    position_glimmer5 = zeros(2,1);
    position_glimmer6 = zeros(2,1);
    position_solar1 = zeros(2,1);
    position_solar2 = zeros(2,1);
    position_solar3 = zeros(2,1);
    position_solar4 = zeros(2,1);
    position_solar5 = zeros(2,1);
    position_solar6 = zeros(2,1);
    position_bkb1 = zeros(2,1);
    position_bkb2 = zeros(2,1);
    position_bkb3 = zeros(2,1);
    position_bkb4 = zeros(2,1);
    position_bkb5 = zeros(2,1);
    position_bkb6 = zeros(2,1);
    position_forcestaff1 = zeros(2,1);
    position_forcestaff2 = zeros(2,1);
    position_forcestaff3 = zeros(2,1);
    position_forcestaff4 = zeros(2,1);
    position_forcestaff5 = zeros(2,1);
    position_forcestaff6 = zeros(2,1);
    variance_ratio_apm1 = zeros(2,1);
    variance_ratio_apm2 = zeros(2,1);
    variance_ratio_apm3 = zeros(2,1);
    variance_ratio_apm4 = zeros(2,1);
    variance_ratio_apm5 = zeros(2,1);
    variance_ratio_apm6 = zeros(2,1);
    variance_ratio_apm7 = zeros(2,1);
    variance_ratio_apm8 = zeros(2,1);
    
    position_actif1 = zeros(2,1);
    position_actif2 = zeros(2,1);
    position_actif3 = zeros(2,1);
    position_actif4 = zeros(2,1);
    position_actif5 = zeros(2,1);
    position_actif6 = zeros(2,1);
    
else
    Player_id = account_id;
    ID = ID_HERO;
    pos_hero=find(Hero.ID==ID);
    NOM = Hero.Nom(pos_hero);
    nbr = 0;
    apm = 0;
    ratio_apm1 = 0;
    ratio_apm2 = 0;
    ratio_apm3 = 0;
    ratio_apm4 = 0;
    ratio_apm5 = 0;
    ratio_apm6 = 0;
    ratio_apm7 = 0;
    ratio_apm8 = 0;
    position_boot1 = 0;
    position_boot2 = 0;
    position_boot3 = 0;
    position_boot4 = 0;
    position_boot5 = 0;
    position_boot6 = 0;
    variance_apm = 0; %% ne sera à priori update QUE pour les héros et pas globalement
    position_dagger1 = 0;
    position_dagger2 = 0;
    position_dagger3 = 0;
    position_dagger4 = 0;
    position_dagger5 = 0;
    position_dagger6 = 0;
    
    position_glimmer1 = 0;
    position_glimmer2 = 0;
    position_glimmer3 = 0;
    position_glimmer4 = 0;
    position_glimmer5 = 0;
    position_glimmer6 = 0;
    
    position_solar1 = 0;
    position_solar2 = 0;
    position_solar3 = 0;
    position_solar4 = 0;
    position_solar5 = 0;
    position_solar6 = 0;
    
    position_bkb1 = 0;
    position_bkb2 = 0;
    position_bkb3 = 0;
    position_bkb4 = 0;
    position_bkb5 = 0;
    position_bkb6 = 0;
    
    position_forcestaff1 = 0;
    position_forcestaff2 = 0;
    position_forcestaff3 = 0;
    position_forcestaff4 = 0;
    position_forcestaff5 = 0;
    position_forcestaff6 = 0;
    
    variance_ratio_apm1 = 0;
    variance_ratio_apm2 = 0;
    variance_ratio_apm3 = 0;
    variance_ratio_apm4 = 0;
    variance_ratio_apm5 = 0;
    variance_ratio_apm6 = 0;
    variance_ratio_apm7 = 0;
    variance_ratio_apm8 = 0;
    
    position_actif1 = 0;
    position_actif2 = 0;
    position_actif3 = 0;
    position_actif4 = 0;
    position_actif5 = 0;
    position_actif6 = 0;
end

empty_table = table(Player_id,ID,NOM,nbr,apm,variance_apm,ratio_apm1,ratio_apm2,ratio_apm3,ratio_apm4,ratio_apm5,ratio_apm6,ratio_apm7,ratio_apm8,position_boot1,position_boot2,position_boot3,position_boot4,position_boot5,position_boot6,position_dagger1,position_dagger2,position_dagger3,position_dagger4,position_dagger5,position_dagger6,position_glimmer1,position_glimmer2,position_glimmer3,position_glimmer4,position_glimmer5,position_glimmer6,position_solar1,position_solar2,position_solar3,position_solar4,position_solar5,position_solar6,position_bkb1,position_bkb2,position_bkb3,position_bkb4,position_bkb5,position_bkb6,position_forcestaff1,position_forcestaff2,position_forcestaff3,position_forcestaff4,position_forcestaff5,position_forcestaff6,variance_ratio_apm1,variance_ratio_apm2,variance_ratio_apm3,variance_ratio_apm4,variance_ratio_apm5,variance_ratio_apm6,variance_ratio_apm7,variance_ratio_apm8,position_actif1,position_actif2,position_actif3,position_actif4,position_actif5,position_actif6);
