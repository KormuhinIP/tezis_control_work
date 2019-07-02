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
    CAR_BRAND_ID uuid,
    NAME varchar(50) not null,
    DATE_ integer not null,
    CAR_COST decimal(19, 2) not null,
    TYPE_CAR integer not null,
    --
    primary key (CARD_ID)
)^
-- end TEZISCONTROLWORK_CAR

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
-- begin addSecGroupConstraintsForCar
insert into SEC_CONSTRAINT (ID, CREATE_TS, CREATED_BY, ENTITY_NAME, JOIN_CLAUSE, WHERE_CLAUSE, GROUP_ID) values 
('bf8653b2-c4e3-4cfc-93d0-7dd7130474ee', current_timestamp, 'admin', 'teziscontrolwork$Car', ', ts$CardAcl acl', '{E}.id = acl.card.id and (acl.user.id = :session$userId or acl.global = true)', '8e6306e2-9e10-414a-b437-24c91ffef804')^

-- end addSecGroupConstraintsForCar
