with
    stg_tb as (
        select
            addresstypeid as address_type_pk
            , name as address_type_name
            , rowguid as row_guid
            , modifieddate as modified_date
        from {{ source('adventure_works_erp', 'addresstype') }}
    )

select *
from stg_tb
