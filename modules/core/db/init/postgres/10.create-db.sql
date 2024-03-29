-- begin TEZISCONTROLWORK_CAR_BRAND
create table TEZISCONTROLWORK_CAR_BRAND (
    ID uuid,
    CREATE_TS timestamp,
    CREATED_BY varchar(50),
    VERSION integer,
    UPDATE_TS timestamp,
    UPDATED_BY varchar(50),
    DELETE_TS timestamp,
    DELETED_BY varchar(50),
    --
    NAME varchar(50) not null,
    CODE varchar(3) not null,
    NOTE varchar(4000),
    --
    primary key (ID)
)^
-- end TEZISCONTROLWORK_CAR_BRAND
-- begin TEZISCONTROLWORK_CAR
create table TEZISCONTROLWORK_CAR (
    CARD_ID uuid,
    --
    NUMBER_ varchar(50),
    CAR_BRAND_ID uuid not null,
    NAME varchar(50) not null,
    DATE_ integer not null,
    CAR_COST decimal(19, 2) not null,
    TYPE_CAR integer not null,
    --
    primary key (CARD_ID)
)^-- end TEZISCONTROLWORK_CAR
--Add default numerator for teziscontrolwork$Car
CREATE OR REPLACE FUNCTION baseInsert()
RETURNS integer
AS $$
DECLARE
    cnt integer = 0;
BEGIN
cnt = (select count(id) from DF_NUMERATOR where CODE = 'CarNumerator' and delete_ts is null);
if(cnt = 0) then
    INSERT INTO DF_NUMERATOR (ID, CREATE_TS, CREATED_BY, VERSION, CODE, NUMERATOR_FORMAT, SCRIPT_ENABLED,
    PERIODICITY, NUMBER_INITIAL_VALUE, LOC_NAME)
    VALUES ('21007c90-198b-4476-8651-375d00b1c1dd', now(), 'system', 1, 'CarNumerator', 'CR-[number]', FALSE, 'Y', 1,
    '{"captionWithLanguageList":[{"language":"ru","caption":"Car"},{"language":"en","caption":"Car"}]}'
    );
end if;

return 0;
END;
$$
LANGUAGE plpgsql;
^

select baseInsert()^
drop function if exists baseInsert()^
-- begin TEZISCONTROLWORK_ORDER_BUY_CAR
create table TEZISCONTROLWORK_ORDER_BUY_CAR (
    CARD_ID uuid,
    --
    CAR_ID uuid not null,
    CONTRACTOR_ID uuid not null,
    BANK_ID uuid,
    PAYMENT boolean not null,
    --
    primary key (CARD_ID)
)^
-- end TEZISCONTROLWORK_ORDER_BUY_CAR

--Add default numerator for teziscontrolwork$OrderBuyCar
CREATE OR REPLACE FUNCTION baseInsert()
RETURNS integer
AS $$
DECLARE
    cnt integer = 0;
BEGIN
cnt = (select count(id) from DF_NUMERATOR where CODE = 'OrderBuyCarNumerator' and delete_ts is null);
if(cnt = 0) then
    INSERT INTO DF_NUMERATOR (ID, CREATE_TS, CREATED_BY, VERSION, CODE, NUMERATOR_FORMAT, SCRIPT_ENABLED,
    PERIODICITY, NUMBER_INITIAL_VALUE, LOC_NAME)
    VALUES ('eff09455-3889-4177-b465-6333d48e47ef', now(), 'system', 1, 'OrderBuyCarNumerator', 'OBC-[number]', FALSE, 'Y', 1,
    '{"captionWithLanguageList":[{"language":"ru","caption":"OrderBuyCar"},{"language":"en","caption":"OrderBuyCar"}]}'
    );
end if;

return 0;
END;
$$
LANGUAGE plpgsql;
^

select baseInsert()^
drop function if exists baseInsert()^
--Insert new doc type for teziscontrolwork$OrderBuyCar
insert into TS_CARD_TYPE (ID, CREATE_TS, CREATED_BY, NAME, DISCRIMINATOR,FIELDS_XML) values ('84d3aed2-f72a-4d8d-84e7-456c975c9247', current_timestamp, 'admin', 'teziscontrolwork$OrderBuyCar', 1100, '')^
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
--Update process card_types for entity teziscontrolwork$OrderBuyCar
update wf_proc set card_types = regexp_replace(card_types, E',teziscontrolwork\\$OrderBuyCar', '') where code in ('Endorsement','Resolution','Acquaintance','Registration')^
update wf_proc set updated_by='admin', card_types = card_types || 'teziscontrolwork$OrderBuyCar,' where code in ('Endorsement','Resolution','Acquaintance','Registration')^
--Update security for entity teziscontrolwork$OrderBuyCar

-- begin addSecGroupConstraintsForOrderBuyCar
insert into SEC_CONSTRAINT (ID, CREATE_TS, CREATED_BY, ENTITY_NAME, JOIN_CLAUSE, WHERE_CLAUSE, GROUP_ID) values 
('127dc8ab-4125-41ca-b5aa-ba3c06c9aa55', current_timestamp, 'admin', 'teziscontrolwork$OrderBuyCar', ', ts$CardAcl acl', '{E}.id = acl.card.id and (acl.user.id = :session$userId or acl.global = true)', '8e6306e2-9e10-414a-b437-24c91ffef804')^
insert into SEC_CONSTRAINT (ID, CREATE_TS, CREATED_BY, ENTITY_NAME, JOIN_CLAUSE, WHERE_CLAUSE, GROUP_ID) values 
('71fe6db5-4e38-4a13-9571-18d338df900b', current_timestamp, 'admin', 'teziscontrolwork$OrderBuyCar', ', ts$CardAcl acl', '{E}.id = acl.card.id and (acl.user.id = :session$userId or acl.department.id in (:session$departmentIds) or acl.global = true)', '8d9ba07c-9ffa-11e1-b99d-8fc5b41c7fbb')^
insert into SEC_CONSTRAINT (ID, CREATE_TS, CREATED_BY, ENTITY_NAME, JOIN_CLAUSE, WHERE_CLAUSE, GROUP_ID) values 
('619043ff-c3cc-4cb8-a56c-59c98757363d', current_timestamp, 'admin', 'teziscontrolwork$OrderBuyCar', ', ts$CardAcl acl', '{E}.id = acl.card.id and (acl.user.id = :session$userId or acl.department.id in (:session$departmentIds) or acl.global = true)', '9fa89a54-9ffa-11e1-b13e-9f4a54bff17e')^
insert into SEC_CONSTRAINT (ID, CREATE_TS, CREATED_BY, ENTITY_NAME, JOIN_CLAUSE, WHERE_CLAUSE, GROUP_ID) values 
('141dae15-be89-45c9-af70-57b622dd0bd0', current_timestamp, 'admin', 'teziscontrolwork$OrderBuyCar', ', ts$CardAcl acl', '{E}.id = acl.card.id and (acl.user.id = :session$userId or acl.global = true)', '9e44a053-a31f-4edd-b19b-39e942161dd2')^
insert into SEC_CONSTRAINT (ID, CREATE_TS, CREATED_BY, ENTITY_NAME, JOIN_CLAUSE, WHERE_CLAUSE, GROUP_ID) values 
('3d00ed18-f8dc-46aa-ac57-f9372f666691', current_timestamp, 'admin', 'teziscontrolwork$OrderBuyCar', 'join {E}.aclList acl', '({E}.docOfficeData.officeFile.state >= 30 and {E}.template = false or (acl.user.id = :session$userId or acl.global = true))', 'cff945e4-e363-0dc0-d70d-4b5bdb2a2269')^

-- end addSecGroupConstraintsForOrderBuyCar

insert into SEC_PERMISSION (ID, CREATE_TS, CREATED_BY, VERSION, UPDATE_TS, UPDATED_BY, DELETE_TS, DELETED_BY, PERMISSION_TYPE, TARGET, VALUE, ROLE_ID) values (newid(),now(),'system',1,now(),null,null,null,20,'teziscontrolwork$OrderBuyCar:create',0,(select ID from SEC_ROLE where NAME = 'SimpleUser'));
insert into SEC_PERMISSION (ID, CREATE_TS, CREATED_BY, VERSION, UPDATE_TS, UPDATED_BY, DELETE_TS, DELETED_BY, PERMISSION_TYPE, TARGET, VALUE, ROLE_ID) values (newid(),now(),'system',1,now(),null,null,null,20,'teziscontrolwork$OrderBuyCar:update',0,(select ID from SEC_ROLE where NAME = 'SimpleUser'));
insert into SEC_PERMISSION (ID, CREATE_TS, CREATED_BY, VERSION, UPDATE_TS, UPDATED_BY, DELETE_TS, DELETED_BY, PERMISSION_TYPE, TARGET, VALUE, ROLE_ID) values (newid(),now(),'system',1,now(),null,null,null,20,'teziscontrolwork$OrderBuyCar:delete',0,(select ID from SEC_ROLE where NAME = 'SimpleUser'));
insert into SEC_PERMISSION (ID, CREATE_TS, CREATED_BY, VERSION, UPDATE_TS, UPDATED_BY, DELETE_TS, DELETED_BY, PERMISSION_TYPE, TARGET, VALUE, ROLE_ID) values (newid(),now(),'system',1,now(),null,null,null,20,'teziscontrolwork$OrderBuyCar:create',1,(select ID from SEC_ROLE where NAME = 'Administrators'));
insert into SEC_PERMISSION (ID, CREATE_TS, CREATED_BY, VERSION, UPDATE_TS, UPDATED_BY, DELETE_TS, DELETED_BY, PERMISSION_TYPE, TARGET, VALUE, ROLE_ID) values (newid(),now(),'system',1,now(),null,null,null,20,'teziscontrolwork$OrderBuyCar:update',1,(select ID from SEC_ROLE where NAME = 'Administrators'));
insert into SEC_PERMISSION (ID, CREATE_TS, CREATED_BY, VERSION, UPDATE_TS, UPDATED_BY, DELETE_TS, DELETED_BY, PERMISSION_TYPE, TARGET, VALUE, ROLE_ID) values (newid(),now(),'system',1,now(),null,null,null,20,'teziscontrolwork$OrderBuyCar:delete',1,(select ID from SEC_ROLE where NAME = 'Administrators'));
insert into SEC_PERMISSION (ID, CREATE_TS, CREATED_BY, VERSION, UPDATE_TS, UPDATED_BY, DELETE_TS, DELETED_BY, PERMISSION_TYPE, TARGET, VALUE, ROLE_ID) values (newid(),now(),'system',1,now(),null,null,null,20,'teziscontrolwork$OrderBuyCar:create',1,(select ID from SEC_ROLE where NAME = 'doc_initiator'));
insert into SEC_PERMISSION (ID, CREATE_TS, CREATED_BY, VERSION, UPDATE_TS, UPDATED_BY, DELETE_TS, DELETED_BY, PERMISSION_TYPE, TARGET, VALUE, ROLE_ID) values (newid(),now(),'system',1,now(),null,null,null,20,'teziscontrolwork$OrderBuyCar:update',1,(select ID from SEC_ROLE where NAME = 'doc_initiator'));
insert into SEC_PERMISSION (ID, CREATE_TS, CREATED_BY, VERSION, UPDATE_TS, UPDATED_BY, DELETE_TS, DELETED_BY, PERMISSION_TYPE, TARGET, VALUE, ROLE_ID) values (newid(),now(),'system',1,now(),null,null,null,20,'teziscontrolwork$OrderBuyCar:delete',1,(select ID from SEC_ROLE where NAME = 'doc_initiator'));
