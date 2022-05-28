function try_process=add_match(conn,match_id,processed)
% try_process is a boolean stating if yes or not we should try to process again
% the match
% processed=0 by default, if it equal 1, it means we have to force
% match_scan to the value 11.
% function should only be called with that value to 1 if data has been
% processed properly
try_process=0;
if processed==0
    selectQ=sprintf('select * from matchs where matchs.match_id=%f' ,match_id);
    match=select(conn,selectQ);
    
    
    if ~isempty(match)
        scan=match.match_scan;
        if scan==0
            fprintf("match of id %d is in database but hasn't been processed yet\n",match_id);
        elseif scan==10
            fprintf("match of id %d is in database but couldn't be processed\n",match_id);
            return
        elseif scan>=11
            fprintf("match of id %d is in database and has been processed\n",match_id);
            return
        else
            fprintf("match of id %d is in database and is currently being processed\n",match_id);
        end
        try_process=1;
        match.match_scan=match.match_scan+1;
        whereclause=sprintf('where matchs.match_id=%f' , match_id);
        update(conn,'matchs',{'match_id','match_scan'},match,whereclause)
        return
    end
    
    try_process=1;
    match=[match;{match_id,0}];
    sqlwrite(conn,'matchs',match);
    return
end

selectQ=sprintf('select * from matchs where matchs.match_id=%f' ,match_id);
match=select(conn,selectQ);
match.match_scan=11;
whereclause=sprintf('where matchs.match_id=%f' , match_id);
update(conn,'matchs',{'match_id','match_scan'},match,whereclause)
return