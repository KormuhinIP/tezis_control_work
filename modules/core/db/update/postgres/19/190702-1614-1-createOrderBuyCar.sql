create table TEZISCONTROLWORK_ORDER_BUY_CAR (
    CARD_ID uuid,
    --
    CAR_ID uuid not null,
    CONTRACTOR_ID uuid not null,
    BANK_ID uuid,
    PAYMENT boolean not null,
    --
    primary key (CARD_ID)
);
