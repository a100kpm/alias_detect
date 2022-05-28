modelfile='model';
net = importKerasNetwork(modelfile);
net_key = csvread('clef.csv');

javaclasspath('C:\Program Files\MATLAB\R2018b\java\jarext\postgresql-42.2.6.jar')
format long g
conn = database('dotaladder','shiba','FTShiBa26','PortNumber',5432,'Server','90.35.1.2','Vendor','PostgreSQL');
conn.Message

selectQ='select * from flag limit 5'
data=select(conn,selectQ)
% write(data,'test_data.csv')

% data=data./net_key
% predict(net,data)