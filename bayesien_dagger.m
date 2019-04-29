function [confiance,flag,position_dagger_val] = bayesien_dagger(table_position_dagger,position_dagger)
confiance=[];
flag=0;
tota=sum(table_position_dagger);
pos = find(position_dagger~=0);
nbr_boot=size(pos,2);
for i=1:nbr_boot
    position_dagger_temp=zeros(1,6);
    position_dagger_temp(pos(i))=1;
    ab = (table_position_dagger+position_dagger_temp);
    ab = ab/sum(ab);
    confiance=[confiance;log(ab(pos(i))/(1-ab(pos(i))))];
end

[max_confiance,pos_ordre]=max(confiance);
position_dagger_val=pos(pos_ordre);
confiance_random= log((1/6)/(5/6));
% % log((1/6)/(5/6))
% % 
% % ans =
% % 
% %    -1.6094
if max_confiance<confiance_random
    flag=(confiance/confiance_random);
%     rajouter un poid sur le poid du flag pour éviter des aberrations
end