with
    stg_tb as (
        select
            addressid as address_pk
            , stateprovinceid as state_province_fk
            , addressline1 as address_line_1
            , addressline2 as address_line_2
            , city as city
            , postalcode as postal_code
            , spatiallocation as spatial_location
            , rowguid as row_guid
            , modifieddate as modified_date
        from {{ source('adventure_works_erp', 'address') }}
    )

select *
from stg_tb
