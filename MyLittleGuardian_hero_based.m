function [TABLE_FLAG,Player_stats,list_match] = MyLittleGuardian_hero_based(datamatch,Player_stats,Hero,list_match,HERO_NAME)

%% il faut list_match=[], Player_stats=table la toute première fois qu'il fonctionne.


%% évite qu'un match soit traité deux fois
newMatch=datamatch;
if ~isempty(find(list_match==newMatch.match_id,1))
    TABLE_FLAG=[];
else
    list_match=[list_match;newMatch.match_id];
    TABLE_FLAG=[];
    duration = newMatch.duration;
    match_id=newMatch.match_id;
end
%% la partie apm_global est la pour dégager les match non joué où les creeps auraient finit la game
%% alors que les joueurs avaient déjà quitté depuis longtemps.
apm_global=newMatch.players{1,1}.actions_per_min+newMatch.players{2,1}.actions_per_min+newMatch.players{3,1}.actions_per_min...
    +newMatch.players{4,1}.actions_per_min+newMatch.players{5,1}.actions_per_min+newMatch.players{6,1}.actions_per_min...
    +newMatch.players{7,1}.actions_per_min+newMatch.players{8,1}.actions_per_min+newMatch.players{9,1}.actions_per_min...
    +newMatch.players{10,1}.actions_per_min;
if apm_global<500
    return
end
%% ne prend pas en compte les parties de moins de 10 minutes
if duration<600
    return
end

%% boucle joueur pour remplir les infos
for i=1:10
    player_id=newMatch.players{i,1}.account_id;
    %%% degage les profiles privées
    if isempty(player_id)
        continue
    end
    %%%
    hero=newMatch.players{i,1}.hero_id;
    if ~strcmp(HERO_NAME,Hero.Nom(Hero.ID==hero))
        continue
    end
    
    % si le joueur n'a pas d'entrée, on créer l'entrée all et l'entrée du héro
    if isempty(Player_stats) || isempty(find(Player_stats.Player_id==player_id,1))
        empty_table = create_empty_tableV2(Hero,hero,0,player_id);
        Player_stats=[Player_stats;empty_table];
    end
    % si le joueur n'a pas d'entrée du héro de cette partie, on créer son entrée
    if isempty(find(Player_stats(Player_stats.Player_id==player_id,:).ID==hero,1))
        empty_table = create_empty_tableV2(Hero,hero,1,player_id);
        Player_stats=[Player_stats;empty_table];
    end
    
    %% Player_stats(Player_stats.Player_id==player_id,:).CeQueJeVeux(position) %%
    position = find(Player_stats(Player_stats.Player_id==player_id,:).ID==hero);
    
    apm=newMatch.players{i,1}.actions_per_min;
    apm_hero=Player_stats(Player_stats.Player_id==player_id,:).apm(position);
    
    ratio_apm_hero1=Player_stats(Player_stats.Player_id==player_id,:).ratio_apm1(position);
    ratio_apm_hero2=Player_stats(Player_stats.Player_id==player_id,:).ratio_apm2(position);
    ratio_apm_hero3=Player_stats(Player_stats.Player_id==player_id,:).ratio_apm3(position);
    ratio_apm_hero4=Player_stats(Player_stats.Player_id==player_id,:).ratio_apm4(position);
    
    ratio_apm_hero5=Player_stats(Player_stats.Player_id==player_id,:).ratio_apm5(position);
    ratio_apm_hero6=Player_stats(Player_stats.Player_id==player_id,:).ratio_apm6(position);
    ratio_apm_hero7=Player_stats(Player_stats.Player_id==player_id,:).ratio_apm7(position);
    ratio_apm_hero8=Player_stats(Player_stats.Player_id==player_id,:).ratio_apm8(position);
    
    action_total=round(apm*duration/60);
    [~,position_boot,~] =       get_boot_position(newMatch.players{i,1}.item_0,newMatch.players{i,1}.item_1,newMatch.players{i,1}.item_2,newMatch.players{i,1}.item_3,newMatch.players{i,1}.item_4,newMatch.players{i,1}.item_5);
    [position_dagger,~] =       get_dagger_position(newMatch.players{i,1}.item_0,newMatch.players{i,1}.item_1,newMatch.players{i,1}.item_2,newMatch.players{i,1}.item_3,newMatch.players{i,1}.item_4,newMatch.players{i,1}.item_5);
    [position_glimmer,~] =      get_glimmer_position(newMatch.players{i,1}.item_0,newMatch.players{i,1}.item_1,newMatch.players{i,1}.item_2,newMatch.players{i,1}.item_3,newMatch.players{i,1}.item_4,newMatch.players{i,1}.item_5);
    [position_solar,~] =        get_solar_position(newMatch.players{i,1}.item_0,newMatch.players{i,1}.item_1,newMatch.players{i,1}.item_2,newMatch.players{i,1}.item_3,newMatch.players{i,1}.item_4,newMatch.players{i,1}.item_5);
    [position_bkb,~] =          get_bkb_position(newMatch.players{i,1}.item_0,newMatch.players{i,1}.item_1,newMatch.players{i,1}.item_2,newMatch.players{i,1}.item_3,newMatch.players{i,1}.item_4,newMatch.players{i,1}.item_5);
    [position_forcestaff,~] =   get_forcestaff_position(newMatch.players{i,1}.item_0,newMatch.players{i,1}.item_1,newMatch.players{i,1}.item_2,newMatch.players{i,1}.item_3,newMatch.players{i,1}.item_4,newMatch.players{i,1}.item_5);
    [~,position_actif,~] =      get_actif_position(newMatch.players{i,1}.item_0,newMatch.players{i,1}.item_1,newMatch.players{i,1}.item_2,newMatch.players{i,1}.item_3,newMatch.players{i,1}.item_4,newMatch.players{i,1}.item_5);
    
    variance_hero=Player_stats(Player_stats.Player_id==player_id,:).variance_apm(position);
    
    variance_ratio_apm1=Player_stats(Player_stats.Player_id==player_id,:).variance_ratio_apm1(position);
    variance_ratio_apm2=Player_stats(Player_stats.Player_id==player_id,:).variance_ratio_apm2(position);
    variance_ratio_apm3=Player_stats(Player_stats.Player_id==player_id,:).variance_ratio_apm3(position);
    variance_ratio_apm4=Player_stats(Player_stats.Player_id==player_id,:).variance_ratio_apm4(position);
    variance_ratio_apm5=Player_stats(Player_stats.Player_id==player_id,:).variance_ratio_apm5(position);
    variance_ratio_apm6=Player_stats(Player_stats.Player_id==player_id,:).variance_ratio_apm6(position);
    variance_ratio_apm7=Player_stats(Player_stats.Player_id==player_id,:).variance_ratio_apm7(position);
    variance_ratio_apm8=Player_stats(Player_stats.Player_id==player_id,:).variance_ratio_apm8(position);
    
    
    
    % % % %     VARIABLE IMPORTANT POUR LA SECTION B % % % % % % % % % % % % %
    Player_stats(Player_stats.Player_id==player_id,:).nbr(1)=Player_stats(Player_stats.Player_id==player_id,:).nbr(1)+1;
    Player_stats(Player_stats.Player_id==player_id,:).nbr(position)=Player_stats(Player_stats.Player_id==player_id,:).nbr(position)+1;
    
    nbr=Player_stats(Player_stats.Player_id==player_id,:).nbr(1);
    nbr_hero=Player_stats(Player_stats.Player_id==player_id,:).nbr(position);
    % % % %     FIN VARIABLE IMPORTANT POUR LA SECTION B % % % % % % % % % % %
    
    
    
    %     ratio move to position
    if isfield(newMatch.players{i,1}.actions,'x1')
        ratio_apm1=newMatch.players{i,1}.actions.x1/action_total;
    else
        ratio_apm1=0;
    end
    %     ratio move to target
    if isfield(newMatch.players{i,1}.actions,'x2')
        ratio_apm2=newMatch.players{i,1}.actions.x2/action_total;
    else
        ratio_apm2=0;
    end
    
    %     ratio attaque move
    if isfield(newMatch.players{i,1}.actions,'x3')
        ratio_apm3=newMatch.players{i,1}.actions.x3/action_total;
    else
        ratio_apm3=0;
    end
    
    %     ratio attaque target
    if isfield(newMatch.players{i,1}.actions,'x4')
        ratio_apm4=newMatch.players{i,1}.actions.x4/action_total;
    else
        ratio_apm4=0;
    end
    
    %     ratio cast to position
    if isfield(newMatch.players{i,1}.actions,'x5')
        ratio_apm5=newMatch.players{i,1}.actions.x5/action_total;
    else
        ratio_apm5=0;
    end
    %     ratio cast on target
    if isfield(newMatch.players{i,1}.actions,'x6')
        ratio_apm6=newMatch.players{i,1}.actions.x6/action_total;
    else
        ratio_apm6=0;
    end
    %     ratio cast no target
    if isfield(newMatch.players{i,1}.actions,'x8')
        ratio_apm7=newMatch.players{i,1}.actions.x8/action_total;
    else
        ratio_apm7=0;
    end
    %     ratio hold position (10 ou 33)
    if isfield(newMatch.players{i,1}.actions,'x10')
        ratio_apm8=newMatch.players{i,1}.actions.x10/action_total;
    else
        ratio_apm8=0;
    end
    
    
    
    % zone de flag pour la fonction check_triche a implémenter
    %% ne pas oublier de rajouter des poids pour les flag héro != flag average
    %     FLAG SUR LES BOOTS
    table_position_boot=[Player_stats(Player_stats.Player_id==player_id,:).position_boot1(1),Player_stats(Player_stats.Player_id==player_id,:).position_boot2(1),Player_stats(Player_stats.Player_id==player_id,:).position_boot3(1),Player_stats(Player_stats.Player_id==player_id,:).position_boot4(1),Player_stats(Player_stats.Player_id==player_id,:).position_boot5(1),Player_stats(Player_stats.Player_id==player_id,:).position_boot6(1)];
    [~,flag_average_boot,~] = bayesien_boot(table_position_boot,position_boot);
    table_position_boot=[Player_stats(Player_stats.Player_id==player_id,:).position_boot1(position),Player_stats(Player_stats.Player_id==player_id,:).position_boot2(position),Player_stats(Player_stats.Player_id==player_id,:).position_boot3(position),Player_stats(Player_stats.Player_id==player_id,:).position_boot4(position),Player_stats(Player_stats.Player_id==player_id,:).position_boot5(position),Player_stats(Player_stats.Player_id==player_id,:).position_boot6(position)];
    [~,flag_hero_boot,position_boot_val] = bayesien_boot(table_position_boot,position_boot);
    %     FLAG SUR LES APM
    [~,flag_hero_apm,new_variance] = gaussien_apm(apm_hero,apm,nbr_hero,variance_hero);
    %     FLAG SUR LA DAGGER
    table_position_dagger=[Player_stats(Player_stats.Player_id==player_id,:).position_dagger1(1),Player_stats(Player_stats.Player_id==player_id,:).position_dagger2(1),Player_stats(Player_stats.Player_id==player_id,:).position_dagger3(1),Player_stats(Player_stats.Player_id==player_id,:).position_dagger4(1),Player_stats(Player_stats.Player_id==player_id,:).position_dagger5(1),Player_stats(Player_stats.Player_id==player_id,:).position_dagger6(1)];
    [~,flag_average_dagger,~] = bayesien_dagger(table_position_dagger,position_dagger);
    table_position_dagger=[Player_stats(Player_stats.Player_id==player_id,:).position_dagger1(position),Player_stats(Player_stats.Player_id==player_id,:).position_dagger2(position),Player_stats(Player_stats.Player_id==player_id,:).position_dagger3(position),Player_stats(Player_stats.Player_id==player_id,:).position_dagger4(position),Player_stats(Player_stats.Player_id==player_id,:).position_dagger5(position),Player_stats(Player_stats.Player_id==player_id,:).position_dagger6(position)];
    [~,flag_hero_dagger,position_dagger_val] = bayesien_dagger(table_position_dagger,position_dagger);
    %     FLAG SUR LA GLIMMER
    table_position_glimmer=[Player_stats(Player_stats.Player_id==player_id,:).position_glimmer1(1),Player_stats(Player_stats.Player_id==player_id,:).position_glimmer2(1),Player_stats(Player_stats.Player_id==player_id,:).position_glimmer3(1),Player_stats(Player_stats.Player_id==player_id,:).position_glimmer4(1),Player_stats(Player_stats.Player_id==player_id,:).position_glimmer5(1),Player_stats(Player_stats.Player_id==player_id,:).position_glimmer6(1)];
    [~,flag_average_glimmer,~] = bayesien_glimmer(table_position_glimmer,position_glimmer);
    table_position_glimmer=[Player_stats(Player_stats.Player_id==player_id,:).position_glimmer1(position),Player_stats(Player_stats.Player_id==player_id,:).position_glimmer2(position),Player_stats(Player_stats.Player_id==player_id,:).position_glimmer3(position),Player_stats(Player_stats.Player_id==player_id,:).position_glimmer4(position),Player_stats(Player_stats.Player_id==player_id,:).position_glimmer5(position),Player_stats(Player_stats.Player_id==player_id,:).position_glimmer6(position)];
    [~,flag_hero_glimmer,position_glimmer_val] = bayesien_glimmer(table_position_glimmer,position_glimmer);
    % FLAG SUR LE SOLAR_CREST
    table_position_solar=[Player_stats(Player_stats.Player_id==player_id,:).position_solar1(1),Player_stats(Player_stats.Player_id==player_id,:).position_solar2(1),Player_stats(Player_stats.Player_id==player_id,:).position_solar3(1),Player_stats(Player_stats.Player_id==player_id,:).position_solar4(1),Player_stats(Player_stats.Player_id==player_id,:).position_solar5(1),Player_stats(Player_stats.Player_id==player_id,:).position_solar6(1)];
    [~,flag_average_solar,~] = bayesien_solar(table_position_solar,position_solar);
    table_position_solar=[Player_stats(Player_stats.Player_id==player_id,:).position_solar1(position),Player_stats(Player_stats.Player_id==player_id,:).position_solar2(position),Player_stats(Player_stats.Player_id==player_id,:).position_solar3(position),Player_stats(Player_stats.Player_id==player_id,:).position_solar4(position),Player_stats(Player_stats.Player_id==player_id,:).position_solar5(position),Player_stats(Player_stats.Player_id==player_id,:).position_solar6(position)];
    [~,flag_hero_solar,position_solar_val] = bayesien_solar(table_position_solar,position_solar);
    % FLAG SUR LE BKB
    table_position_bkb=[Player_stats(Player_stats.Player_id==player_id,:).position_bkb1(1),Player_stats(Player_stats.Player_id==player_id,:).position_bkb2(1),Player_stats(Player_stats.Player_id==player_id,:).position_bkb3(1),Player_stats(Player_stats.Player_id==player_id,:).position_bkb4(1),Player_stats(Player_stats.Player_id==player_id,:).position_bkb5(1),Player_stats(Player_stats.Player_id==player_id,:).position_bkb6(1)];
    [~,flag_average_bkb,~] = bayesien_bkb(table_position_bkb,position_bkb);
    table_position_bkb=[Player_stats(Player_stats.Player_id==player_id,:).position_bkb1(position),Player_stats(Player_stats.Player_id==player_id,:).position_bkb2(position),Player_stats(Player_stats.Player_id==player_id,:).position_bkb3(position),Player_stats(Player_stats.Player_id==player_id,:).position_bkb4(position),Player_stats(Player_stats.Player_id==player_id,:).position_bkb5(position),Player_stats(Player_stats.Player_id==player_id,:).position_bkb6(position)];
    [~,flag_hero_bkb,position_bkb_val] = bayesien_bkb(table_position_bkb,position_bkb);
    % FLAG SUR LE FORCESTAFF
    table_position_forcestaff=[Player_stats(Player_stats.Player_id==player_id,:).position_forcestaff1(1),Player_stats(Player_stats.Player_id==player_id,:).position_forcestaff2(1),Player_stats(Player_stats.Player_id==player_id,:).position_forcestaff3(1),Player_stats(Player_stats.Player_id==player_id,:).position_forcestaff4(1),Player_stats(Player_stats.Player_id==player_id,:).position_forcestaff5(1),Player_stats(Player_stats.Player_id==player_id,:).position_forcestaff6(1)];
    [~,flag_average_forcestaff,~] = bayesien_forcestaff(table_position_forcestaff,position_forcestaff);
    table_position_forcestaff=[Player_stats(Player_stats.Player_id==player_id,:).position_forcestaff1(position),Player_stats(Player_stats.Player_id==player_id,:).position_forcestaff2(position),Player_stats(Player_stats.Player_id==player_id,:).position_forcestaff3(position),Player_stats(Player_stats.Player_id==player_id,:).position_forcestaff4(position),Player_stats(Player_stats.Player_id==player_id,:).position_forcestaff5(position),Player_stats(Player_stats.Player_id==player_id,:).position_forcestaff6(position)];
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
    table_position_actif=[Player_stats(Player_stats.Player_id==player_id,:).position_actif1(1),Player_stats(Player_stats.Player_id==player_id,:).position_actif2(1),Player_stats(Player_stats.Player_id==player_id,:).position_actif3(1),Player_stats(Player_stats.Player_id==player_id,:).position_actif4(1),Player_stats(Player_stats.Player_id==player_id,:).position_actif5(1),Player_stats(Player_stats.Player_id==player_id,:).position_actif6(1)];
    [~,flag_average_actif] = bayesien_actif(table_position_actif,position_actif);
    table_position_actif=[Player_stats(Player_stats.Player_id==player_id,:).position_actif1(position),Player_stats(Player_stats.Player_id==player_id,:).position_actif2(position),Player_stats(Player_stats.Player_id==player_id,:).position_actif3(position),Player_stats(Player_stats.Player_id==player_id,:).position_actif4(position),Player_stats(Player_stats.Player_id==player_id,:).position_actif5(position),Player_stats(Player_stats.Player_id==player_id,:).position_actif6(position)];
    [~,flag_hero_actif] = bayesien_actif(table_position_actif,position_actif);
    
    %     RESULTAT
    TABLE_FLAG=[TABLE_FLAG ;player_id,match_id,flag_average_boot,flag_hero_boot,flag_hero_apm,flag_average_dagger,flag_hero_dagger,flag_average_glimmer,flag_hero_glimmer,flag_average_solar,flag_hero_solar,flag_average_bkb,flag_hero_bkb,flag_average_forcestaff,flag_hero_forcestaff,flag_hero_apm1,flag_hero_apm2,flag_hero_apm3,flag_hero_apm4,flag_hero_apm5,flag_hero_apm6,flag_hero_apm7,flag_hero_apm8,flag_average_actif,flag_hero_actif];
    
    
    % fin de zone de flag pour la fonction check_triche a implémenter
    
    % appelle de la fonction check_triche en dessous
    %     if check_triche==false:
    
    %       si ne triche pas, ajout des données joueurs
    
    
    %       variable nombre importante pour les moyennes a venir % % % % % % %
    %%%%% section B %%%%%    %%%%% section B %%%%%    %%%%% section B %%%%%
    %%%%% section B %%%%%    %%%%% section B %%%%%    %%%%% section B %%%%%
    %%%%% section B %%%%%    %%%%% section B %%%%%    %%%%% section B %%%%%
    % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
    Player_stats(Player_stats.Player_id==player_id,:).apm(1)=((nbr-1)*Player_stats(Player_stats.Player_id==player_id,:).apm(1)+apm)/nbr;
    Player_stats(Player_stats.Player_id==player_id,:).apm(position)=((nbr_hero-1)*Player_stats(Player_stats.Player_id==player_id,:).apm(position)+apm)/nbr_hero;
    
    Player_stats(Player_stats.Player_id==player_id,:).ratio_apm1(1)=((nbr-1)*Player_stats(Player_stats.Player_id==player_id,:).ratio_apm1(1)+ratio_apm1)/nbr;
    Player_stats(Player_stats.Player_id==player_id,:).ratio_apm1(position)=((nbr_hero-1)*Player_stats(Player_stats.Player_id==player_id,:).ratio_apm1(position)+ratio_apm1)/nbr_hero;
    
    Player_stats(Player_stats.Player_id==player_id,:).ratio_apm2(1)=((nbr-1)*Player_stats(Player_stats.Player_id==player_id,:).ratio_apm2(1)+ratio_apm2)/nbr;
    Player_stats(Player_stats.Player_id==player_id,:).ratio_apm2(position)=((nbr_hero-1)*Player_stats(Player_stats.Player_id==player_id,:).ratio_apm2(position)+ratio_apm2)/nbr_hero;
    
    Player_stats(Player_stats.Player_id==player_id,:).ratio_apm3(1)=((nbr-1)*Player_stats(Player_stats.Player_id==player_id,:).ratio_apm3(1)+ratio_apm3)/nbr;
    Player_stats(Player_stats.Player_id==player_id,:).ratio_apm3(position)=((nbr_hero-1)*Player_stats(Player_stats.Player_id==player_id,:).ratio_apm3(position)+ratio_apm3)/nbr_hero;
    
    Player_stats(Player_stats.Player_id==player_id,:).ratio_apm4(1)=((nbr-1)*Player_stats(Player_stats.Player_id==player_id,:).ratio_apm4(1)+ratio_apm4)/nbr;
    Player_stats(Player_stats.Player_id==player_id,:).ratio_apm4(position)=((nbr_hero-1)*Player_stats(Player_stats.Player_id==player_id,:).ratio_apm4(position)+ratio_apm4)/nbr_hero;
    
    Player_stats(Player_stats.Player_id==player_id,:).ratio_apm5(1)=((nbr-1)*Player_stats(Player_stats.Player_id==player_id,:).ratio_apm5(1)+ratio_apm5)/nbr;
    Player_stats(Player_stats.Player_id==player_id,:).ratio_apm5(position)=((nbr_hero-1)*Player_stats(Player_stats.Player_id==player_id,:).ratio_apm5(position)+ratio_apm5)/nbr_hero;
    
    Player_stats(Player_stats.Player_id==player_id,:).ratio_apm6(1)=((nbr-1)*Player_stats(Player_stats.Player_id==player_id,:).ratio_apm6(1)+ratio_apm6)/nbr;
    Player_stats(Player_stats.Player_id==player_id,:).ratio_apm6(position)=((nbr_hero-1)*Player_stats(Player_stats.Player_id==player_id,:).ratio_apm6(position)+ratio_apm6)/nbr_hero;
    
    Player_stats(Player_stats.Player_id==player_id,:).ratio_apm7(1)=((nbr-1)*Player_stats(Player_stats.Player_id==player_id,:).ratio_apm7(1)+ratio_apm7)/nbr;
    Player_stats(Player_stats.Player_id==player_id,:).ratio_apm7(position)=((nbr_hero-1)*Player_stats(Player_stats.Player_id==player_id,:).ratio_apm7(position)+ratio_apm7)/nbr_hero;
    
    Player_stats(Player_stats.Player_id==player_id,:).ratio_apm8(1)=((nbr-1)*Player_stats(Player_stats.Player_id==player_id,:).ratio_apm8(1)+ratio_apm8)/nbr;
    Player_stats(Player_stats.Player_id==player_id,:).ratio_apm8(position)=((nbr_hero-1)*Player_stats(Player_stats.Player_id==player_id,:).ratio_apm8(position)+ratio_apm8)/nbr_hero;
    
    
    if isempty(position_boot_val)
        position_boot_val=0;
    end
    switch position_boot_val
        case 1
            Player_stats(Player_stats.Player_id==player_id,:).position_boot1(1)=Player_stats(Player_stats.Player_id==player_id,:).position_boot1(1)+1;
            Player_stats(Player_stats.Player_id==player_id,:).position_boot1(position)=Player_stats(Player_stats.Player_id==player_id,:).position_boot1(position)+1;
        case 2
            Player_stats(Player_stats.Player_id==player_id,:).position_boot2(1)=Player_stats(Player_stats.Player_id==player_id,:).position_boot2(1)+1;
            Player_stats(Player_stats.Player_id==player_id,:).position_boot2(position)=Player_stats(Player_stats.Player_id==player_id,:).position_boot2(position)+1;
        case 3
            Player_stats(Player_stats.Player_id==player_id,:).position_boot3(1)=Player_stats(Player_stats.Player_id==player_id,:).position_boot3(1)+1;
            Player_stats(Player_stats.Player_id==player_id,:).position_boot3(position)=Player_stats(Player_stats.Player_id==player_id,:).position_boot3(position)+1;
        case 4
            Player_stats(Player_stats.Player_id==player_id,:).position_boot4(1)=Player_stats(Player_stats.Player_id==player_id,:).position_boot4(1)+1;
            Player_stats(Player_stats.Player_id==player_id,:).position_boot4(position)=Player_stats(Player_stats.Player_id==player_id,:).position_boot4(position)+1;
        case 5
            Player_stats(Player_stats.Player_id==player_id,:).position_boot5(1)=Player_stats(Player_stats.Player_id==player_id,:).position_boot5(1)+1;
            Player_stats(Player_stats.Player_id==player_id,:).position_boot5(position)=Player_stats(Player_stats.Player_id==player_id,:).position_boot5(position)+1;
        case 6
            Player_stats(Player_stats.Player_id==player_id,:).position_boot6(1)=Player_stats(Player_stats.Player_id==player_id,:).position_boot6(1)+1;
            Player_stats(Player_stats.Player_id==player_id,:).position_boot6(position)=Player_stats(Player_stats.Player_id==player_id,:).position_boot6(position)+1;
    end
    
    Player_stats(Player_stats.Player_id==player_id,:).variance_apm(position)=new_variance;
    
    Player_stats(Player_stats.Player_id==player_id,:).variance_ratio_apm1(position)=new_variance1;
    Player_stats(Player_stats.Player_id==player_id,:).variance_ratio_apm2(position)=new_variance2;
    Player_stats(Player_stats.Player_id==player_id,:).variance_ratio_apm3(position)=new_variance3;
    Player_stats(Player_stats.Player_id==player_id,:).variance_ratio_apm4(position)=new_variance4;
    
    Player_stats(Player_stats.Player_id==player_id,:).variance_ratio_apm5(position)=new_variance5;
    Player_stats(Player_stats.Player_id==player_id,:).variance_ratio_apm6(position)=new_variance6;
    Player_stats(Player_stats.Player_id==player_id,:).variance_ratio_apm7(position)=new_variance7;
    Player_stats(Player_stats.Player_id==player_id,:).variance_ratio_apm8(position)=new_variance8;
    
    
    if isempty(position_dagger_val)
        position_dagger_val=0;
    end
    switch position_dagger_val
        case 1
            Player_stats(Player_stats.Player_id==player_id,:).position_dagger1(1)=Player_stats(Player_stats.Player_id==player_id,:).position_dagger1(1)+1;
            Player_stats(Player_stats.Player_id==player_id,:).position_dagger1(position)=Player_stats(Player_stats.Player_id==player_id,:).position_dagger1(position)+1;
        case 2
            Player_stats(Player_stats.Player_id==player_id,:).position_dagger2(1)=Player_stats(Player_stats.Player_id==player_id,:).position_dagger2(1)+1;
            Player_stats(Player_stats.Player_id==player_id,:).position_dagger2(position)=Player_stats(Player_stats.Player_id==player_id,:).position_dagger2(position)+1;
        case 3
            Player_stats(Player_stats.Player_id==player_id,:).position_dagger3(1)=Player_stats(Player_stats.Player_id==player_id,:).position_dagger3(1)+1;
            Player_stats(Player_stats.Player_id==player_id,:).position_dagger3(position)=Player_stats(Player_stats.Player_id==player_id,:).position_dagger3(position)+1;
        case 4
            Player_stats(Player_stats.Player_id==player_id,:).position_dagger4(1)=Player_stats(Player_stats.Player_id==player_id,:).position_dagger4(1)+1;
            Player_stats(Player_stats.Player_id==player_id,:).position_dagger4(position)=Player_stats(Player_stats.Player_id==player_id,:).position_dagger4(position)+1;
        case 5
            Player_stats(Player_stats.Player_id==player_id,:).position_dagger5(1)=Player_stats(Player_stats.Player_id==player_id,:).position_dagger5(1)+1;
            Player_stats(Player_stats.Player_id==player_id,:).position_dagger5(position)=Player_stats(Player_stats.Player_id==player_id,:).position_dagger5(position)+1;
        case 6
            Player_stats(Player_stats.Player_id==player_id,:).position_dagger6(1)=Player_stats(Player_stats.Player_id==player_id,:).position_dagger6(1)+1;
            Player_stats(Player_stats.Player_id==player_id,:).position_dagger6(position)=Player_stats(Player_stats.Player_id==player_id,:).position_dagger6(position)+1;
    end
    
    if isempty(position_glimmer_val)
        position_glimmer_val=0;
    end
    switch position_glimmer_val
        case 1
            Player_stats(Player_stats.Player_id==player_id,:).position_glimmer1(1)=Player_stats(Player_stats.Player_id==player_id,:).position_glimmer1(1)+1;
            Player_stats(Player_stats.Player_id==player_id,:).position_glimmer1(position)=Player_stats(Player_stats.Player_id==player_id,:).position_glimmer1(position)+1;
        case 2
            Player_stats(Player_stats.Player_id==player_id,:).position_glimmer2(1)=Player_stats(Player_stats.Player_id==player_id,:).position_glimmer2(1)+1;
            Player_stats(Player_stats.Player_id==player_id,:).position_glimmer2(position)=Player_stats(Player_stats.Player_id==player_id,:).position_glimmer2(position)+1;
        case 3
            Player_stats(Player_stats.Player_id==player_id,:).position_glimmer3(1)=Player_stats(Player_stats.Player_id==player_id,:).position_glimmer3(1)+1;
            Player_stats(Player_stats.Player_id==player_id,:).position_glimmer3(position)=Player_stats(Player_stats.Player_id==player_id,:).position_glimmer3(position)+1;
        case 4
            Player_stats(Player_stats.Player_id==player_id,:).position_glimmer4(1)=Player_stats(Player_stats.Player_id==player_id,:).position_glimmer4(1)+1;
            Player_stats(Player_stats.Player_id==player_id,:).position_glimmer4(position)=Player_stats(Player_stats.Player_id==player_id,:).position_glimmer4(position)+1;
        case 5
            Player_stats(Player_stats.Player_id==player_id,:).position_glimmer5(1)=Player_stats(Player_stats.Player_id==player_id,:).position_glimmer5(1)+1;
            Player_stats(Player_stats.Player_id==player_id,:).position_glimmer5(position)=Player_stats(Player_stats.Player_id==player_id,:).position_glimmer5(position)+1;
        case 6
            Player_stats(Player_stats.Player_id==player_id,:).position_glimmer6(1)=Player_stats(Player_stats.Player_id==player_id,:).position_glimmer6(1)+1;
            Player_stats(Player_stats.Player_id==player_id,:).position_glimmer6(position)=Player_stats(Player_stats.Player_id==player_id,:).position_glimmer6(position)+1;
    end
    
    if isempty(position_solar_val)
        position_solar_val=0;
    end
    switch position_solar_val
        case 1
            Player_stats(Player_stats.Player_id==player_id,:).position_solar1(1)=Player_stats(Player_stats.Player_id==player_id,:).position_solar1(1)+1;
            Player_stats(Player_stats.Player_id==player_id,:).position_solar1(position)=Player_stats(Player_stats.Player_id==player_id,:).position_solar1(position)+1;
        case 2
            Player_stats(Player_stats.Player_id==player_id,:).position_solar2(1)=Player_stats(Player_stats.Player_id==player_id,:).position_solar2(1)+1;
            Player_stats(Player_stats.Player_id==player_id,:).position_solar2(position)=Player_stats(Player_stats.Player_id==player_id,:).position_solar2(position)+1;
        case 3
            Player_stats(Player_stats.Player_id==player_id,:).position_solar3(1)=Player_stats(Player_stats.Player_id==player_id,:).position_solar3(1)+1;
            Player_stats(Player_stats.Player_id==player_id,:).position_solar3(position)=Player_stats(Player_stats.Player_id==player_id,:).position_solar3(position)+1;
        case 4
            Player_stats(Player_stats.Player_id==player_id,:).position_solar4(1)=Player_stats(Player_stats.Player_id==player_id,:).position_solar4(1)+1;
            Player_stats(Player_stats.Player_id==player_id,:).position_solar4(position)=Player_stats(Player_stats.Player_id==player_id,:).position_solar4(position)+1;
        case 5
            Player_stats(Player_stats.Player_id==player_id,:).position_solar5(1)=Player_stats(Player_stats.Player_id==player_id,:).position_solar5(1)+1;
            Player_stats(Player_stats.Player_id==player_id,:).position_solar5(position)=Player_stats(Player_stats.Player_id==player_id,:).position_solar5(position)+1;
        case 6
            Player_stats(Player_stats.Player_id==player_id,:).position_solar6(1)=Player_stats(Player_stats.Player_id==player_id,:).position_solar6(1)+1;
            Player_stats(Player_stats.Player_id==player_id,:).position_solar6(position)=Player_stats(Player_stats.Player_id==player_id,:).position_solar6(position)+1;
    end
    
    if isempty(position_bkb_val)
        position_bkb_val=0;
    end
    switch position_bkb_val
        case 1
            Player_stats(Player_stats.Player_id==player_id,:).position_bkb1(1)=Player_stats(Player_stats.Player_id==player_id,:).position_bkb1(1)+1;
            Player_stats(Player_stats.Player_id==player_id,:).position_bkb1(position)=Player_stats(Player_stats.Player_id==player_id,:).position_bkb1(position)+1;
        case 2
            Player_stats(Player_stats.Player_id==player_id,:).position_bkb2(1)=Player_stats(Player_stats.Player_id==player_id,:).position_bkb2(1)+1;
            Player_stats(Player_stats.Player_id==player_id,:).position_bkb2(position)=Player_stats(Player_stats.Player_id==player_id,:).position_bkb2(position)+1;
        case 3
            Player_stats(Player_stats.Player_id==player_id,:).position_bkb3(1)=Player_stats(Player_stats.Player_id==player_id,:).position_bkb3(1)+1;
            Player_stats(Player_stats.Player_id==player_id,:).position_bkb3(position)=Player_stats(Player_stats.Player_id==player_id,:).position_bkb3(position)+1;
        case 4
            Player_stats(Player_stats.Player_id==player_id,:).position_bkb4(1)=Player_stats(Player_stats.Player_id==player_id,:).position_bkb4(1)+1;
            Player_stats(Player_stats.Player_id==player_id,:).position_bkb4(position)=Player_stats(Player_stats.Player_id==player_id,:).position_bkb4(position)+1;
        case 5
            Player_stats(Player_stats.Player_id==player_id,:).position_bkb5(1)=Player_stats(Player_stats.Player_id==player_id,:).position_bkb5(1)+1;
            Player_stats(Player_stats.Player_id==player_id,:).position_bkb5(position)=Player_stats(Player_stats.Player_id==player_id,:).position_bkb5(position)+1;
        case 6
            Player_stats(Player_stats.Player_id==player_id,:).position_bkb6(1)=Player_stats(Player_stats.Player_id==player_id,:).position_bkb6(1)+1;
            Player_stats(Player_stats.Player_id==player_id,:).position_bkb6(position)=Player_stats(Player_stats.Player_id==player_id,:).position_bkb6(position)+1;
    end
    
    if isempty(position_forcestaff_val)
        position_forcestaff_val=0;
    end
    switch position_forcestaff_val
        case 1
            Player_stats(Player_stats.Player_id==player_id,:).position_forcestaff1(1)=Player_stats(Player_stats.Player_id==player_id,:).position_forcestaff1(1)+1;
            Player_stats(Player_stats.Player_id==player_id,:).position_forcestaff1(position)=Player_stats(Player_stats.Player_id==player_id,:).position_forcestaff1(position)+1;
        case 2
            Player_stats(Player_stats.Player_id==player_id,:).position_forcestaff2(1)=Player_stats(Player_stats.Player_id==player_id,:).position_forcestaff2(1)+1;
            Player_stats(Player_stats.Player_id==player_id,:).position_forcestaff2(position)=Player_stats(Player_stats.Player_id==player_id,:).position_forcestaff2(position)+1;
        case 3
            Player_stats(Player_stats.Player_id==player_id,:).position_forcestaff3(1)=Player_stats(Player_stats.Player_id==player_id,:).position_forcestaff3(1)+1;
            Player_stats(Player_stats.Player_id==player_id,:).position_forcestaff3(position)=Player_stats(Player_stats.Player_id==player_id,:).position_forcestaff3(position)+1;
        case 4
            Player_stats(Player_stats.Player_id==player_id,:).position_forcestaff4(1)=Player_stats(Player_stats.Player_id==player_id,:).position_forcestaff4(1)+1;
            Player_stats(Player_stats.Player_id==player_id,:).position_forcestaff4(position)=Player_stats(Player_stats.Player_id==player_id,:).position_forcestaff4(position)+1;
        case 5
            Player_stats(Player_stats.Player_id==player_id,:).position_forcestaff5(1)=Player_stats(Player_stats.Player_id==player_id,:).position_forcestaff5(1)+1;
            Player_stats(Player_stats.Player_id==player_id,:).position_forcestaff5(position)=Player_stats(Player_stats.Player_id==player_id,:).position_forcestaff5(position)+1;
        case 6
            Player_stats(Player_stats.Player_id==player_id,:).position_forcestaff6(1)=Player_stats(Player_stats.Player_id==player_id,:).position_forcestaff6(1)+1;
            Player_stats(Player_stats.Player_id==player_id,:).position_forcestaff6(position)=Player_stats(Player_stats.Player_id==player_id,:).position_forcestaff6(position)+1;
    end
    
    if ~isempty(position_actif)
        if position_actif(1)==1
            Player_stats(Player_stats.Player_id==player_id,:).position_actif1(1)=Player_stats(Player_stats.Player_id==player_id,:).position_actif1(1)+1;
            Player_stats(Player_stats.Player_id==player_id,:).position_actif1(position)=Player_stats(Player_stats.Player_id==player_id,:).position_actif1(position)+1;
        end
        if position_actif(2)==1
            Player_stats(Player_stats.Player_id==player_id,:).position_actif2(1)=Player_stats(Player_stats.Player_id==player_id,:).position_actif2(1)+1;
            Player_stats(Player_stats.Player_id==player_id,:).position_actif2(position)=Player_stats(Player_stats.Player_id==player_id,:).position_actif2(position)+1;
        end
        if position_actif(3)==1
            Player_stats(Player_stats.Player_id==player_id,:).position_actif3(1)=Player_stats(Player_stats.Player_id==player_id,:).position_actif3(1)+1;
            Player_stats(Player_stats.Player_id==player_id,:).position_actif3(position)=Player_stats(Player_stats.Player_id==player_id,:).position_actif3(position)+1;
        end
        if position_actif(4)==1
            Player_stats(Player_stats.Player_id==player_id,:).position_actif4(1)=Player_stats(Player_stats.Player_id==player_id,:).position_actif4(1)+1;
            Player_stats(Player_stats.Player_id==player_id,:).position_actif4(position)=Player_stats(Player_stats.Player_id==player_id,:).position_actif4(position)+1;
        end
        if position_actif(5)==1
            Player_stats(Player_stats.Player_id==player_id,:).position_actif5(1)=Player_stats(Player_stats.Player_id==player_id,:).position_actif5(1)+1;
            Player_stats(Player_stats.Player_id==player_id,:).position_actif5(position)=Player_stats(Player_stats.Player_id==player_id,:).position_actif5(position)+1;
        end
        if position_actif(6)==1
            Player_stats(Player_stats.Player_id==player_id,:).position_actif6(1)=Player_stats(Player_stats.Player_id==player_id,:).position_actif6(1)+1;
            Player_stats(Player_stats.Player_id==player_id,:).position_actif6(position)=Player_stats(Player_stats.Player_id==player_id,:).position_actif6(position)+1;
        end
    end
end