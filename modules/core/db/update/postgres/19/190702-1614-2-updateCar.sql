-- update TEZISCONTROLWORK_CAR set CAR_BRAND_ID = <default_value> where CAR_BRAND_ID is null ;
alter table TEZISCONTROLWORK_CAR alter column CAR_BRAND_ID set not null ;
