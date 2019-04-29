function [position_solar,nombre_solar] = get_solar_position(item_0,item_1,item_2,item_3,item_4,item_5)

% 229 = solar_crest
% 187 = medallion_of_courage
A =[229,187];
position_item_match=[item_0,item_1,item_2,item_3,item_4,item_5];

[solar_value,pos_solar] = intersect(position_item_match,A);
position_solar=zeros(1,6);
position_solar(pos_solar)=1;
nombre_solar= size(find(position_solar==1),2);