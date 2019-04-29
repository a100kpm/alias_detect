function [position_dagger,nombre_dagger] = get_dagger_position(item_0,item_1,item_2,item_3,item_4,item_5)

% 1 = dagger
A =[1];
position_item_match=[item_0,item_1,item_2,item_3,item_4,item_5];

[dagger_value,pos_dagger] = intersect(position_item_match,A);
position_dagger=zeros(1,6);
position_dagger(pos_dagger)=1;
nombre_dagger= size(find(position_dagger==1),2);