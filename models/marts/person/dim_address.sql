with
    address_tb as (
        select
            address_pk
            , address_line_1
            , address_line_2
            , city
            , spatial_location
            , state_province_code
            , state_province_name
            , country_region_code
            , country_name
        from {{ ref('int_address') }}
    )

    , dimension as (
        select
            {{
                dbt_utils.generate_surrogate_key([
                    'address_pk'
                    , 'address_line_1'
                    , 'state_province_code'
                    , 'country_region_code'
                ])
            }} as address_sk
            , address_pk as address_id
            , address_line_1
            , address_line_2
            , city
            , spatial_location
            , state_province_code
            , state_province_name
            , country_region_code
            , country_name
        from address_tb
    )

select *
from dimension
