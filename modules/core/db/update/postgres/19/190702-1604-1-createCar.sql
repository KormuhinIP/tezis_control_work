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
);
