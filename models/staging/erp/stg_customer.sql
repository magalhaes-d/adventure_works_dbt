with
    stg_tb as (
        select
            customerid as customer_pk
            , personid as person_fk
            , storeid as store_fk
            , territoryid as territory_fk
            , rowguid as row_guid
            , modifieddate as modified_date
        from {{ source('adventure_works_erp', 'customer') }}
    )

select *
from stg_tb
