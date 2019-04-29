function [confiance,flag_hero_apm,new_variance] = gaussien_apm(apm_hero,apm,nbr_hero,variance_hero)

%% créer une variance dynamique pour appliquer une gaussienne de proba
%% apm est l'apm du match
variance = variance_hero;
variance = variance + apm_hero*apm_hero; %old apm
variance = variance * (nbr_hero-1);
variance = variance + apm*apm;
variance = variance/(nbr_hero);
new_apm_hero = (apm_hero*(nbr_hero-1)+apm)/nbr_hero;
variance = variance - new_apm_hero*new_apm_hero;
ecart_type=sqrt(variance);


confiance = (1/(ecart_type*sqrt(2*pi)))*exp(-(apm-new_apm_hero)*(apm-new_apm_hero)/(2*variance));
% SEUIL=0.005; %%2 écart_type
SEUIL=0.002; %%3 écart_type
new_variance=variance;
flag_hero_apm=0;

if confiance<=SEUIL
    flag_hero_apm=SEUIL/confiance;
end

%% rajouter un facteur qui fasse plus de détection sur les low apm et moins sur les grosses (changement 30-60 très différent de 330-360)
%% la variance devrait s'en charger tout seul !