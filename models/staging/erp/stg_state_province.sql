with
    stg_tb as (
        select
            stateprovinceid as state_province_pk
            , countryregioncode as country_region_fk
            , territoryid as territory_fk
            , stateprovincecode as state_province_code
            , isonlystateprovinceflag as is_only_state_province_flag
            , name as state_province_name
            , rowguid as row_guid
            , modifieddate as modified_date
        from {{ source('adventure_works_erp', 'stateprovince') }}
    )

select *
from stg_tb
