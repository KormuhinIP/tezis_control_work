--Add default doc kind for teziscontrolwork$OrderBuyCar
CREATE OR REPLACE FUNCTION baseInsert()
RETURNS integer
AS $$
DECLARE
cnt integer = 0;
BEGIN
cnt = (select count(CATEGORY_ID) from DF_DOC_KIND where category_id = '8fc18490-98d7-4bf5-b6ba-54638c3e316c');
if(cnt = 0) then
    insert into SYS_CATEGORY (ID, NAME, ENTITY_TYPE, IS_DEFAULT, CREATE_TS, CREATED_BY, VERSION, DISCRIMINATOR)
    values ( '8fc18490-98d7-4bf5-b6ba-54638c3e316c', 'Заявка на покупку автомобиля', 'teziscontrolwork$OrderBuyCar', false, now(), USER, 1, 1);

    insert into DF_DOC_KIND (category_id, create_ts, created_by, version, doc_type_id, numerator_id, 
    numerator_type, category_attrs_place, tab_name, portal_publish_allowed, disable_add_process_actors, create_only_by_template)
    values ('8fc18490-98d7-4bf5-b6ba-54638c3e316c', 'now()', 'admin', 1, '84d3aed2-f72a-4d8d-84e7-456c975c9247', '9362475b-3830-41da-adf2-9126a1395dfc', 
    1, 1, 'Р”РѕРї. РїРѕР»СЏ', false, false, false);
end if;return 0;

END;
$$
LANGUAGE plpgsql;
^
select baseInsert();
^
drop function if exists baseInsert()^
