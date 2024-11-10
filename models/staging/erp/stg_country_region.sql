with
    stg_tb as (
        select
            countryregioncode as country_region_pk
            , name as country_name
            , modifieddate as modified_date
        from {{ source('adventure_works_erp', 'countryregion') }}
    )

select *
from stg_tb
