function [confiance,flag,position_bkb_val] = bayesien_bkb(table_position_bkb,position_bkb)
confiance=[];
flag=0;
tota=sum(table_position_bkb);
pos = find(position_bkb~=0);
nbr_bkb=size(pos,2);
for i=1:nbr_bkb
    position_bkb_temp=zeros(1,6);
    position_bkb_temp(pos(i))=1;
    ab = (table_position_bkb+position_bkb_temp);
    ab = ab/sum(ab);
    confiance=[confiance;log(ab(pos(i))/(1-ab(pos(i))))];
end

[max_confiance,pos_ordre]=max(confiance);
position_bkb_val=pos(pos_ordre);
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