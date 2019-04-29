function [position_bkb,nombre_bkb] = get_bkb_position(item_0,item_1,item_2,item_3,item_4,item_5)

% 116 = bkb
A =[116];
position_item_match=[item_0,item_1,item_2,item_3,item_4,item_5];

[bkb_value,pos_bkb] = intersect(position_item_match,A);
position_bkb=zeros(1,6);
position_bkb(pos_bkb)=1;
nombre_bkb= size(find(position_bkb==1),2);