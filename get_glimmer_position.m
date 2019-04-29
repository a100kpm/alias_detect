function [position_glimmer,nombre_glimmer] = get_glimmer_position(item_0,item_1,item_2,item_3,item_4,item_5)

% 254 = glimmer
A =[254];
position_item_match=[item_0,item_1,item_2,item_3,item_4,item_5];

[glimmer_value,pos_glimmer] = intersect(position_item_match,A);
position_glimmer=zeros(1,6);
position_glimmer(pos_glimmer)=1;
nombre_glimmer= size(find(position_glimmer==1),2);