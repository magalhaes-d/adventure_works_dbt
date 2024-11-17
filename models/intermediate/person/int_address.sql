with
    business_entity_address as (
        select
            business_entity_fk
            , address_fk
            , address_type_fk
        from {{ ref('stg_business_entity_address') }}
    )

    , address_type as (
        select
            address_type_pk
            , address_type_name
        from {{ ref('stg_address_type') }}
    )

    , address as (
        select
            address_pk
            , state_province_fk
            , address_line_1
            , address_line_2
            , city
            , postal_code
            , spatial_location
        from {{ ref('stg_address') }}
    )

    , state_province as (
        select
            state_province_pk
            , country_region_fk
            , territory_fk
            , state_province_code
            , state_province_name
        from {{ ref('stg_state_province') }}
    )

    , country_region as (
        select
            country_region_pk
            , country_name
        from {{ ref('stg_country_region') }}
    )

    , joinings as (
        select
            address.address_pk
            , business_entity_address.business_entity_fk
            , address_type.address_type_name
            , address.address_line_1
            , address.address_line_2
            , address.city
            , address.spatial_location
            , state_province.state_province_code
            , state_province.state_province_name
            , country_region.country_region_pk as country_region_code
            , country_region.country_name
        from business_entity_address
        left join address_type
            on business_entity_address.address_type_fk = address_type.address_type_pk
        left join address
            on business_entity_address.address_fk = address.address_pk
        left join state_province
            on state_province.state_province_pk = address.state_province_fk
        left join country_region
            on country_region.country_region_pk = state_province.country_region_fk
    )

select *
from joinings