function update_flag(conn,flag)
if ~isempty(flag)
    sqlwrite(conn,'flag',flag)
end