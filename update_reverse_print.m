function update_reverse_print(conn,reverse_print)
if ~isempty(reverse_print)
    sqlwrite(conn,'reverseprint',reverse_print)
end