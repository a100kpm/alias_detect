function [confiance,flag] = bayesien_actif(table_position_actif,position_actif)
confiance=[];
proba=[];
flag=0;
tota=sum(table_position_actif);
pos = find(position_actif~=0);
nbr_actif=size(pos,2);
combinaison = nchoosek(6,nbr_actif);
table_position_actif_temp=table_position_actif;

%% éventuellement, il faudra rajouter des pondérations sur les confiancesX

if nbr_actif==0
    confiance = inf;
end

if nbr_actif==1
    position_actif_temp=zeros(1,6);
    position_actif_temp(pos)=1;
    ab = (table_position_actif+position_actif_temp);
    ab = ab/sum(ab);
    confiance=log(ab(pos)/(1-ab(pos)));
end

if nbr_actif==2
    for i=1:nbr_actif
        position_actif_temp=zeros(1,6);
        position_actif_temp(pos(i))=1;
        ab = (table_position_actif+position_actif_temp);
        ab = ab/sum(ab);
        proba=[proba;ab(pos(i))];
    end
    confiance=3/(1/proba(1)+1/proba(2));
    test = nthroot(proba(1)*proba(2),2);
    confiance=log(confiance/(1-confiance));
    test=log(test/(1-test));
    confiance=(confiance+test)/2;
end


if nbr_actif==3
    for i=1:nbr_actif
        position_actif_temp=zeros(1,6);
        position_actif_temp(pos(i))=1;
        ab = (table_position_actif+position_actif_temp);
        ab = ab/sum(ab);
        proba=[proba;ab(pos(i))];
    end
    confiance=3/(1/proba(1)+1/proba(2)+1/proba(3));
    test = nthroot(proba(1)*proba(2)*proba(3),3);
    confiance=log(confiance/(1-confiance));
    test=log(test/(1-test));
    confiance=(confiance+test)/2;
end



if nbr_actif==4
    for i=1:nbr_actif
        position_actif_temp=zeros(1,6);
        position_actif_temp(pos(i))=1;
        ab = (table_position_actif+position_actif_temp);
        ab = ab/sum(ab);
        proba=[proba;ab(pos(i))];
    end
    confiance=3/(1/proba(1)+1/proba(2)+1/proba(3));
    test = nthroot(proba(1)*proba(2)*proba(3)*proba(4),4);
    confiance=log(confiance/(1-confiance));
    test=log(test/(1-test));
    confiance=(confiance+test)/2;
end

if nbr_actif==5
    confiance = inf;
    %% trop dépendant des boots dans ce cas là
    %% on peut envisager de qd même le prendre en compte, à voir
end

if nbr_actif==6
    confiance = inf;
end


% [max_confiance,pos_ordre]=max(confiance);
% position_boot_val=pos(pos_ordre);


confiance_random= log((1/combinaison)/((combinaison-1)/combinaison));

if confiance<confiance_random
    flag=(confiance/confiance_random);
end