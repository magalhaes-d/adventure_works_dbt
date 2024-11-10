with
    stg_tb as (
        select
            businessentityid as business_entity_fk
            , name as store_name
            , salespersonid as salesperson_fk
            , demographics as demographics
            , rowguid as row_guid
            , modifieddate as modified_date
        from {{ source('adventure_works_erp', 'store') }}
    )

select *
from stg_tb
