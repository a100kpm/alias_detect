function [confiance,flag,position_solar_val] = bayesien_solar(table_position_solar,position_solar)
confiance=[];
flag=0;
tota=sum(table_position_solar);
pos = find(position_solar~=0);
nbr_solar=size(pos,2);
for i=1:nbr_solar
    position_solar_temp=zeros(1,6);
    position_solar_temp(pos(i))=1;
    ab = (table_position_solar+position_solar_temp);
    ab = ab/sum(ab);
    confiance=[confiance;log(ab(pos(i))/(1-ab(pos(i))))];
end

[max_confiance,pos_ordre]=max(confiance);
position_solar_val=pos(pos_ordre);
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