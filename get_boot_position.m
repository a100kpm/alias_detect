function [boot_value,position_boot,nombre_boot] = get_boot_position(item_0,item_1,item_2,item_3,item_4,item_5)

% 214 = tranquil boot
% 29 = brown boot
% 48 = travel
% 220 = travel 2
% 50 = phase boot
% 180 = arcane boot
% 63 = power tread
% 231 = greaves
A =[214,29,48,220,50,180,63,231];
position_item_match=[item_0,item_1,item_2,item_3,item_4,item_5];

[boot_value,pos_boot] = intersect(position_item_match,A);
position_boot=zeros(1,6);
position_boot(pos_boot)=1;
nombre_boot= size(find(position_boot==1),2);