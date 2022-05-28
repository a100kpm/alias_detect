function fake_flag=epuration_data(fake_flag)

nbr_iter=height(fake_flag);
for i=1:nbr_iter
    if mod(i,10000)==0
        disp(i)
    end
    val=sum(table2array(fake_flag(i,5:end))>0);
    if val<3
        fake_flag.flag_global(i,:)=2;
%     if sum(fake_flag{i,5:end})<3
%         fake_flag.flag_global(i,:)=2;
    end
end

fake_flag(fake_flag.flag_global==2,:)=[];


% tu peux peut être remplir une array simple de 1 100 000
% et après de faire un fake_flag.flag_global=array
% deja ca devrait alleger le truc

























