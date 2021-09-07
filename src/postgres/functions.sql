create function create_table_from_json(json text, tablename text)
returns void language plpgsql
as $$
begin execute replace(replace(regexp_replace(json,'("[^"]*"):("[^"]*")','    \1 text','g'),
'{', format('create table %s (', tablename)),'}',');'); end $$; 

create function insert_from_json(json text, tablename text)
returns void language plpgsql
as $$
begin execute replace(replace(regexp_replace(json,'("[^"]*"):"([^"]*)"','''\2''', 'g'),
'{', format('insert into %s values (', tablename)), '}', ');'); end $$; 