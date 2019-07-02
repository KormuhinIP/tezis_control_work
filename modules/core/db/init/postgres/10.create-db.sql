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
