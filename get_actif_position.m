function [actif_value,position_actif,nombre_actif] = get_actif_position(item_0,item_1,item_2,item_3,item_4,item_5)

% 1 = dagger
% 34 = magic stick
% 36 = magic wand
% 37 = ghost
% 40 = dust
% 41 = bottle
% 65 = midas
% 79 = mecka
% 86 = buckler
% 90 = pipe
% 96 = hex
% 98 = orchid
% 100 = eul
% 102 = forcestaff
% 104/201/202/203/204 = daggon 1 à 5
% 106/193/194 = necro 1 à 3
% 110 = refresher
% 116 = bkb
% 119 = shiva
% 123 = linken
% 127 = blade mail
% 131 = hood
% 147 = manta
% 151 = armlet
% 152 = shadow blade
% 156 = satanic
% 158 = mjolnir
% 172 = mask of madness
% 185 = jango
% 187 = medaillon
% 190 = veil
% 206 = atos
% 208 = abyssal
% 210 = halberd
% 226 = lotus
% 229 = solar_crest
% 242 = crimsom_guard
% 249 = silver edge
% 250 = bloodthorn
% 254 = glimmer
% 263 = pike
% 178 = soul ring
% 92 = urn of shadow
% 267 = spirit vessel
% 225 = nullifier
% 121 = bloodstone
% 223 = meteor hammer
% 174 = diffusal blade

A =[1,34,36,37,40,41,65,79,86,90,96,98,100,102,104,201,202,203,204,106,193,194,110,116,119,123,127,131,147,...
    151,152,156,158,172,185,187,190,206,208,210,226,229,242,249,250,254,263,178,92,267,225,121,223,174];
position_item_match=[item_0,item_1,item_2,item_3,item_4,item_5];

[actif_value,pos_actif] = intersect(position_item_match,A);
position_actif=zeros(1,6);
position_actif(pos_actif)=1;
nombre_actif= size(find(position_actif==1),2);

