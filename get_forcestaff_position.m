function [position_forcestaff,nombre_forcestaff] = get_forcestaff_position(item_0,item_1,item_2,item_3,item_4,item_5)

% 102 = forcestaff
% 263 = pike
A =[102,263];
position_item_match=[item_0,item_1,item_2,item_3,item_4,item_5];

[forcestaff_value,pos_forcestaff] = intersect(position_item_match,A);
position_forcestaff=zeros(1,6);
position_forcestaff(pos_forcestaff)=1;
nombre_forcestaff= size(find(position_forcestaff==1),2);