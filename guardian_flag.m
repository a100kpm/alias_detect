function [flag]=guardian_flag(net,net_key,flag)
flag_temp=table2array(flag(:,4:end));
nbr_iter=size(flag,1);
flag_temp(:,2:end)=flag_temp(:,2:end)./net_key;

for i=1:nbr_iter
    flag_temp(i,1)=predict(net,flag_temp(i,2:end));  
end
flag_temp(:,2:end)=flag_temp(:,2:end).*net_key;
flag_temp=array2table(flag_temp);
flag(:,4:end)=flag_temp;
    

















