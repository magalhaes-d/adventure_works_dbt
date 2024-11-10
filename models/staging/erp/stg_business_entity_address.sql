with
    stg_tb as (
        select
            businessentityid as business_entity_fk
            , addressid as address_fk
            , addresstypeid as address_type_fk
            , rowguid as row_guid
            , modifieddate as modified_date
        from {{ source('adventure_works_erp', 'businessentityaddress') }}
    )

select *
from stg_tb
