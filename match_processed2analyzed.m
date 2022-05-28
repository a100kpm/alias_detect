function match_processed2analyzed(conn,match_id_processed_list,scan_value)
if nargin==2
    scan_value=12;
end
if scan_value<12
    scan_value=12;
end

whereclause={};
data={};
for i=1:length(match_id_processed_list)
    whereclause{end+1}=['where matchs.match_id=',num2str(match_id_processed_list(i))];
    data{end+1}=scan_value;
end
whereclause=whereclause';
data=data';

update(conn,'matchs',{'match_scan'},data,whereclause)