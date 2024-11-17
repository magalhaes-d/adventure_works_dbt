with
    dimension as (
        select
            address_pk
            , business_entity_fk
            , address_type_name
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

select *
from dimension
