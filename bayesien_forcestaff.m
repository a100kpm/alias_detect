function [confiance,flag,position_forcestaff_val] = bayesien_forcestaff(table_position_forcestaff,position_forcestaff)
confiance=[];
flag=0;
tota=sum(table_position_forcestaff);
pos = find(position_forcestaff~=0);
nbr_forcestaff=size(pos,2);
for i=1:nbr_forcestaff
    position_forcestaff_temp=zeros(1,6);
    position_forcestaff_temp(pos(i))=1;
    ab = (table_position_forcestaff+position_forcestaff_temp);
    ab = ab/sum(ab);
    confiance=[confiance;log(ab(pos(i))/(1-ab(pos(i))))];
end

[max_confiance,pos_ordre]=max(confiance);
position_forcestaff_val=pos(pos_ordre);
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